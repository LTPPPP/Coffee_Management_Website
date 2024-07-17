/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class Item {

    private String item_id;
    private String item_name;
    private float item_price;
    private String item_pic;
    private String item_type;

    public Item() {
    }

    public Item(String item_id, String item_name, float item_price, String item_pic, String item_size) {
        this.item_id = item_id;
        this.item_name = item_name;
        this.item_price = item_price;
        this.item_pic = item_pic;
        this.item_type = item_size;
    }

    public String getItem_id() {
        return item_id;
    }

    public void setItem_id(String item_id) {
        this.item_id = item_id;
    }

    public String getItem_name() {
        return item_name;
    }

    public void setItem_name(String item_name) {
        this.item_name = item_name;
    }

    public float getItem_price() {
        return item_price;
    }

    public void setItem_price(float item_price) {
        this.item_price = item_price;
    }

    public String getItem_pic() {
        return item_pic;
    }

    public void setItem_pic(String item_pic) {
        this.item_pic = item_pic;
    }

    public String getItem_type() {
        return item_type;
    }

    public void setItem_type(String item_type) {
        this.item_type = item_type;
    }

}
