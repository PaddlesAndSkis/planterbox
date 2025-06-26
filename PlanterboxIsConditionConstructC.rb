# PlanterboxIsConditionConstructC.rb

# Import libraries.

require_relative "PlanterboxConditionConstructA.rb"

class PlanterboxIsConditionConstructC < PlanterboxConditionConstructA

    def initialize

        super

    end

    def evaluate(dataDictionary, conditionHash)

        begin

            puts "In PlanterboxIsConditionConstructC"

            # Get the keyword-value from the condition Hash.

            myKey   = conditionHash["keyword"].upcase
            myValue = conditionHash["value"]

            puts "KVP = #{myKey}  #{myValue}"
            # Get the value from the data dictionary.

            dataDictionaryValue = dataDictionary[myKey]
            puts "dataDictionaryValue = #{dataDictionaryValue}"
            if (dataDictionaryValue == nil)
                if (myValue == 'empty')
                    return true
                else 
                    return false 
                end
            end

            if dataDictionaryValue != nil

                if (dataDictionaryValue == myValue)
                 
                    return true
                elsif (myValue == 'empty') && (dataDictionaryValue == "")
                    return true

                end
            end

            return false

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end
	
    end

end 