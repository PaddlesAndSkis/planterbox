# PlanterboxTOC.rb
#
# Transfer Object

class PlanterboxTOC

    attr_accessor :rulesFile, :repeat_value, :ruleArray

    # Constructor

    def initialize(rulesFile = "undefined", repeat_value = 0, ruleArray = nil)

        @rulesFile    = rulesFile
        @repeat_value = repeat_value
        @ruleArray    = ruleArray

    end

end
