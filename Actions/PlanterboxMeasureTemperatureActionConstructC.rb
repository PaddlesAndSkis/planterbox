# PlanterboxMeasureTemperatureActionConstructC.rb

require_relative "PlanterboxWeatherActionConstructA.rb"

class PlanterboxMeasureTemperatureActionConstructC < PlanterboxWeatherActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN MeasureTemperature with #{actionData}"

            latitude  = dataDictionary["LATITUDE"]
            longitude = dataDictionary["LONGITUDE"]
            weatherAPIDataString = "temperature_2m"

            dataDictionary['TEMPERATURE'] = getWeatherData(latitude, longitude, weatherAPIDataString)

            return dataDictionary


        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end
 