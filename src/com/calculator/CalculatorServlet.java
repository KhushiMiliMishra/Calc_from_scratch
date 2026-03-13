package com.calculator;

import java.io.IOException;
import java.util.*;


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
        List<String> history = (List<String>) session.getAttribute("history");

        if(memory == null)
            memory = 0.0;

        if(history == null)
            history = new ArrayList<>();

        double result = 0;

        try {

            if(expression != null && !expression.isEmpty())
            {
                result = engine.evaluate(expression);
                history.add(expression + " = " + result);
            }

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

            session.setAttribute("memory", memory);
            session.setAttribute("history", history);

            request.setAttribute("result", result);

        }
        catch(Exception e)
        {
            request.setAttribute("error", e.getMessage());
        }

        // THIS IS THE IMPORTANT LINE
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}