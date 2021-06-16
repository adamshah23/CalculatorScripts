#creates a class that will read in tokens given from the user, and give them a certain kind or value, for he calculator to intrepret
class Scanner 

    def initialize
        @str = STDIN.gets
    end
    
    
    def next_token  
        num = 1
            if (!@str.empty?)
                if (@str.match(/(^[a-zA-Z][a-zA-Z0-9_]*)/)) 
                        if(@str[0..3].strip.eql?("sqrt"))
                            token = Token.new("key", "sqrt")
                            num = 4
                        elsif (@str[0..4].strip.eql?("list")) 
                            token = Token.new("key", "list")
                            num = 4
                        elsif (@str[0..2].strip.eql?("cos")) 
                            token = Token.new("key", "cos")
                            num = 3
                        elsif (@str[0..2].strip.eql?("sin")) 
                            token = Token.new("key", "sin")
                            num = 3
                        elsif (@str[0..2].strip.eql?("tan")) 
                            token = Token.new("key", "tan")
                            num = 3
                        elsif (@str[0..2].strip.eql?("log")) 
                            token = Token.new("key", "log")
                            num = 3
                        elsif (@str[0..3].strip.eql?("quit"))
                            token = Token.new("key", "quit")
                            num = 4
                        elsif (@str[0..5].strip.eql?("clear"))
                            token = Token.new("key", "clear")
                            num = 5
                        elsif (@str[0..3].strip.eql?("exit"))
                            token = Token.new("key", "exit")  
                            num = 4
                        else
                            token = Token.new("ID:", Regexp.last_match(1))
                            num = Regexp.last_match(1).length
                        end

                elsif (@str.match(/^(\d+\.?\d*((e|E)-?)?\d*)/)) 
                    token = Token.new("Number:", Regexp.last_match(1))
                    num = Regexp.last_match(1).length

                elsif (@str[0].eql?("+"))
                    token = Token.new("plus:", "+")

                elsif (@str[0].eql?("="))
                    token = Token.new("equals:", "=")

                elsif (@str[0].eql?("/"))
                    token = Token.new("divide:", "/")

                elsif (@str[0].eql?("*") && !@str[1].eql?("*"))
                    token = Token.new("multipy:", "*")

                elsif (@str[0].eql?("-"))
                    token = Token.new("minus:", "-")

                elsif (@str[0..1].eql?("**"))
                    token = Token.new("power:", "**")
                    num =  2

                elsif (@str[0].eql?("("))
                    token = Token.new("lparan:", "(")

                elsif (@str[0].eql?(")"))
                    token = Token.new("rparan:", ")")

                elsif (@str[0].eql?("\n"))
                    token = Token.new("EOL", "End of Line")
    
                elsif (@str[0].eql?("\s") || @str[0].eql?("\t"))
                    @str = @str[1..]
                    return next_token
                end

            else
                @str = STDIN.gets
                return next_token
            end

        @str = @str[num..]
        return token

    end

end


class Token

    def initialize(kind, str)
        @kind = kind
        @str = str
    end


    def kind 
        @kind
    end


    def value 
        @str.to_s

    end


    def to_s
         @kind.to_s + " " + @str.to_s

    end

end


