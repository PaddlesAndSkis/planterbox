# Planterbox.rb
#
# Main driver for the Planterbox expert system rules language.

# Import libraries.

require_relative "PlanterboxTOC.rb"
require_relative "PlanterboxBOC.rb"

class Planterbox

    # Define class attributes.

    _rules_file   = ""
    _repeat_value = 0

    # Constructor

    def initialize(rules_file, repeat_value)

        begin

            puts "Initializing Planterbox class." if $INFO
            @_rules_file = rules_file
            @_repeat_value = repeat_value

        rescue => e

            # Catch, print and throw all exceptions.

            puts "Exception: #{e.message}"
            throw e

        end
    end


    # startPlanting

    def startPlanting()

        begin

            # Create the Transfer Object.

            planterboxTO = PlanterboxTOC.new(@_rules_file, @repeat_value)

            # Create and invoke the Business Object.

            planterboxBO = PlanterboxBOC.new(planterboxTO)
            planterboxBO.plant()

        rescue => e

            # Catch, print and throw all exceptions.

            puts "ERROR: #{e.message}"
            throw e
        end


    end
	
end


# Main driver.

begin

    # Define the global logging variables.

    $DEBUG = false
    $INFO  = false

    # Initialize local variables.

    rules_file = ""

    # Check the arguments passed into Planterbox.

    if (ARGV.length != 2) && (ARGV.length != 3)
        # An invalid number of parameters was provided.

        puts "Usage: planterbox <rules_file> <repeat_value> [info:debug]"
        
    else
        # The number of parameters provided is valid.  Check to 
        # see if the logging parameter is a valid option.

        if (ARGV.length == 3)
            # Valid logging parameters are "debug" and "info".
            
            if (ARGV[2].downcase() == 'debug')
                # For debug, turn on both debug and info logs.

                $DEBUG = true
                $INFO  = true

            elsif (ARGV[2].downcase() == 'info')
                # For info, turn on just info logs.

                $INFO = true

            else
                # If a third parameter was provided, it wasn't info or log.
                # Therefore, display the usage and exit.

                puts "Usage: planterbox <rules_file> <repeat_value> [info:debug]"
                exit(-1)
            end
        end 

        # Create the driver class and launch the app.

        rules_file = ARGV[0]
        repeat_value = ARGV[1]

        myPlanterbox = Planterbox.new(rules_file, repeat_value)
        myPlanterbox.startPlanting()

        puts "Planting complete"
    end

rescue => e 

    # Catch and print all exceptions.

    puts "FATAL: #{e.message}"
    
    exit(-1)

end

