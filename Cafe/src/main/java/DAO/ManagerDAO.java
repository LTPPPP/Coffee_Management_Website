/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Lam Tan Phat - CE181023
 */
public class ManagerDAO {

    public String getManagerName(String manager_username) {
        Connection conn = DBConnection.getConnection();
        String managerName = null;
        if (conn != null) {
            try {
                PreparedStatement pst = conn.prepareStatement("SELECT [Manager_name] FROM Manager WHERE [Manager_user] = ?");
                pst.setString(1, manager_username);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    managerName = rs.getString("Manager_name");
                }
            } catch (SQLException ex) {
                System.out.println(ex);
            } finally {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
        return managerName;
    }

    public boolean checkAccountManager(String username, String password) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                PreparedStatement pst = conn.prepareStatement("SELECT Manager_pass FROM Manager WHERE Manager_user = ?");
                pst.setString(1, username);
                ResultSet rs = pst.executeQuery();
                if (rs.next()) {
                    String storedPassword = rs.getString("Manager_pass");
                    return password.equals(storedPassword);
                }
            } catch (SQLException ex) {
                System.out.println(ex);
            } finally {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println(ex);
                }
            }
        }
        return false;
    }
}
