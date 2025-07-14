# PlanterboxMeasureApparentTemperatureActionConstructC.rb

require_relative "PlanterboxWeatherActionConstructA.rb"

class PlanterboxMeasureApparentTemperatureActionConstructC < PlanterboxWeatherActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN MeasureTemperature with #{actionData}"

            latitude  = dataDictionary["LATITUDE"]
            longitude = dataDictionary["LONGITUDE"]
            weatherAPIDataString = "apparent_temperature"

            dataDictionary['APPARENT_TEMPERATURE'] = getWeatherData(latitude, longitude, weatherAPIDataString)

            return dataDictionary


        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end
 