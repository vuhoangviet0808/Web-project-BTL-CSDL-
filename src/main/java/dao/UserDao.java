package dao;

import model.User;

import java.sql.*;

public class UserDao {
    public static Connection openConnection() {
        Connection conn = null;
        try {
            System.out.println("Hello from DBConfig.driver " + DBConfig.driver);
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
            System.out.println("Connected successfully");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
    }

    public static User handleLogin(String username, String password) {
        try (Connection c = openConnection()) {
            String select = String.format("select * from users where username = '%s' and password = '%s'", username, password);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"), rs.getString("first_name"), rs.getString("last_name"), rs.getString("gender"), rs.getString("birthday"));
            }
            return null;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public static boolean handleRegister(String username, String password, String first_name, String last_name, String gender, String birthday) {
        try (Connection c = openConnection())
        {
            System.out.printf("Insert record into the table...\n");
            String select = String.format("INSERT INTO users VALUES (null, '%s', '%s', '%s', '%s', '%s', '%s')", username, password, first_name, last_name, gender, birthday);
            Statement s = c.createStatement();
            int a = s.executeUpdate(select);
            return a != 0;
        }
        catch (SQLException e)
        {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean checkUserExisted(String username) {
        try (Connection c = openConnection()) {
            String select = String.format("select * from users where username = '%s'", username);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return true;
            }
            return false;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }
}
