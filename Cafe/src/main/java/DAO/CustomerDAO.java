/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBConnection;
import Models.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class CustomerDAO {

    public ResultSet getAllCustomer() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Customer");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllCustomerById(String id) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Customer where Customer_id ='" + id + "'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public int addCustomer(Customer obj) {
        Connection conn = DBConnection.getConnection();

        ResultSet rs = null;
        String sql = "INSERT INTO Customer VALUES (?, ?, ?, ?, ?)";
        int count = 0;
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getCustomer_id());
            pst.setString(2, obj.getCustomer_name());
            pst.setInt(3, obj.getCustomer_table());
            pst.setInt(4, 0);
            pst.setInt(5, 0);

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public void updateCustomerGiveOrder(String id) {
        Connection conn = DBConnection.getConnection();

        ResultSet rs = null;
        String sql = "UPDATE Customer SET Customer_giveOrder=1 WHERE Customer_id= '" + id + "'";
        int count = 0;
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(sql);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public Customer getCustomerById(String id) {
        Connection conn = DBConnection.getConnection();
        Customer customer = null;

        if (conn != null) {
            try {
                String sql = "SELECT * FROM Customer WHERE Customer_id = ?";
                PreparedStatement pst = conn.prepareStatement(sql);
                pst.setString(1, id);

                ResultSet rs = pst.executeQuery();

                if (rs.next()) {
                    customer = new Customer();
                    customer.setCustomer_id(rs.getString("Customer_id"));
                    customer.setCustomer_name(rs.getString("Customer_name"));
                    customer.setCustomer_table(rs.getInt("Customer_table"));
                    customer.setCustomer_giveOrder(rs.getInt("Customer_giveOrder"));
                    customer.setCustomer_payment(rs.getInt("customer_payment"));
                }

                rs.close();
                pst.close();
            } catch (SQLException ex) {
                Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error getting customer by ID", ex);
            } finally {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, "Error closing connection", ex);
                }
            }
        }

        return customer;
    }

    public int getTotalCustomers() {
        int total = 0;
        String sql = "SELECT COUNT(*) AS total FROM Customer";
        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                total = rs.getInt("total");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return total;
    }

    public static void main(String[] args) throws SQLException {
        CustomerDAO obj = new CustomerDAO();
    }
}
