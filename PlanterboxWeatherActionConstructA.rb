# PlanterboxWeatherActionConstructA.rb

require_relative "PlanterboxActionConstructA.rb"
require 'net/http'
require 'json'

class PlanterboxWeatherActionConstructA < PlanterboxActionConstructA

    protected

    def getWeatherData(latitude, longitude, weatherAPIDataString)
        
        begin

            puts "In PlanterboxWeatherActionConstructA:getWeatherData"
            apiString = "https://api.open-meteo.com/v1/forecast?latitude=#{latitude}&longitude=#{longitude}" +
                        "&models=gem_seamless&current=#{weatherAPIDataString}"

            puts "API: #{apiString}"
            url = URI.parse(apiString)
            req = Net::HTTP::Get.new(url.to_s)
            res = Net::HTTP.start(url.host, url.port, use_ssl: true) {|http|
                http.request(req)
               }

            weatherAPIResponseString = res.body

            weatherAPIResponse = JSON.parse(weatherAPIResponseString)

            return weatherAPIResponse['current'][weatherAPIDataString]


        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end

end


