# Planterbox.rb
#
# Main driver for the Planterbox expert system rules language.

class Planterbox

    # Define class attributes.

    _rules_file = ""

    # Constructor

    def initialize(rules_file)

        begin

            puts "Initializing Planterbox class." if $INFO
            @_rules_file = rules_file

        rescue => e

            # Catch, print and throw all exceptions.

            puts "Exception: #{e.message}"
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

    if (ARGV.length != 1) && (ARGV.length != 2)
        # An invalid number of parameters was provided.

        puts "Usage: planterbox <rules_file> [info:debug]"
        
    else
        # The number of parameters provided is valid.  Check to 
        # see if the logging parameter is a valid option.

        if (ARGV.length == 2)
            # Valid logging parameters are "debug" and "info".
            
            if (ARGV[1].downcase() == 'debug')
                # For debug, turn on both debug and info logs.

                $DEBUG = true
                $INFO  = true

            elsif (ARGV[1].downcase() == 'info')
                # For info, turn on just info logs.

                $INFO = true

            else
                # If a second parameter was provided, it wasn't info or log.
                # Therefore, display the usage and exit.

                puts "Usage: planterbox <rules_file> [info:debug]"
                exit(-1)
            end
        end 

        # Create the driver class and launch the app.

        rules_file = ARGV[0]

        myPlanterbox = Planterbox.new(rules_file)
        puts "Hello World"
    end

rescue => e 

    # Catch and print all exceptions.

    puts "FATAL: #{e.message}"
    
    exit(-1)

end

