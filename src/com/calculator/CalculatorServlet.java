package com.calculator;

import java.io.IOException;
import java.io.PrintWriter;
// import jakarta.servlet.*;
import javax.servlet.*;
// import jakarta.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet
{
    private CalculatorEngine engine = new CalculatorEngine();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        String expression = request.getParameter("expression");
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();
        try 
        {
            double result = engine.evaluate(expression);
            out.println("<h2>Result: " + result + "</h2>");
        } 
        catch (Exception e) 
        {
            out.println("<h2 style='color:red;'>Error: " + e.getMessage() + "</h2>");
        }
    }
        
}
