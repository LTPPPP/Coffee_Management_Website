package DAO;

import DB.DBConnection;
import Models.Order;
import Models.Item;
import Models.Customer;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class OrderDAO {

    private final Connection conn;

    public OrderDAO() {
        this.conn = DBConnection.getConnection();
    }

    public int addOrder(Order obj) {
        String sql = "INSERT INTO [Order] (Customer_id, Item_id, Order_quantity, Order_responsive ,Order_billStatus) VALUES (?, ?, ?, ?, ?)";
        int count = 0;
        PreparedStatement pst = null;
        try {
            // First, check if the Customer_id exists
            String checkSql = "SELECT COUNT(*) FROM Customer WHERE Customer_id = ?";
            PreparedStatement checkPst = conn.prepareStatement(checkSql);
            checkPst.setString(1, obj.getCustomer_id());
            ResultSet rs = checkPst.executeQuery();
            if (rs.next() && rs.getInt(1) == 0) {
                throw new SQLException("Customer_id does not exist in Customer table");
            }

            // If we get here, the Customer_id exists, so proceed with insert
            pst = conn.prepareStatement(sql);
            pst.setString(1, obj.getCustomer_id());
            pst.setString(2, obj.getItem_id());
            pst.setInt(3, obj.getOrder_quantity());
            pst.setString(4, obj.getOrder_responsive());
            pst.setInt(5, 0);
            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error adding order: " + ex.getMessage(), ex);
        } finally {
            if (pst != null) {
                try {
                    pst.close();
                } catch (SQLException e) {
                    Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error closing PreparedStatement", e);
                }
            }
        }
        return count;
    }

    public int addCustomerOrder(Order order) {
        int count = 0;
        String sql = "INSERT INTO [Order] (Customer_id, Item_id, Order_quantity , Order_responsive, Order_billStatus) VALUES (?, ?, ?, ?, ?)";
        try ( PreparedStatement pst = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            pst.setString(1, order.getCustomer_id());
            pst.setString(2, order.getItem_id());
            pst.setInt(3, order.getOrder_quantity());
            pst.setString(4, order.getOrder_responsive());
            pst.setInt(5, 0);

            count = pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return count;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT o.*, c.Customer_name, c.Customer_table, i.Item_name, i.Item_price "
                + "FROM [Order] o "
                + "JOIN Customer c ON o.Customer_id = c.Customer_id "
                + "JOIN Item i ON o.Item_id = i.Item_id "
                + "WHERE o.Order_id = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, orderId);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setCustomer_id(rs.getString("Customer_id"));
                    order.setItem_id(rs.getString("Item_id"));
                    order.setOrder_quantity(rs.getInt("Order_quantity"));
                    order.setOrder_billStatus(rs.getInt("Order_billStatus"));

                    Customer customer = new Customer();
                    customer.setCustomer_id(rs.getString("Customer_id"));
                    customer.setCustomer_name(rs.getString("Customer_name"));
                    customer.setCustomer_table(rs.getInt("Customer_table"));
                    order.setCustomer(customer);

                    Item item = new Item();
                    item.setItem_id(rs.getString("Item_id"));
                    item.setItem_name(rs.getString("Item_name"));
                    item.setItem_price(rs.getFloat("Item_price"));
                    order.setItem(item);

                    return order;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, c.Customer_name, c.Customer_table, i.Item_name, i.Item_price "
                + "FROM [Order] o "
                + "JOIN Customer c ON o.Customer_id = c.Customer_id "
                + "JOIN Item i ON o.Item_id = i.Item_id "
                + "ORDER BY o.Order_billStatus ASC, o.Order_date DESC";
        try ( Statement st = conn.createStatement();  ResultSet rs = st.executeQuery(sql)) {
            while (rs.next()) {
                Order order = new Order();
                order.setCustomer_id(rs.getString("Customer_id"));
                order.setItem_id(rs.getString("Item_id"));
                order.setOrder_quantity(rs.getInt("Order_quantity"));
                order.setOrder_billStatus(rs.getInt("Order_billStatus"));
                order.setOrder_date(rs.getString("Order_date"));
                order.setOrder_responsive(rs.getString("Order_responsive"));

                Customer customer = new Customer();
                customer.setCustomer_id(rs.getString("Customer_id"));
                customer.setCustomer_name(rs.getString("Customer_name"));
                customer.setCustomer_table(rs.getInt("Customer_table"));
                order.setCustomer(customer);

                Item item = new Item();
                item.setItem_id(rs.getString("Item_id"));
                item.setItem_name(rs.getString("Item_name"));
                item.setItem_price(rs.getFloat("Item_price"));
                order.setItem(item);

                orders.add(order);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orders;
    }

    public boolean updateOrderStatus(String customerId, String itemId, int billStatus) {
        String sql = "UPDATE [Order] SET Order_billStatus = ? WHERE Customer_id = ? AND Item_id = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setInt(1, billStatus);
            pst.setString(2, customerId);
            pst.setString(3, itemId);
            int affectedRows = pst.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public boolean deleteOrder(String customerId, String itemId) {
        String sql = "DELETE FROM [Order] WHERE Customer_id = ? AND Item_id = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, customerId);
            pst.setString(2, itemId);
            int affectedRows = pst.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public List<Order> getOrdersByCustomer(String customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, i.Item_name, i.Item_price "
                + "FROM [Order] o "
                + "JOIN Item i ON o.Item_id = i.Item_id "
                + "WHERE o.Customer_id = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, customerId);
            try ( ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setCustomer_id(rs.getString("Customer_id"));
                    order.setItem_id(rs.getString("Item_id"));
                    order.setOrder_quantity(rs.getInt("Order_quantity"));
                    order.setOrder_billStatus(rs.getInt("Order_billStatus"));

                    Item item = new Item();
                    item.setItem_id(rs.getString("Item_id"));
                    item.setItem_name(rs.getString("Item_name"));
                    item.setItem_price(rs.getFloat("Item_price"));
                    order.setItem(item);

                    orders.add(order);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return orders;
    }

    public int getOrderCount() {
        String sql = "SELECT COUNT(*) FROM [Order]";
        try ( Statement st = conn.createStatement();  ResultSet rs = st.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return 0;
    }

    public List<Item> getItemsByOrderId(String customer_id) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.* FROM [Order] o "
                + "JOIN Item i ON o.Item_id = i.Item_id "
                + "JOIN Customer c ON c.Customer_id = o.Customer_id "
                + "WHERE o.Customer_id = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, customer_id);
            try ( ResultSet rs = pst.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setItem_id(rs.getString("Item_id"));
                    item.setItem_name(rs.getString("Item_name"));
                    item.setItem_price(rs.getFloat("Item_price"));
                    item.setItem_type(rs.getString("Item_type"));
                    items.add(item);
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return items;
    }

    public boolean isDuplicateOrder(String customerId, int tableId) {
        String sql = "SELECT COUNT(*) FROM [Order] o "
                + "JOIN Customer c ON o.Customer_id = c.Customer_id "
                + "WHERE c.Customer_id = ? AND c.Customer_table = ?";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, customerId);
            pst.setInt(2, tableId);
            try ( ResultSet rs = pst.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }

    public void setbillStatusAndResponsive(String name, String id) {
        String sql = "UPDATE [Order] SET Order_billStatus = 1, Order_responsive = ? WHERE Customer_id= ? ";
        PreparedStatement pst;
        try {
            pst = conn.prepareStatement(sql);
            pst.setString(1, name);
            pst.setString(2, id);
            pst.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(CustomerDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public ResultSet getAlltOrderByCusId(String id) {
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select top(1) Customer_id , Order_responsive, Order_date  from [Order] Where Customer_id = '" + id + "' order by Order_date desc");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllOrderBillZero() {
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select DISTINCT Customer_id from [Order] where Order_billStatus = 0");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getAllOrderBillOne() {
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select DISTINCT Customer_id from [Order] where Order_billStatus = 1");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public ResultSet getOrderByIdCus(String id) {
        ResultSet rs = null;
        if (conn != null) {
            try {
                Statement st = conn.createStatement();
                rs = st.executeQuery("select * from [Order] where Customer_id = '" + id + "'");
            } catch (SQLException ex) {
                System.out.println(ex);
            }
        }
        return rs;
    }

    public boolean removeOrdersByCustomerAndTable(String customerId, int tableId) {
        String sql = "DELETE FROM [Order] WHERE Customer_id = ? AND Customer_id IN (SELECT Customer_id FROM Customer WHERE Customer_table = ?)";
        try ( PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, customerId);
            pst.setInt(2, tableId);
            int affectedRows = pst.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;
    }
}
