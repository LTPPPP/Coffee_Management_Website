/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBConnection;
import Models.Staff;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class StaffDAO {

    public ResultSet getAllStaff() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Staff");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllStaffWork() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Staff where Staff_status = 1");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public boolean addStaff(Staff staff) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                String sql = "INSERT INTO Staff (Staff_id, Staff_name, Staff_pic, Staff_role, Staff_user, Staff_pass, Staff_phoneNum, Staff_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, staff.getStaff_id());
                pstmt.setString(2, staff.getStaff_name());
                pstmt.setString(3, staff.getStaff_pic());
                pstmt.setString(4, staff.getStaff_role());
                pstmt.setString(5, staff.getStaff_user());
                pstmt.setString(6, staff.getStaff_pass());
                pstmt.setString(7, staff.getStaff_phoneNum());
                pstmt.setBoolean(8, staff.isStaff_status());
                int rowsAffected = pstmt.executeUpdate();
                return rowsAffected > 0;
            } catch (SQLException ex) {
                System.out.println("Error adding staff: " + ex.getMessage());
            }
        }
        return false;
    }

    public boolean deleteStaff(String staffId) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                String sql = "DELETE FROM Staff WHERE Staff_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, staffId);

                int rowsAffected = pstmt.executeUpdate();
                return rowsAffected > 0;
            } catch (SQLException ex) {
                System.out.println("Error deleting staff: " + ex.getMessage());
            }
        }
        return false;
    }

    public boolean updateStaff(Staff staff) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                String sql = "UPDATE Staff SET Staff_name=?, Staff_role=?, Staff_user=?, Staff_pass=?, Staff_phoneNum=?, Staff_status=?";
                if (staff.getStaff_pic() != null) {
                    sql += ", Staff_pic=?";
                }
                sql += " WHERE Staff_id=?";

                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, staff.getStaff_name());
                pstmt.setString(2, staff.getStaff_role());
                pstmt.setString(3, staff.getStaff_user());
                pstmt.setString(4, staff.getStaff_pass());
                pstmt.setString(5, staff.getStaff_phoneNum());
                pstmt.setBoolean(6, staff.isStaff_status());

                int paramIndex = 7;
                if (staff.getStaff_pic() != null) {
                    pstmt.setString(paramIndex++, staff.getStaff_pic());
                }
                pstmt.setString(paramIndex, staff.getStaff_id());

                int rowsAffected = pstmt.executeUpdate();
                return rowsAffected > 0;
            } catch (SQLException ex) {
                System.out.println("Error updating staff: " + ex.getMessage());
            }
        }
        return false;
    }

    public List<Staff> getStaffList() {
        List<Staff> staffList = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM Staff");
                while (rs.next()) {
                    Staff staff = new Staff(
                            rs.getString("Staff_id"),
                            rs.getString("Staff_name"),
                            rs.getString("Staff_pic"),
                            rs.getString("Staff_role"),
                            rs.getString("Staff_user"),
                            rs.getString("Staff_pass"),
                            rs.getString("Staff_phoneNum"),
                            rs.getBoolean("Staff_status")
                    );
                    staffList.add(staff);
                }
            } catch (SQLException ex) {
                System.out.println("Error getting staff list: " + ex.getMessage());
            }
        }
        return staffList;
    }

    public boolean staffIdExists(String staffId) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                String sql = "SELECT COUNT(*) FROM Staff WHERE Staff_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, staffId);
                ResultSet rs = pstmt.executeQuery();
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            } catch (SQLException ex) {
                System.out.println("Error checking staff ID existence: " + ex.getMessage());
            }
        }
        return false;
    }

    public ResultSet getStaffById(String id) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Staff where Staff_id = '" + id + "'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

}
