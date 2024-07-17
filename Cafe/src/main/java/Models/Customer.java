/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class Customer {

    private String customer_id;
    private String customer_name;
    private int customer_table;
    private int customer_giveOrder;
    private int customer_payment;

    public Customer() {
    }

    public Customer(String customer_id, String customer_name, int customer_table) {
        this.customer_id = customer_id;
        this.customer_name = customer_name;
        this.customer_table = customer_table;
    }

    public Customer(String customer_id, String customer_name, int customer_table, int customer_giveOrder, int customer_payment) {
        this.customer_id = customer_id;
        this.customer_name = customer_name;
        this.customer_table = customer_table;
        this.customer_giveOrder = customer_giveOrder;
        this.customer_payment = customer_payment;
    }

    public String getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(String customer_id) {
        this.customer_id = customer_id;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getCustomer_table() {
        return customer_table;
    }

    public void setCustomer_table(int customer_table) {
        this.customer_table = customer_table;
    }

    public int getCustomer_giveOrder() {
        return customer_giveOrder;
    }

    public void setCustomer_giveOrder(int customer_giveOrder) {
        this.customer_giveOrder = customer_giveOrder;
    }

    public int getCustomer_payment() {
        return customer_payment;
    }

    public void setCustomer_payment(int customer_payment) {
        this.customer_payment = customer_payment;
    }

}
