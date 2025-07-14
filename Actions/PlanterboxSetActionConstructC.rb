# PlanterboxSetActionConstructC.rb

require_relative "PlanterboxActionConstructA.rb"

class PlanterboxSetActionConstructC < PlanterboxActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN SET with #{actionData}"
            myKey = actionData[1].upcase.delete('()').strip
            myValue = actionData[3].delete('()').strip

            dataDictionary[myKey] = myValue

            return dataDictionary


        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end
