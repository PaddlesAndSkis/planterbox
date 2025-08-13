# PlanterboxBOC.rb
#
# The Business Object for Planterbox.

# Import libraries.

require_relative "PlanterboxTOC.rb"
require_relative "PlanterboxDAOC.rb"
require_relative "PlanterboxBooleanExpressionEvaluatorC.rb"
require_relative "Actions/PlanterboxActionEvaluatorConstructC.rb"

# Class: PlanterboxBOC

class PlanterboxBOC

    # Constructor
    #
    # [in]: planterboxTO - the transfer object

    def initialize(planterboxTO)

        begin

            # Initialize the class attributes.

            @planterboxTO = planterboxTO
            @plantArray = Array.new

            # Add the plantArray to the Transfer Object.

            @planterboxTO.plantArray = @plantArray

        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end


    # plant 

    def plant

        begin

            # Plant the planterbox with all the plants.

            plantTheGarden

            # Water the plants and see what they do during this growth cycle.

            waterThePlants

        rescue => e

            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end
    end


    # Private methods.

    private


    # plantTheGarden

    def plantTheGarden

        begin

            # Plant the garden.

            planterboxDAO = PlanterboxDAOC.new(@planterboxTO)
            @planterboxTO = planterboxDAO.fillThePlanterbox

            @plantArray = @planterboxTO.plantArray

            puts "loadedPlants = #{@plantArray}" if $INFO

        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end  
    end


    # waterThePlants

    def waterThePlants

        begin

            # Initialize a data dictionary Hashtable that will store all the
            # data.

            dataDictionary = Hash.new

            # Iterate over the set of plants.

            for plant in @plantArray do

                puts "Evaluating:  #{plant}" if $DEBUG

                # Extract the condition for the plant to continue growing.

                condition = plant["Condition"]

                puts "condition:  #{condition}" if $DEBUG

                # Resolve any variables that are present in the condition.

                condition = resolveVariables(condition, dataDictionary)

                # Evaluate the condition.

                planterboxBooleanExpressionEvaluator = PlanterboxBooleanExpressionEvaluatorC.new(condition, dataDictionary)
                conditionBooleanResult = planterboxBooleanExpressionEvaluator.evaluateBooleanExpression

                puts "FINAL CONDITION BOOLEAN RESULT = #{conditionBooleanResult}" if $DEBUG

                # If the condition for the plant is True, let the plant grow!

                if conditionBooleanResult

                    # Get the operation / action that this plant will do during its growth spurt.

                    action = plant["Action"]

                    # Resolve any variables that are present in the action.

                    action = resolveVariables(action, dataDictionary)
                    puts "Firing... #{action}" if $DEBUG

                    # Invoke the action for the plant.

                    planterboxActionEvaluator = PlanterboxActionEvaluatorConstructC.new
                    dataDictionary = planterboxActionEvaluator.invokeAction(action, dataDictionary)

                end

            end

        rescue => e
            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end 

	end


    # resolveVariables
    #
    # [in]: stringLine - the String to Evaluate
    # [in]: dataDictionary - the dictionary of variables that can be resolved

    def resolveVariables(stringline, dataDictionary)

        begin 

            # Using regex, split the string (e.g., either a condition or action)
            # into its tokens.

            tempStringArray = stringline.split(/(\w*\$\w+\$)/)

            newStringLine = ""

            # Iterate over the tokens.

            for token in tempStringArray do

                # Check to see if the token is a variable (e.g., $var$).

                if (token.match(/\w*\$\w+\$/))

                   # Variable is present - remove the $ delimiters.

                   token.delete! "$"

                   # Look up the data value for this variable in the 
                   # data dictionary Hashtable and set that as the new token
                   # value.

                   token = dataDictionary[token.upcase]

                   puts "TOKEN   NOW IS #{token}" if $DEBUG
                end

                # Set the new string (e.g., condition, action) to include the
                # token value.

                newStringLine += token #+ " "

            end

            puts ("Resolved variables: #{newStringLine}") if $DEBUG

            # Return the new string that will include all resolved variables.

            return newStringLine

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e 
        end

	end

end
