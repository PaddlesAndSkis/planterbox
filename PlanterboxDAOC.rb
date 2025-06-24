# PlanterboxDAOC.rb
#
# Planterbox Data Access Object
#

# Import libraries.

require_relative "PlanterboxTOC.rb"

class PlanterboxDAOC


    # Constructor

    def initialize(planterboxTO)

        begin

            @planterboxTO = planterboxTO

            @ruleArray = planterboxTO.ruleArray

            @thisClass = "PlanterboxDAOC"

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e

        end
    end


    def loadPlanterbox

        begin
            puts "#{@thisClass}:loadPlanterbox" if $INFO

            # Load the rules file.

            loadRulesFile

            puts "RuleArray: #{@ruleArray}"

            @planterboxTO.ruleArray = @ruleArray

            return @planterboxTO

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end  
    end  


    # Private methods.

    private 



    # loadRulesFile

    def loadRulesFile

        begin
            puts "#{@thisClass}:loadRulesFile" if $INFO

            rule = ""
            ruleID = "None"

            File.open(@planterboxTO.rulesFile, "r").each do |ruleLine|

                ruleLine.strip!
                puts "#{ruleLine}"
                if ruleLine.start_with?(/#\s*RuleID/)
                    # Rule ID: remove colons and whitespace

                    ruleID = (ruleLine.split(/#\s*RuleID/))[1].delete_prefix(":").strip
                    puts "ruleID ==> #{ruleID}" if $INFO

                elsif ruleLine.start_with?("#")

                    # Comment.  Move to the next line.

                elsif ruleLine.end_with?(";")

                    # The last rule line has been read.

                    rule = (rule.concat(" ", ruleLine)).strip

                    # Parse the rule into its condition and action and add
                    # the rule hash to the rule array.

                    @ruleArray.push(parseRule(ruleID, rule))

                    # Reset the rule info for the next rule.

                    rule = ""
                    ruleID = "None"

                else

                    # Keep adding the line to the rule.

                    rule.concat(" ", ruleLine)
                end 

            end

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end

    end 


    # parseRule

    def parseRule(ruleID, ruleString)

        begin
            puts "#{@thisClass}:parseRule" if $INFO

            ruleHash = Hash.new

            if (ruleString.upcase.start_with?("IF"))

                # Remove the IF.

                ruleString = ruleString[3, ruleString.length]

                # Parse the THEN.

                actionIndex = ruleString.upcase.index("THEN")

                if (actionIndex != nil)

                    condition = ruleString[0, actionIndex]
                    action = ruleString[actionIndex+5, ruleString.length]
                else
                    # Missing then "THEN".

                    raise "ERROR: No THEN found in rule: #{ruleString}"
                end

                condition.concat(";")

                ruleHash["ID"] = ruleID
                ruleHash["Condition"] = condition
                ruleHash["Action"] = action 
            else
                # Missing the "IF".
                                    
                raise "ERROR: No IF found in rule: #{ruleString}"
            end  

            return ruleHash

        rescue => e 
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}"
            raise e
        end


    end


end
	
