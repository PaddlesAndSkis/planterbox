# BooleanExpressionEvaluatorC.rb

# Import classes.

require_relative "BooleanExpressionEvaluatorA.rb"

class BooleanExpressionEvaluatorC < BooleanExpressionEvaluatorA



    def evaluateConstruct

        begin 

            if @leftOperand == "F"

                return false
            end  
            
            return true

        rescue => e
            # Catch, log and raise all exceptions.

            puts "ERROR: #{e.message}" 
            raise e
        end

    end


end
