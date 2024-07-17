/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Models;

/**
 *
 * @author Lam Tan Phat - CE181023
 */
public class Manager {

    private String manager_name;
    private String manager_username;
    private String manager_pass;

    public Manager() {
    }

    public Manager(String manager_name, String manager_username, String manager_pass) {
        this.manager_name = manager_name;
        this.manager_username = manager_username;
        this.manager_pass = manager_pass;
    }

    public String getManager_name() {
        return manager_name;
    }

    public void setManager_name(String manager_name) {
        this.manager_name = manager_name;
    }

    public String getManager_username() {
        return manager_username;
    }

    public void setManager_username(String manager_username) {
        this.manager_username = manager_username;
    }

    public String getManager_pass() {
        return manager_pass;
    }

    public void setManager_pass(String manager_pass) {
        this.manager_pass = manager_pass;
    }

}
