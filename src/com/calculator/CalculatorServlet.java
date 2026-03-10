package com.calculator;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet
{
    private CalculatorEngine engine = new CalculatorEngine();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String expression = request.getParameter("expression");
        String action = request.getParameter("action");

        // Get session for memory storage
        HttpSession session = request.getSession();
        Double memory = (Double) session.getAttribute("memory");

        if(memory == null)
        {
            memory = 0.0;
        }

        double result = 0;

        try
        {
            // Evaluate expression if provided
            if(expression != null && !expression.isEmpty())
            {
                result = engine.evaluate(expression);
            }

            // Handle memory operations
            if(action != null)
            {
                switch(action)
                {
                    case "MC":
                        memory = 0.0;
                        break;

                    case "M+":
                        memory += result;
                        break;

                    case "M-":
                        memory -= result;
                        break;

                    case "MR":
                        result = memory;
                        break;
                }
            }

            // Save memory back into session
            session.setAttribute("memory", memory);

            out.println("<h2>Result: " + result + "</h2>");
            out.println("<h3>Memory: " + memory + "</h3>");
        }
        catch(Exception e)
        {
            out.println("<h2 style='color:red;'>Error: " + e.getMessage() + "</h2>");
        }
    }
}