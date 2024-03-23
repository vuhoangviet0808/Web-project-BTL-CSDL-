package dao;

import model.Admin;

import java.sql.*;

public class AdminDAO {
    public static Connection openConnection(){
        Connection conn = null;
        try {
            System.out.println("Hello from DBConfig.driver " + DBConfig.driver);
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url,DBConfig.user,DBConfig.password);
            System.out.println("Connected successfully");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
    }


}
