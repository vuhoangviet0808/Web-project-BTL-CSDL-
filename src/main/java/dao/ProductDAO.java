package dao;

import model.Product;

import java.sql.*;
import java.util.ArrayList;

public class ProductDAO {
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


    public static ArrayList<Product> getAllProduct(String type) {
        ArrayList<Product> prod = new ArrayList<>();
        try (Connection c = openConnection()) {
            String where = "";
            if (type != null) {
                if (!type.equals("100"))
                    where = String.format(" where category_id = %s", type);
            }
            String select = "SELECT * FROM products" + where;
            System.out.println(select);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product prodToAdd = new Product(rs.getInt("id"), rs.getString("title"), rs.getInt("price"), rs.getInt("compare_at_price"), rs.getString("description"), rs.getString("image_url"), rs.getInt("category_id"));
                prod.add(prodToAdd);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return prod;
    }


    public static Product getProductById(int id) {
        try (Connection c = openConnection()) {
            String select = String.format("SELECT * FROM products WHERE id = %d", id);
            PreparedStatement ps = c.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Product(rs.getInt("id"), rs.getString("title"), rs.getInt("price"), rs.getInt("compare_at_price"), rs.getString("description"), rs.getString("image_url"), rs.getInt("category_id"));
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static boolean addProduct(String category, String supplier, String title, int price, int compareAtPrice, String description, String imageURL) {
        try (Connection c = openConnection()) {
            String add = String.format("INSERT INTO products VALUE (null, '%s', %d, %d, '%s', '%s', %d)", title,price,compareAtPrice,description,imageURL,CategoryDAO.getIdByCategory(category).getId());
            int a;
            try (Statement s = c.createStatement()) {
                a = s.executeUpdate(add);
            }
            return a != 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static boolean checkExistedProduct(String productName) {
        try (Connection conn = openConnection()) {
            String select = String.format("Select * from products where title = '%s'",productName);
            PreparedStatement ps = conn.prepareStatement(select);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return true;
            }
            return false;
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return false;
    }

    public static boolean deleteProduct(int productId) {
        try (Connection c = openConnection()) {
            System.out.println(productId);
            String delete = String.format("delete from products where id = %d",productId);
            PreparedStatement ps = c.prepareStatement(delete);
            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                return true; // Trả về true nếu xóa thành công
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public static int getTotalProduct() {
        try (Connection c = openConnection()) {
            String query = "Select COUNT(*) from products";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static ArrayList<Product> getPerPageProduct(int index,int pageSize) {
        try (Connection c = openConnection()) {
            String query = String.format("SELECT * FROM products\n" +
                    "ORDER BY id\n" +
                    "LIMIT %d OFFSET %d;",pageSize,(index - 1)*pageSize);
            ArrayList<Product> res = new ArrayList<>();
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                Product prodToAdd = new Product(rs.getInt("id"), rs.getString("title"), rs.getInt("price"), rs.getInt("compare_at_price"), rs.getString("description"), rs.getString("image_url"), rs.getInt("category_id"));
                res.add(prodToAdd);
            }
            return res;
        } catch(Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
