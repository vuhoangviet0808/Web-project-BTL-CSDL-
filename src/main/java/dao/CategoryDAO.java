package dao;

import model.Category;

import java.sql.*;
import java.util.ArrayList;

public class CategoryDAO {
    public static Connection openConnection() {
        Connection conn = null;
        try {
            System.out.println("Hello from DBConfig.driver " + DBConfig.driver);
            Class.forName(DBConfig.driver);
            conn = DriverManager.getConnection(DBConfig.url, DBConfig.user, DBConfig.password);
            System.out.println("Connected successfully");

        } catch (Exception e) {
            e.printStackTrace();
        }
        return conn;
    }

    public static ArrayList<Category> getCategory() throws SQLException {
        ArrayList<Category> categoriesList = new ArrayList<>();
        try (Connection c = openConnection()){
            String select = "SELECT * FROM category";
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            while (rs.next())
            {
                categoriesList.add(new Category(rs.getInt("id"), rs.getString("title")));
            }
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
        return categoriesList;
    }

    public static Category getCategoryById(int id) {
        try (Connection c = openConnection()) {
            String select = String.format("SELECT * FROM category WHERE id = %d", id);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Category(rs.getInt("id"), rs.getString("title"));
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean checkExistedCategory(String otherCategory){
        try (Connection conn = openConnection()) {
            String select = String.format("Select * from category where title = '%s'",otherCategory);
            PreparedStatement ps = conn.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            return false;
        } catch (Exception ex){
            ex.printStackTrace();
        }
        return false;
    }

    public static boolean addCategory(String otherCategory) {
        try (Connection conn = openConnection()) {
            String insert = String.format("Insert into category values(null,'%s'",otherCategory);
            PreparedStatement ps = conn.prepareStatement(insert);
            ps.setString(1, otherCategory);
            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch(Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

}
