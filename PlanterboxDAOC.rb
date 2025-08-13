# PlanterboxDAOC.rb
#
# The Data Access Object for Planterbox.
#

# Import libraries.

require_relative "PlanterboxTOC.rb"

# Class: PlanterboxDAOC

class PlanterboxDAOC


    # Constructor

    def initialize(planterboxTO)

        begin
            # Initialize the class attributes.

            @planterboxTO = planterboxTO

            @plantArray = planterboxTO.plantArray

            @thisClass = "PlanterboxDAOC"

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end
    end


    # fillThePlanterbox

    def fillThePlanterbox

        begin
            puts "#{@thisClass}:fillThePlanterbox" if $INFO

            # To fill the Planterbox with plants, first get the Garden Plan to get
            # the set of plants (i.e., rules) that will be planted in the Planterbox.

            gardenPlan = getGardenPlan

            # Iterate over the Garden Plan and fill the Planterbox with plants.

            for garden in gardenPlan do

                # Get the plants from each garden in the garden plan.

                getPlants(garden)

            end

            puts "plantArray: #{@plantArray}"

            # Store the complete set of plants in the Planterbox.

            @planterboxTO.plantArray = @plantArray

            return @planterboxTO

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end  
    end  



    # Private methods.

    private 


    # getGardenPlan

    def getGardenPlan

        begin

            # Initialize the Garden Plan Array.

            gardenPlanArray = Array.new

            File.open(@planterboxTO.gardenPlanFile, "r").each do |gardenPlanLine|

                # Remove all whitespace and add the garden plan to the set of Garden Plans
                # that will comprise the Planterbox.

                gardenPlanLine.strip!

                puts "Examining: #{gardenPlanLine}"
                if (gardenPlanLine.start_with?("plant"))

                    # This is a garden to plant.

                    garden = (gardenPlanLine.split(/\s*plant/))[1].strip

                    puts "Adding: #{garden}"
                    gardenPlanArray.push(garden)


                elsif (gardenPlanLine.start_with?("#"))

                    # A comment.  Disregard.

                else
                    # Unexpected.  Disregard.

                end


            end

            # Return the Garden Plan.

            return gardenPlanArray


        rescue => e
            # Catch, log and raise all exceptions.
            puts "ERROR: #{e.message}"
            raise e
        end

    end


    # getPlants

    def getPlants(garden)

        begin
            puts "#{@thisClass}:getPlants" if $INFO

            plant = ""
            plantID = "None"

            # Open the garden and get the plants.

            File.open(garden, "r").each do |plantLine|

                plantLine.strip!
                puts "#{plantLine}"
                if plantLine.start_with?(/#\s*RuleID/)
                    # Rule ID: remove colons and whitespace

                    plantID = (plantLine.split(/#\s*RuleID/))[1].delete_prefix(":").strip
                    puts "plantID ==> #{plantID}" if $INFO

                elsif plantLine.start_with?("#")

                    # Comment.  Move to the next line.

                elsif plantLine.end_with?(";")

                    # The last plant line has been read.

                    plant = (plant.concat(" ", plantLine)).strip

                    # Parse the plant into its condition and action and add
                    # the plant hash to the plant array.

                    @plantArray.push(parsePlant(plantID, plant))

                    # Reset the plant info for the next plant.

                    plant = ""
                    plantID = "None"

                else

                    # Keep adding the line to the plant.

                    plant.concat(" ", plantLine)
                end 

            end

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end 


    # parsePlant

    def parsePlant(plantID, plantString)

        begin
            puts "#{@thisClass}:parsePlant" if $INFO

            plantHash = Hash.new

            if (plantString.upcase.start_with?("IF"))

                # Remove the IF.

                plantString = plantString[3, plantString.length]

                # Parse the THEN.

                actionIndex = plantString.upcase.index("THEN")

                if (actionIndex != nil)

                    condition = plantString[0, actionIndex]
                    action = plantString[actionIndex+5, plantString.length]
                else
                    # Missing then "THEN".

                    raise "ERROR: No THEN found in plant: #{plantString}"
                end

                condition.concat(";")

                plantHash["ID"] = plantID
                plantHash["Condition"] = condition
                plantHash["Action"] = action 
            else
                # Missing the "IF".
                                    
                raise "ERROR: No IF found in plant: #{plantString}"
            end  

            return plantHash

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end


    end


end
	
