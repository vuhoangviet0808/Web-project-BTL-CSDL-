package dao;

import model.Order;

import java.sql.*;
import java.util.ArrayList;

public class OrderDAO {
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

    public static void addOrderDetail(int orderId, int productId, int price, int quantity, int totalMoney, String size) throws SQLException {
        try (Connection c = openConnection())
        {
            String add = String.format("insert into order_details value(null,'%d','%d','%d','%d','%d','%s')", orderId, productId, price, quantity, totalMoney, size);
            PreparedStatement stm = c.prepareStatement(add);
            stm.executeUpdate();
        }
        catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static int addOrder(int userId, int totalMoney, String firstName, String lastName, String email, String phoneNumber, String address, String orderDate, String status, String note, String shippingMethod, String paymentMethod) throws SQLException {
        int orderId = -1;
        try (Connection c = openConnection()) {
            String add = String.format("insert into orders value (null,'%d','%s','%s','%s','%s','%s','%s','%s','%s','%d','%s','%s')", userId, firstName, lastName, email, phoneNumber, address, orderDate, status, note, totalMoney, shippingMethod, paymentMethod);
            String selectLastInsertIdQuery = "SELECT LAST_INSERT_ID()";
            Statement stm = c.createStatement();
            stm.executeUpdate(add);
            ResultSet rs = stm.executeQuery(selectLastInsertIdQuery);
            while (rs.next()) {
                orderId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return orderId;
    }

    public static ArrayList<Order> getAllOrder(){
        try(Connection c = openConnection()){
            String query = "Select * from orders";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ArrayList<Order> res = new ArrayList<Order>();
            while(rs.next()){
                Order order = new Order(rs.getInt("id"),rs.getInt("user_id"),rs.getString("first_name"),
                        rs.getString("last_name"),rs.getString("email"),rs.getString("phone_number"),rs.getString("address"),
                        rs.getString("order_date"),rs.getString("status"),rs.getString("note"),rs.getInt("total_money"),
                        rs.getString("shipping_method"),rs.getString("payment_method"));
                res.add(order);
            }
            return res;
        } catch(Exception ex){
            ex.printStackTrace();
        }
        return null;
    }

    public static int getTotalOrder(){
        try (Connection c = openConnection()){
            String query = "Select COUNT(*) from orders";
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                return rs.getInt(1);
            }
        }catch(Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public static ArrayList<Order> getOrderPerPage(int index, int pageSize) {
        try (Connection c = openConnection()) {
            String query = String.format("SELECT * FROM orders\n" +
                    "ORDER BY id\n" +
                    "LIMIT %d OFFSET %d;",pageSize,(index - 1)*pageSize);
            PreparedStatement ps = c.prepareStatement(query);
            ResultSet rs = ps.executeQuery();
            ArrayList<Order> res = new ArrayList<Order>();
            while(rs.next()){
                Order order = new Order(rs.getInt("id"),rs.getInt("user_id"),rs.getString("first_name"),
                        rs.getString("last_name"),rs.getString("email"),rs.getString("phone_number"),rs.getString("address"),
                        rs.getString("order_date"),rs.getString("status"),rs.getString("note"),rs.getInt("total_money"),
                        rs.getString("shipping_method"),rs.getString("payment_method"));
                res.add(order);
            }
            return res;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

}
