/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DB.DBConnection;
import static DB.DBConnection.getConnection;
import Models.Item;
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
public class ItemDAO {

    public ResultSet getAllDrink() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("SELECT * from Item Where Item_type = 'Drink'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllFood() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("SELECT * from Item Where Item_type = 'Food'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllDessert() {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("SELECT * from Item Where Item_type = 'Dessert'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM Item");
                while (rs.next()) {
                    Item item = new Item(
                            rs.getString("Item_id"),
                            rs.getString("Item_name"),
                            rs.getFloat("Item_price"),
                            rs.getString("Item_picture"),
                            rs.getString("Item_type")
                    );
                    items.add(item);
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
        return items;
    }

    public List<Item> getItemsByType(String itemType) {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM Item WHERE Item_type = '" + itemType + "'";

        try ( Connection conn = DBConnection.getConnection();  Statement st = conn.createStatement();  ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Item item = new Item(
                        rs.getString("Item_id"),
                        rs.getString("Item_name"),
                        rs.getFloat("Item_price"),
                        rs.getString("Item_picture"),
                        rs.getString("Item_type")
                );
                items.add(item);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return items;
    }

    public boolean addItem(Item item) {
        String query = "INSERT INTO Item (Item_id, Item_name, Item_price, Item_picture, Item_type) VALUES (?, ?, ?, ?, ?)";
        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, item.getItem_id());
            ps.setString(2, item.getItem_name());
            ps.setFloat(3, item.getItem_price());
            ps.setString(4, item.getItem_pic());
            ps.setString(5, item.getItem_type());
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public boolean updateItem(Item item) {
        if (item == null) {
            System.out.println("Error: Attempted to update null item");
            return false;
        }

        String query = "UPDATE Item SET Item_name = ?, Item_price = ?, Item_picture = ?, Item_type = ? WHERE Item_id = ?";
        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {

            ps.setString(1, item.getItem_name() != null ? item.getItem_name() : "");
            ps.setFloat(2, item.getItem_price());
            if (item.getItem_pic() != null && !item.getItem_pic().isEmpty()) {
                ps.setString(3, item.getItem_pic());
            } else {
                ps.setString(3, getItemById(item.getItem_id()).getItem_pic());
            }
            ps.setString(4, item.getItem_type() != null ? item.getItem_type() : "");
            ps.setString(5, item.getItem_id());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException ex) {
            System.out.println("Error updating item: " + ex.getMessage());
        }
        return false;
    }

    public boolean removeItem(String itemId) {
        String query = "DELETE FROM Item WHERE Item_id = ?";
        try ( Connection conn = DBConnection.getConnection();  PreparedStatement ps = conn.prepareStatement(query)) {
            ps.setString(1, itemId);
            ps.executeUpdate();
            return true;
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return false;
    }

    public boolean isItemExists(String id) {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;

        try {
            conn = getConnection(); // Assume this method exists to get your database connection
            String sql = "SELECT COUNT(*) FROM Item WHERE item_id = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, id);
            rs = stmt.executeQuery();

            if (rs.next()) {
                exists = rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Handle exception (log it, throw it, etc.)
        } finally {
            // Close resources
            try {
                if (rs != null) {
                    rs.close();
                }
                if (stmt != null) {
                    stmt.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return exists;
    }

    public Item getItemById(String id) {
        Connection conn = DBConnection.getConnection();
        if (conn != null) {
            try {
                String query = "SELECT * FROM Item WHERE Item_id = ?";
                try ( PreparedStatement pstmt = conn.prepareStatement(query)) {
                    pstmt.setString(1, id);
                    try ( ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            return new Item(
                                    rs.getString("Item_id"),
                                    rs.getString("Item_name"),
                                    rs.getFloat("Item_price"),
                                    rs.getString("Item_picture"),
                                    rs.getString("Item_type")
                            );
                        }
                    }
                }
            } catch (SQLException ex) {
                System.out.println("Error getting item by ID: " + ex.getMessage());
                ex.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error closing connection: " + ex.getMessage());
                }
            }
        }
        return null; // Return null if no item found or an error occurred
    }

    public ResultSet getItemByIdStaff(String id) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from Item where Item_id = '" + id + "'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getItemByIdResultSet(String id) {
        Connection conn = DBConnection.getConnection();
        ResultSet rs = null;
        if (conn != null) {
            try {
                String query = "SELECT * FROM Item WHERE Item_id = ?";
                PreparedStatement pstmt = conn.prepareStatement(query);
                pstmt.setString(1, id);
                rs = pstmt.executeQuery();
            } catch (SQLException ex) {
                System.out.println("Error getting item by ID: " + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return rs;
    }

    public static void main(String[] args) throws SQLException {
        ItemDAO obj = new ItemDAO();
        ResultSet rs = obj.getAllDrink();
        while (rs.next()) {
            System.out.println(rs.getString("Item_name"));
        }
    }
}
