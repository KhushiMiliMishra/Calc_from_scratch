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

            if (expression != null && !expression.isEmpty()) {
                result = engine.evaluate(expression);
            }

            if (action != null) {
                switch (action) {
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

            // ✅ STORE IN SESSION
            session.setAttribute("memory", memory);
            session.setAttribute("result", result);

        } 
        catch (Exception e) 
        {
            session.setAttribute("error", e.getMessage());
            session.setAttribute("expression", expression);
        }

        // ✅ REDIRECT (PRG)
        response.sendRedirect("index.jsp");
    }
}