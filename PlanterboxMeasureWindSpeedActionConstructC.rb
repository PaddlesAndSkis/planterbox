# PlanterboxMeasureWindSpeedActionConstructC.rb

require_relative "PlanterboxActionConstructA.rb"
require 'net/http'
require 'json'

class PlanterboxMeasureWindSpeedActionConstructC < PlanterboxActionConstructA

    def invokeAction(dataDictionary, actionData)

        begin
            puts "IN MeasureWindSpeed with #{actionData}"
          #  myKey = actionData[1].upcase.delete('()').strip
          #  myValue = actionData[3].delete('()').strip

            locationLatitude  = dataDictionary["LATITUDE"]
            locationLongitude = dataDictionary["LONGITUDE"]

            apiString = "https://api.open-meteo.com/v1/forecast?latitude=#{locationLatitude}&longitude=#{locationLongitude}" +
                        "&models=gem_seamless&current=wind_speed_10m"

            puts "API: #{apiString}"
            url = URI.parse(apiString)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port, use_ssl: true) {|http|
                http.request(req)
               }
            apiResponseString = res.body

            blah = JSON.parse(apiResponseString)
            puts blah
            puts blah['longitude']
            puts blah['current']['wind_speed_10m']
           # "wind_speed_10m" => 7.9}}

            dataDictionary['WIND_SPEED'] = blah['current']['wind_speed_10m']
            return dataDictionary


        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end
