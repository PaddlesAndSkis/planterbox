# PlanterboxAudifyActionConstructC.rb

# Import libraries.

require_relative "PlanterboxActionConstructA.rb"


class PlanterboxAudifyActionConstructC < PlanterboxActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN AUDIFY with #{actionData}"

            # Define local variables.

            sound = actionData[1]
            
            # Invoke Audify using the Ruby OS system command.

            toastSink = system(".\\Audify\\Audify.exe -s #{sound}")

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end  
