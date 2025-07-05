# PlanterboxActionEvaluatorConstructC.rb

require_relative "PlanterboxSetActionConstructC.rb"
require_relative "PlanterboxMeasureWindSpeedActionConstructC.rb"
require_relative "PlanterboxMeasureTemperatureActionConstructC.rb"
require_relative "PlanterboxMeasureApparentTemperatureActionConstructC.rb"
require_relative "PlanterboxMeasureRainActionConstructC.rb"
require_relative "PlanterboxToastActionConstructC.rb"
require_relative "PlanterboxAudifyActionConstructC.rb"

class PlanterboxActionEvaluatorConstructC

    # Constructor

    def initialize

        begin
                
            @actionConstructLibrary = Hash.new
            @actionConstructLibrary["SET"] = PlanterboxSetActionConstructC.new
            @actionConstructLibrary["MEASURE_WIND_SPEED"] = PlanterboxMeasureWindSpeedActionConstructC.new
            @actionConstructLibrary["MEASURE_TEMPERATURE"] = PlanterboxMeasureTemperatureActionConstructC.new
            @actionConstructLibrary["MEASURE_APPARENT_TEMPERATURE"] = PlanterboxMeasureApparentTemperatureActionConstructC.new
            @actionConstructLibrary["MEASURE_RAIN"] = PlanterboxMeasureRainActionConstructC.new
            @actionConstructLibrary["TOAST"] = PlanterboxToastActionConstructC.new
            @actionConstructLibrary["AUDIFY"] = PlanterboxAudifyActionConstructC.new


        rescue => e 
            # Catch, log and raise all exceptions.
            puts "ERROR: #{e.message}"
            raise e

        end

    end


    def invokeAction(action, dataDictionary)

        begin
                
            # Parse the action.

            # set cam is good;
            puts "INVOKING ACTION!!!!" if $INFO

            constructComponents = action.split(" ")
            actionComponent = constructComponents[0].upcase.delete('()').strip
            actionData      = constructComponents

            puts "actionComponent = #{actionComponent}"

            @actionConstructLibrary[actionComponent].invokeAction(dataDictionary, actionData)

        rescue => e 
            # Catch, log and raise all exceptions.
            puts "ERRaaaOR: #{e.message}"
            raise e

        end



    end


end
