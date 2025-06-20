# PlanterboxTOC.rb
#
# Transfer Object

class PlanterboxTOC

    attr_accessor :_file_name, :_repeat_value

    # Constructor

    def initialize(file_name = "undefined", repeat_value = 0)

        @_file_name = file_name
        @_repeat_value = repeat_value

    end

end
