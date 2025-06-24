# BooleanExpressionEvaluatorA.rb
#

class BooleanExpressionEvaluatorA

    attr_accessor  :booleanExpression, :dataDictionary, :postToken, :leftOperand, :currentTokenIndex

    # Constructor

    def initialize(booleanExpression, dataDictionary)
    
        begin

            @booleanExpression = Array.new

            @tempExpression = booleanExpression.split(/(?<=[\!\[\]\)])/).map(&:strip)

            puts "Parsed boolean expression #{@tempExpression}" if $INFO

            for token in @tempExpression do

                puts "Token: #{token}"
                if token.upcase.start_with?("AND")

                    puts "!!!! AND"
                    @booleanExpression.push("AND")
                    token = (token.split("AND", 2).map(&:strip))[1]

                elsif token.upcase.start_with?("OR")

                    @booleanExpression.push("OR")
                    token = (token.split("OR", 2).map(&:strip))[1]
                end

                @booleanExpression.push(token)

            end

            @dataDictionary = dataDictionary
            @postToken = ""
            @leftOperand = ""
            @currentTokenIndex = -1

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end


    def evaluateBooleanExpression

        begin

            leftBoolResult = false

            leftBoolResult = evaluateOrExpression

            if @postToken == ";"

                return leftBoolResult
            else
                raise "ERROR: missing end of boolean expression token - ; in #{@booleanExpression}"
            end 

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end


    # Protected methods

    protected


    def evaluateOrExpression

        begin

            leftBoolResult = false
            rightBoolResult = false 

            leftBoolResult = evaluateAndExpression

            while (@postToken == "OR") do

                rightBoolResult = evaluateAndExpression

                if ((leftBoolResult == true) || (rightBoolResult == true))

                    leftBoolResult = true
                else
                    leftBoolResult = false
                end

            end

            return leftBoolResult

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #e{message}"
            raise e
        end

    end


    def evaluateAndExpression

        begin

            leftBoolResult = false
            rightBoolResult = false 

            leftBoolResult = evaluateSubCondition

            while (@postToken == "AND") do

                rightBoolResult = evaluateAndExpression

                if ((leftBoolResult == true) && (rightBoolResult == true))

                    leftBoolResult = true
                else
                    leftBoolResult = false
                end

            end

            return leftBoolResult

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #e{message}"
            raise e
        end

    end

    def evaluateSubCondition

        begin

            leftBoolResult = false
            isNotExpression = false

            @leftOperand = nextTokenInExpression

            if @leftOperand == "!"

                isNotExpression = true
                puts "NNNNNNNOOOOOOTTTT"
                @leftOperand = nextTokenInExpression
                puts "IS NOT EXPRESSION = #{isNotExpression}"

            end  

            if @leftOperand == "["

                leftBoolResult = evaluateOrExpression

                if @postToken == "]"

                    puts "IS NOT EXPRESSION = #{isNotExpression}"
                    if isNotExpression == true 

                        if leftBoolResult == true

                            leftBoolResult = false
                        else 
                            leftBoolResult = true
                        end

                        isNotExpression = false
                    end

                    @postToken = nextTokenInExpression
                
                else
                    raise "ERROR: Missing right parenthesis in #{@booleanExpression}"

                end
                
            else

                expressionResult = evaluateConstruct

                puts "#{@booleanExpression} is #{expressionResult}" if $INFO

                if expressionResult == true

                    @postToken = nextTokenInExpression
                    leftBoolResult = true

                else 
                   
                    @postToken = nextTokenInExpression
                    leftBoolResult = false

                end

            end

            return leftBoolResult

        rescue => e
            # Catch, log and raise all exceptions.
            
            puts "ERROR: #e{message}"
            raise e

        end

    end


    def nextTokenInExpression

        begin

            needAToken = true

            while (needAToken == true)

                @currentTokenIndex = @currentTokenIndex + 1
                currentToken = @booleanExpression[@currentTokenIndex]

                puts "Evaluating expression token: #{currentToken}" if $INFO

                if currentToken != ""

                    needAToken = false
                end

            end 

            return currentToken
        
        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end

    end


    def evaluateConstruct; raise "BooleanExpressionEvaluatorA is an abstract class."; end
end 