# Planterbox.rb
#
# Main driver for the Planterbox expert system rules language.
#
# Usage: planterbox <garden_plan> <repeat_value> [info:debug]
#
# You own a planterbox in your garden.  It is full of soil and so many possibilities.
# What plants do you plant for this season, this year or even year after year?
# Do you plant them in different sections according to some plan?  Or are they all mixed
# in together.  Do you want to move plants around or get rid of them entirely without too
# much effort?
#
# The rules that we would like to run on our systems operate the same way.
# What rules do we want for the next few months, year or permanently?
# Do we want to quickly remove rules that don't serve a purpose?
# Are they rules classified as part of an overall plan?
# 
# In Planterbox, the rules are the plants and the Planterbox is the environment for
# running those rules.
#
# Terminology in the Planterbox.
#
#  Plants: the different rules that do different things and can last weeks, months or years
#  Planterbox: the environment that contains the set of rules
#  Garden Plan: the different sections of the Planterbox that contains different rules
#  

# Import libraries.

require_relative "PlanterboxTOC.rb"
require_relative "PlanterboxBOC.rb"

# Class: Planterbox

class Planterbox

    # Constructor
    #
    # [in]: gardenPlan:  the sets of rules to include in the Planterbox garden
    # [in]: repeat_value

    def initialize(gardenPlan, repeat_value)

        begin

            puts "Initializing Planterbox class." if $INFO
            @gardenPlan = gardenPlan
            @repeat_value = repeat_value

        rescue => e

            # Catch, log and throw all exceptions.

            puts "Exception: #{e.message}"
            raise e

        end
    end


    # startPlanting

    def startPlanting

        begin

            # Create the Transfer Object.

            planterboxTO = PlanterboxTOC.new(@gardenPlan, @repeat_value)

            # Create and invoke the Business Object.

            planterboxBO = PlanterboxBOC.new(planterboxTO)
            planterboxBO.plant

        rescue => e

            # Catch, log and throw all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end


    end
	
end


# Main driver.

begin

    # Define the global logging variables.

    $DEBUG = false
    $INFO  = false

    # Initialize local variables.

    gardenPlan = ""

    # Check the arguments passed into Planterbox.

    if (ARGV.length != 2) && (ARGV.length != 3)
        # An invalid number of parameters was provided.

        puts "Usage: planterbox <garden_plan> <repeat_value> [info:debug]"
        
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

                puts "Usage: planterbox <garden_plan> <repeat_value> [info:debug]"
                exit(-1)
            end
        end 

        # Create the driver class and launch the app.

        gardenPlan = ARGV[0]
        repeat_value = ARGV[1]

        myPlanterbox = Planterbox.new(gardenPlan, repeat_value)
        myPlanterbox.startPlanting

        puts "Planting complete" if $INFO
    end

rescue => e 

    # Catch and log all exceptions.

    puts "FATAL: #{e.message}"
    
    exit(-1)

end

