package com.calculator;
import java.util.*;

public class CalculatorEngine {

    // Method to determine the precedence of operators
    private int precedence(char operator) {
        switch(operator) {
            case '+':
            case '-':
                return 1;
            case '*':
            case '/':
                return 2;
            default:
                return 0;
        }
    }

    // Method to apply an operator to two operands
    private double applyOperator(double a, double b, char operator) {
        switch(operator) {
            case '+':
                return a + b;
            case '-':
                return a - b;
            case '*':
                return a * b;
            case '/':
                if(b == 0) {
                    throw new ArithmeticException("Division by zero");
                }
                return a / b;
            default:
                throw new IllegalArgumentException("Invalid operator: " + operator);
        }
    }


    public double evaluate(String expression) {

        //Handle null or empty expression
        if(expression==null || expression.isEmpty()) {
            throw new IllegalArgumentException("Expression cannot be null or empty");
        }

        // Remove all whitespace from the expression
        expression = expression.replaceAll("\\s+", ""); 

        // To track if the last character was an operator
        boolean lastWasOperator = true; 

        //Use stacks to hold numbers and operators
        Stack<Double> numbers = new Stack<>();
        Stack<Character> operators = new Stack<>();

        //Loop through the expression
        for(int i=0;i<expression.length();i++)
        {
            char ch = expression.charAt(i); // Get the current character

            if(Character.isDigit(ch) || ch=='.') //if it is a digit or decimal, parse the number
            {
                StringBuilder num = new StringBuilder();

                lastWasOperator = false; // Set to false since we are now processing a number
                
                boolean hasDecimal = false; 

                while(i<expression.length() && (Character.isDigit(expression.charAt(i)) || expression.charAt(i)=='.')) 
                {
                    char current = expression.charAt(i);

                    if (current == '.') {
                        if (hasDecimal) {
                            throw new IllegalArgumentException("Invalid number format");
                        }
                        hasDecimal = true;
                    }
                    num.append(current);
                    i++;
                }

                if (num.toString().equals(".")) 
                {
                    throw new IllegalArgumentException("Invalid number format");
                }

                i--; // Move back one character for the extra increment

                numbers.push(Double.parseDouble(num.toString())); // Push the parsed number onto the stack
            }
            
            else if(ch=='+' || ch=='-' || ch=='*' || ch=='/') //if it is an operator
            {
                if(lastWasOperator) 
                {
                    throw new IllegalArgumentException("Invalid operator sequence");
                }

                while(!operators.isEmpty() && precedence(operators.peek()) >= precedence(ch)) 
                {
                    double b = numbers.pop();
                    double a = numbers.pop();
                    char op = operators.pop();
                    numbers.push(applyOperator(a, b, op)); 
                    // Apply the operator and push the result back onto the stack
                }
                operators.push(ch); // Push the current operator onto the stack

                lastWasOperator = true; 
            }
            else 
            {
                throw new IllegalArgumentException("Invalid character: " + ch);
            }
        }

        if (lastWasOperator) 
        {
            throw new IllegalArgumentException("Expression cannot end with operator");
        }
        

        // Apply remaining operators
        while(!operators.isEmpty()) 
        {
            double b = numbers.pop();
            double a = numbers.pop();
            char op = operators.pop();
            numbers.push(applyOperator(a, b, op)); 
        }

        return numbers.pop(); // The final result 

    }
    public static void main(String[] args) {
        CalculatorEngine engine = new CalculatorEngine();
        try {
            System.out.println(engine.evaluate("3. + ,5 * 2")); 
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}

