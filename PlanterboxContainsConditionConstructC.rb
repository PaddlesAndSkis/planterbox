# PlanterboxContainsConditionConstructC.rb
#

require_relative "PlanterboxConditionConstructA.rb"

class PlanterboxContainsConditionConstructC < PlanterboxConditionConstructA

    def initialize

        super

    end

    def evaluate(dataDictionary, conditionHash)

        begin

            myKey   = conditionHash["keyword"].upcase
            myValue = conditionHash["value"]

            puts "myKey = #{myKey} and myValue = #{myValue}"

            dataDictionaryValue = dataDictionary[myKey]

            puts "dataDictionaryValue = #{dataDictionaryValue}"

            if dataDictionaryValue != nil

                if dataDictionaryValue[myValue]
                    return true
                else
                    return false
                end


            else
                return false

            end


        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end


    end








end
