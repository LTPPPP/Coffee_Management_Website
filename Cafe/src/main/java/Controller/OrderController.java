/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import DAO.OrderDAO;
import Models.Order;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class OrderController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (request.getParameter("idFromHome") != null) {
            String id = request.getParameter("idFromHome");
            request.setAttribute("id", id);
            request.getRequestDispatcher("order-customer.jsp").forward(request, response);
        } else {
            String id = request.getParameter("idFromOrder");
            request.setAttribute("id", id);
            request.getRequestDispatcher("home-customer.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idCus = request.getParameter("idCus");
        request.setAttribute("idCus", idCus);
//        int numItem = Integer.parseInt(request.getParameter("numItem"));
        String numItemStr = request.getParameter("numItem");
        int numItem = 0;
        if (numItemStr != null && !numItemStr.isEmpty()) {
            numItem = Integer.parseInt(numItemStr);
        } else {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            // Delete all cookies
            Cookie[] cookies = request.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    cookie.setMaxAge(0);
                    response.addCookie(cookie);
                }
            }
            // Redirect to the login page
            response.sendRedirect("login.jsp");
            return;
        }
        int count = 0;
        for (int i = 1; i <= numItem; i++) {
            int quantity = Integer.parseInt(request.getParameter("quantityItem" + i));

            String idItem = request.getParameter("idItem" + i);
            Order order = new Order(idCus, idItem, quantity, "not yet");
            OrderDAO orderDAO = new OrderDAO();
            count = orderDAO.addOrder(order);
        }
        if (count != 0) {
            //change customer give Order from 0 to 1
            CustomerDAO customerDAO = new CustomerDAO();
            customerDAO.updateCustomerGiveOrder(idCus);

            request.setAttribute("idCus", idCus);
            request.getRequestDispatcher("bill-customer.jsp").forward(request, response);
        } else {
            response.sendRedirect("home-customer.jsp");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
