# PlanterboxTOC.rb
#
# The Transfer Object for the Planterbox.
#

class PlanterboxTOC

    # Define attributes.

    attr_accessor :gardenPlanFile, :repeat_value, :plantArray

    # Constructor
    #
    # [in]: gardenPlanFile - the file containing the gardens to plantArray
    # [in]: repeat_value - TBD
    # [in]: plantArray - the global set of plants in the garden

    def initialize(gardenPlanFile = "undefined", repeat_value = 0, plantArray = nil)

        # Set the attributes.

        @gardenPlanFile = gardenPlanFile
        @repeat_value   = repeat_value
        @plantArray     = plantArray

    end

end
