# PlanterboxBOC.rb
#
# This is the Planterbox Business Object.

# Import libraries.

require_relative "PlanterboxTOC.rb"
require_relative "PlanterboxDAOC.rb"
require_relative "PlanterboxBooleanExpressionEvaluatorC.rb"
require_relative "Actions/PlanterboxActionEvaluatorConstructC.rb"

class PlanterboxBOC

    # Constructor

    def initialize(planterboxTO)

        begin
            @planterboxTO = planterboxTO
            @ruleArray = Array.new

            # Add the ruleArray to the Transfer Object.

            @planterboxTO.ruleArray = @ruleArray


            @thisClass = "PlanterboxBOC"

        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end


    # plant 

    def plant

        begin
            puts "#{@thisClass}:plant" if $INFO

            # Load Rules file.

            loadRules

            # Apply Rules.

            applyRules

        rescue => e

            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end
    end


    def loadRules

        begin
            puts "#{@thisClass}:loadRules" if $INFO

            planterboxDAO = PlanterboxDAOC.new(@planterboxTO)
            @planterboxTO = planterboxDAO.loadPlanterbox

            @ruleArray = @planterboxTO.ruleArray

            puts "loadedRules = #{@ruleArray}"

        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end  
    end


    def applyRules

        begin
            puts "#{@thisClass}:applyRules" if $INFO

            dataDictionary = Hash.new

            for rule in @ruleArray do

                puts "Evaluiating:  #{rule}"

                condition = rule["Condition"]

                puts "condition:  #{condition}"
                condition = resolveVariables(condition, dataDictionary)

                
                planterboxBooleanExpressionEvaluator = PlanterboxBooleanExpressionEvaluatorC.new(condition, dataDictionary)
                conditionBooleanResult = planterboxBooleanExpressionEvaluator.evaluateBooleanExpression

                puts "FINAL CONDITION BOOLEAN RESULT = #{conditionBooleanResult}"

                if conditionBooleanResult

                    action = rule["Action"]

                    puts "Firing I.... #{action}"

                    action = resolveVariables(action, dataDictionary)
                    puts "Firing II... #{action}"

                    planterboxActionEvaluator = PlanterboxActionEvaluatorConstructC.new
                    dataDictionary = planterboxActionEvaluator.invokeAction(action, dataDictionary)

                    puts "dataDictionary post firing is #{dataDictionary}"
                end

            end


        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end 

	end


    private


    def resolveVariables(stringline, dataDictionary)

        begin 

            puts ("===============================stringline = #{stringline}")

            tempStringArray = stringline.split(/(\w*\$\w+\$)/)

            newStringLine = ""

            for token in tempStringArray do

                puts ("Token = #{token}")

                if (token.match(/\w*\$\w+\$/))
                   puts "VARIABLE!!!!"

                   # Remove the $ delimiters.

                   token.delete! "$"
                   puts ("NTOKE = #{token}")

                   token = dataDictionary[token.upcase]

                   puts "TOKEN   NOW IS #{token}"
                end

                newStringLine += token #+ " "

            end


        #    if tempString != nil

                puts ("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!FINAL = #{newStringLine}")
       #         puts ("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!tempString1 = #{tempString[1]}")
        #    end

            return newStringLine

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e 
        end

	end

end
