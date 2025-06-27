# PlanterboxMeasureWindSpeedActionConstructC.rb

require_relative "PlanterboxWeatherActionConstructA.rb"

class PlanterboxMeasureWindSpeedActionConstructC < PlanterboxWeatherActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN MeasureWindSpeed with #{actionData}"

            latitude  = dataDictionary["LATITUDE"]
            longitude = dataDictionary["LONGITUDE"]
            weatherAPIDataString = "wind_speed_10m"

            dataDictionary['WIND_SPEED'] = getWeatherData(latitude, longitude, weatherAPIDataString)

            return dataDictionary

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end
