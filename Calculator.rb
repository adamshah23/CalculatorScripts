#creates a class that inherits what the scanner class makes, and then excutes it for the user
load "Scanner.rb"

class Calculator 

    def initialize
        @scan = Scanner.new
        @curr_token = nil
        @fut_token = nil
        @dict = {}
        @dict["PI"] = Math::PI

    end

    #this is using recursive decent thats given through regular expression grammars (statement, expr, term, power, and factor)
    def statement
        @curr_token = @scan.next_token
        if (@curr_token.kind == "ID:") 
            @fut_token = @scan.next_token
 
            if (@fut_token.value == "=")
                id = @curr_token.value
                @curr_token = @scan.next_token
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end
                value = exp()
                dict[id] = value.to_f
        
            elsif (@dict.key?(@curr_token.value) && @fut_token.kind == "EOL")
                puts @curr_token.value + " is defined as " + @dict[@curr_token.value].to_s

            else
                puts exp()
            end
            
        elsif (@curr_token.kind == "EOL")
            return nil

        elsif (@curr_token.value == "clear")
            @fut_token = @scan.next_token
            if (@dict.key?(@fut_token.value))
                dict.delete(@fut_token.value)
                puts "the assignment " + @fut_token.value + " has been deleted"
            else
                puts @fut_token.value + " is not an already given assignment and cannot be deleted"
            end
            @fut_token = @scan.next_token

        elsif (@curr_token.value == "list")
            @dict.each {|id,value|
                puts id + " => " + value.to_s
            }
            @fut_token = @scan.next_token
        elsif (@curr_token.value == "quit" || @curr_token.value == "exit")
            puts "Exiting this program now!\n       ----------    "
            exit
        else
            puts exp()
        end
         return nil
         
    end
 
    def exp(acc=nil) 
      
        if (acc != nil) 
            value = acc
        end
        value = term(acc)
                
        while (true)
            
            if (@fut_token.value == "+")
                @curr_token = @scan.next_token
                value2 = term()
                value = value.to_f + value2.to_f
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end
        
            elsif (@fut_token.value == "-")
                @curr_token = @scan.next_token
                value2 = term()
                value = value.to_f - value2.to_f
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end
                
            else
                return value
            end
        end
    end

    def term(acc=nil)
        
        if (acc != nil) 
            value = acc
        end
            value = power(acc)
        
        while (true)
            if (@fut_token.value == "*")
                @curr_token = @scan.next_token
                value2 = power()
                value = value.to_f * value2.to_f
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end

            elsif (@fut_token.value == "/")
                @curr_token = @scan.next_token
                value2 = power() 
                value = value.to_f / value2.to_f
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end

            else
                return value
            end
        end

    end

    def power(acc=nil)

        if (acc != nil) 
            value = acc
        else
            value = factor()
        end

        while (true)
            if (@fut_token.value == "**")
                @curr_token = @scan.next_token
                value2 = factor()
                value = value.to_f ** value2.to_f
                if (@curr_token.kind == "ID:")
                    @fut_token = @scan.next_token
                end

            else
                return value
            end
        end
    end

    def factor() 
        if (@curr_token.kind == "ID:")
            if (!@dict.key?(@curr_token.value))
                puts @curr_token.value + " not defined"
            else 
                puts @curr_token.value + " is now assigned"
                return @dict[@curr_token.value]
            end
            
        elsif (@curr_token.kind == "Number:")
            @fut_token = @scan.next_token
            return @curr_token.value

        elsif (@curr_token.value == "(") 
            @curr_token = @scan.next_token
            value = exp()
            @fut_token = @scan.next_token
            while (@fut_token.kind != "EOL" && @fut_token.value != ")") 
                value = exp(value)
            end      
            return value

        elsif (@curr_token.value == "sqrt")
            @curr_token = @scan.next_token
            @curr_token = @scan.next_token
            val = exp()
            @fut_token = @scan.next_token
            return Math.sqrt(val.to_f)

        elsif (@curr_token.value == "cos") 
            @curr_token = @scan.next_token
            @curr_token = @scan.next_token
            val = exp()
            @fut_token = @scan.next_token
            return Math.cos(val.to_f)

        elsif (@curr_token.value == "sin") 
            @curr_token = @scan.next_token
            @curr_token = @scan.next_token
            val = exp()
            @fut_token = @scan.next_token
            return Math.sin(val.to_f)

        elsif (@curr_token.value == "tan") 
            @curr_token = @scan.next_token
            @curr_token = @scan.next_token
            val = exp()
            @fut_token = @scan.next_token
            return Math.tan(val.to_f)

        elsif (@curr_token.value == "log") 
            @curr_token = @scan.next_token
            @curr_token = @scan.next_token
            val = exp()
            @fut_token = @scan.next_token
            return Math.log(val.to_f)
                
        else
            @fut_token = @scan.next_token
            return @curr_token.value
        end
    end

    def calc  
        output = statement()
    end
end

#to get it running till it hits quit or exit
puts "Welcome to my Calculator! \n       ----------    "
puts "Try calculating something or type quit/exit to end this program!\n"
test1 = Calculator.new
loop do 
    test1.calc
end


