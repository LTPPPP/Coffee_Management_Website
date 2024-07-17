/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Le Huu Khoa - CE181099
 */
public class Staff {

    private String Staff_id;
    private String Staff_name;
    private String Staff_pic;
    private String Staff_role;
    private String Staff_user;
    private String Staff_pass;
    private String Staff_phoneNum;
    private boolean Staff_status;

    public Staff() {
    }

    public Staff(String Staff_id, String Staff_name, String Staff_pic, String Staff_role, String Staff_user, String Staff_pass, String Staff_phoneNum, boolean Staff_status) {
        this.Staff_id = Staff_id;
        this.Staff_name = Staff_name;
        this.Staff_pic = Staff_pic;
        this.Staff_role = Staff_role;
        this.Staff_user = Staff_user;
        this.Staff_pass = Staff_pass;
        this.Staff_phoneNum = Staff_phoneNum;
        this.Staff_status = Staff_status;
    }

    public String getStaff_id() {
        return Staff_id;
    }

    public void setStaff_id(String Staff_id) {
        this.Staff_id = Staff_id;
    }

    public String getStaff_name() {
        return Staff_name;
    }

    public void setStaff_name(String Staff_name) {
        this.Staff_name = Staff_name;
    }

    public String getStaff_pic() {
        return Staff_pic;
    }

    public void setStaff_pic(String Staff_pic) {
        this.Staff_pic = Staff_pic;
    }

    public String getStaff_role() {
        return Staff_role;
    }

    public void setStaff_role(String Staff_role) {
        this.Staff_role = Staff_role;
    }

    public String getStaff_user() {
        return Staff_user;
    }

    public void setStaff_user(String Staff_user) {
        this.Staff_user = Staff_user;
    }

    public String getStaff_pass() {
        return Staff_pass;
    }

    public void setStaff_pass(String Staff_pass) {
        this.Staff_pass = Staff_pass;
    }

    public String getStaff_phoneNum() {
        return Staff_phoneNum;
    }

    public void setStaff_phoneNum(String Staff_phoneNum) {
        this.Staff_phoneNum = Staff_phoneNum;
    }

    public boolean isStaff_status() {
        return Staff_status;
    }

    public void setStaff_status(boolean Staff_status) {
        this.Staff_status = Staff_status;
    }
    
    

}
