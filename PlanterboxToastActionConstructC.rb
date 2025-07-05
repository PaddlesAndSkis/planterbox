# PlanterboxToastActionConstructC.rb

# Import libraries.

require_relative "PlanterboxActionConstructA.rb"


class PlanterboxToastActionConstructC < PlanterboxActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN TOAST with #{actionData}"

            # Define local variables.

            messenger ="Planterbox"
            message = ""

            # Remove the first element of the array (Action)
            # and the last element of the array (EOL - ;)

            actionData.shift
            actionData.pop

            # Iterate over the array and create the Toast message.

            for myWord in actionData do
               message += myWord + " "
            end
            
            # Invoke Toast using the Ruby OS system command.

            toastSink = system(".\\Toasty\\Toasty.exe -m #{messenger} -t #{message}")

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end  
