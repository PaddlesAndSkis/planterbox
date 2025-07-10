# PlanterboxBooleanExpressionEvaluatorC.rb

require_relative "BooleanExpressionEvaluatorA.rb"
require_relative "PlanterboxIsConditionConstructC.rb"
require_relative "PlanterboxContainsConditionConstructC.rb"
require_relative "PlanterboxLessThanConditionConstructC.rb"
require_relative "PlanterboxGreaterThanConditionConstructC.rb"

require_relative "PlanterboxSetActionConstructC.rb"


class PlanterboxBooleanExpressionEvaluatorC < BooleanExpressionEvaluatorA 

    # Constructor

    def initialize(booleanExpression, dataDictionary)

        begin

            super(booleanExpression, dataDictionary)

            @conditionConstructLibrary = Hash.new
            @conditionConstructLibrary["IS"]   = PlanterboxIsConditionConstructC.new
            @conditionConstructLibrary["CONTAINS"] = PlanterboxContainsConditionConstructC.new
            @conditionConstructLibrary["LESSTHAN"] = PlanterboxLessThanConditionConstructC.new
            @conditionConstructLibrary["GREATERTHAN"] = PlanterboxGreaterThanConditionConstructC.new


        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end


    def evaluateConstruct

        begin

            # api is finance     cam is_not here

            puts "LeftOperand = #{@leftOperand}"
            constructComponents = @leftOperand.split(" ", 3)
            subjectComponent = constructComponents[0].delete('()').strip
            verbComponent = constructComponents[1].upcase.delete('()').strip
            predicateComponent = constructComponents[2].delete('()').strip

            puts "subject: #{subjectComponent}"
            puts "verb: #{verbComponent}"
            puts "predicate: #{predicateComponent}"

            conditionHash = Hash.new
            conditionHash["keyword"] = subjectComponent
            conditionHash["value"]   = predicateComponent

            return @conditionConstructLibrary[verbComponent].evaluate(@dataDictionary, conditionHash)

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "EdfdfRROR: #{e.message}"
            raise e
        end


    end

end
