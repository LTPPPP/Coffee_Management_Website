/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DB;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    public static Connection getConnection() {

        Connection conn;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String url = "jdbc:sqlserver://LTP\\SQLEXPRESS:1433;databaseName=caphe;user=sa;password=01654460072ltp;encrypt=true;trustServerCertificate=true";
            conn = DriverManager.getConnection(url);
        } catch (ClassNotFoundException | SQLException e) {
            conn = null;
        }
        return conn;
       

    }

}
