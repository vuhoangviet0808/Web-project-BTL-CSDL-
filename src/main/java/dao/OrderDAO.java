package dao;

import java.sql.*;

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


}
