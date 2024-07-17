/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ItemDAO;
import Models.Item;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Lam Tan Phat - CE181023
 */
@WebServlet(name = "ListItemsServlet", urlPatterns = {"/listItem-admin"})
public class ListItemsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ItemDAO itemDAO = new ItemDAO();
        List<Item> foodItems = itemDAO.getItemsByType("Food");
        List<Item> drinkItems = itemDAO.getItemsByType("Drink");
        List<Item> dessertItems = itemDAO.getItemsByType("Dessert");
        request.setAttribute("foodItems", foodItems);
        request.setAttribute("drinkItems", drinkItems);
        request.setAttribute("dessertItems", dessertItems);
        request.getRequestDispatcher("product-admin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
