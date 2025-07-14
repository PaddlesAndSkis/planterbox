# PlanterboxGreaterThanConditionConstructC.rb

require_relative "PlanterboxConditionConstructA.rb"

class PlanterboxGreaterThanConditionConstructC < PlanterboxConditionConstructA

    def initialize

        super

    end


    def evaluate(dataDictionary, conditionHash)

        begin

            myKey   = conditionHash["keyword"].upcase
            myValue = conditionHash["value"]

            puts "In Greater Than with myKey = #{myKey} and myValue = #{myValue}"

            dataDictionaryValue = dataDictionary[myKey]
            puts "In Greater Than with dataDictionaryValue = #{dataDictionaryValue}"

            if dataDictionaryValue != nil

                myValueInt = 0

                begin

                    #myValueInt = myValue.strip.to_i
                    myValueInt = Integer(myValue)

                rescue => intError

                    myValueInt = nil
                end

                puts "myValueInt = #{myValueInt}"
                if myValueInt != nil

                    dataDictionaryValueInt = dataDictionaryValue.strip.to_i
                    
                    if dataDictionaryValueInt != nil

                        if dataDictionaryValueInt > myValueInt
                            return true
                        end
                    end
                else
                    # string
                    # If Turner greaterThan Cam

                    origArray = [dataDictionaryValue, myValue]
                    sortArray = origArray.sort.reverse

                    puts "origArray = #{origArray}"
                    puts "sortArray = #{sortArray}"

                    if origArray == sortArray
                        return true
                    end


                end 
            end
            
            # To sort string - create a sorted list of the datadictionary value
            # and the mYvalue = does the two lists equal?  
            # compare it to an array of datadictionary vakue and myValue

            # If this point in the method has been reached, it's false.

            return false

        rescue => e
            # Catch, log and raise all exceptions.

            raise e
        end


    end

end
