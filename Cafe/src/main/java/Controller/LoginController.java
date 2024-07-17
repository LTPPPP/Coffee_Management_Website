/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CustomerDAO;
import DAO.ManagerDAO;
import DAO.StaffDAO;
import Models.Customer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class LoginController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int count = 0;
        int numCustomer = 0;
        if (request.getParameter("LoginCustomer") != null) {
            String id = null;
            String name = request.getParameter("name");
            int table = Integer.parseInt(request.getParameter("role-table"));

            CustomerDAO customerDAO = new CustomerDAO();
            ResultSet rs = customerDAO.getAllCustomer();

            try {
                while (rs.next()) {
                    numCustomer++;
                }
                id = "C" + numCustomer;
            } catch (SQLException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }

            Customer c = new Customer(id, name, table);
            count = customerDAO.addCustomer(c);
            if (count != 0) {
                request.setAttribute("id", id);
                request.getRequestDispatcher("home-customer.jsp").forward(request, response);
            } else {
                response.sendRedirect("login.jsp");
            }
        } else if (request.getParameter("LoginStaff") != null) {
            String user = request.getParameter("username");
            String pass = request.getParameter("password");
            System.out.println("username " + user + " pass : " + pass);
            StaffDAO staffDAO = new StaffDAO();
            ResultSet rs = staffDAO.getAllStaff();
            System.out.println("rs of Login : "+ rs);
            try {
                while (rs.next()) {
                    if (rs.getString("Staff_user").equals(user) && rs.getString("Staff_pass").equals(pass)) {
                        String id = rs.getString("Staff_id");

                        //add Cookie
                        Cookie c = new Cookie("idStaff", id);
                        response.addCookie(c);
                        c.setMaxAge(60 * 60 * 24 * 1);

                        request.setAttribute("id", id);
                        request.getRequestDispatcher("order-staff.jsp").forward(request, response);
//                        response.sendRedirect("/staff");
                        break;
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(LoginController.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (request.getParameter("LoginManager") != null) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            ManagerDAO managerDAO = new ManagerDAO();

            if (managerDAO.checkAccountManager(username, password)) {
                // Đăng nhập thành công
                String managerName = managerDAO.getManagerName(username);

                Cookie c = new Cookie("managerName", managerName);
                response.addCookie(c);
                c.setMaxAge(60 * 60 * 24 * 1); // Cookie tồn tại trong 3 ngày

                request.setAttribute("managerName", managerName);
                response.sendRedirect("/order-admin");
            } else {
                // Đăng nhập thất bại
                response.sendRedirect("login.jsp");
            }
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
