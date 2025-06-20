# PlanterboxBOC.rb
#
# This is the Planterbox Business Object.

class PlanterboxBOC

    # Define attributes.

    @_planterBoxTO = nil

    # Constructor

    def initialize(planterboxTO)

        @_planterboxTO = planterboxTO

    end


    # plant 

    def plant()

        begin

            # Load file.
            puts "In BOC"

        rescue => e

            # Catch, display and throw all exceptions.

            puts "ERROR: #{e.message}"
            throw e

        end
    end
	



end
