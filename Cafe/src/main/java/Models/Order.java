package Models;

public class Order {
    private String Customer_id;
    private String Item_id;
    private int Order_billStatus;
    private int Order_quantity;
    private String Order_responsive;
    private String Order_date;
    private Item item;
    private Customer customer;

    public Order() {
    }

    public Order(String Customer_id, String Item_id, int Order_billStatus, int Order_quantity, Item item, Customer customer) {
        this.Customer_id = Customer_id;
        this.Item_id = Item_id;
        this.Order_billStatus = Order_billStatus;
        this.Order_quantity = Order_quantity;
        this.item = item;
        this.customer = customer;
    }

    public Order(String Customer_id, String Item_id, int Order_quantity, String Order_responsive) {
        this.Customer_id = Customer_id;
        this.Item_id = Item_id;
        this.Order_quantity = Order_quantity;
        this.Order_responsive = Order_responsive;
    }

    public Order(String Customer_id, String Item_id, int Order_quantity, String Order_responsive, int Order_billStatus) {
        this.Customer_id = Customer_id;
        this.Item_id = Item_id;
        this.Order_quantity = Order_quantity;
        this.Order_responsive = Order_responsive;
        this.Order_billStatus = Order_billStatus;
    }

    public Order(String Customer_id, String Item_id, int Order_billStatus, int Order_quantity, String Order_responsive, String Order_date, Item item, Customer customer) {
        this.Customer_id = Customer_id;
        this.Item_id = Item_id;
        this.Order_billStatus = Order_billStatus;
        this.Order_quantity = Order_quantity;
        this.Order_responsive = Order_responsive;
        this.Order_date = Order_date;
        this.item = item;
        this.customer = customer;
    }

    public String getOrder_date() {
        return Order_date;
    }

    public void setOrder_date(String Order_date) {
        this.Order_date = Order_date;
    }

    
    // Getters and setters
    public String getCustomer_id() {
        return Customer_id;
    }

    public void setCustomer_id(String Customer_id) {
        this.Customer_id = Customer_id;
    }

    public String getItem_id() {
        return Item_id;
    }

    public void setItem_id(String Item_id) {
        this.Item_id = Item_id;
    }

    public int getOrder_billStatus() {
        return Order_billStatus;
    }

    public void setOrder_billStatus(int Order_billStatus) {
        this.Order_billStatus = Order_billStatus;
    }

    public int getOrder_quantity() {
        return Order_quantity;
    }

    public void setOrder_quantity(int Order_quantity) {
        this.Order_quantity = Order_quantity;
    }

    public String getOrder_responsive() {
        return Order_responsive;
    }

    public void setOrder_responsive(String Order_responsive) {
        this.Order_responsive = Order_responsive;
    }

    public Item getItem() {
        return item;
    }

    public void setItem(Item item) {
        this.item = item;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}