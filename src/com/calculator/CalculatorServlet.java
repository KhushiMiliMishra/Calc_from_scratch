package com.calculator;

import java.io.IOException;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/calculate")
public class CalculatorServlet extends HttpServlet {

    private CalculatorEngine engine = new CalculatorEngine();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String expression = request.getParameter("expression");
        String action = request.getParameter("action");

        HttpSession session = request.getSession();

        Double memory = (Double) session.getAttribute("memory");

        if (memory == null)
            memory = 0.0;

        double result = 0;

        try {

            double currentValue = 0;

            try {
                if (expression != null && !expression.isEmpty()) {
                    currentValue = engine.evaluate(expression);
                }
            } catch (Exception e) {
                // fallback to last valid result if expression invalid
                Object prevResult = session.getAttribute("result");
                if (prevResult != null) {
                    currentValue = Double.parseDouble(prevResult.toString());
                } else {
                    currentValue = 0;
                }
            }

            result = currentValue;

            if (action != null) {
                switch (action) {
                    case "MC":
                        memory = 0.0;
                        break;

                    case "M+":
                        memory += currentValue;
                        break;

                    case "M-":
                        memory -= currentValue;
                        break;

                    case "MR":
                        result = memory;
                        break;
                }
            }

            // Normalize -0.0 → 0.0
            if(result == 0.0) {
                result = 0.0;
            }

            // STORE IN SESSION
            session.setAttribute("memory", memory);
            session.setAttribute("result", result);

        } 
        catch (Exception e) 
        {
            session.setAttribute("error", e.getMessage());
            session.setAttribute("expression", expression);
        }

        // REDIRECT (PRG)
        response.sendRedirect("index.jsp");
    }
}