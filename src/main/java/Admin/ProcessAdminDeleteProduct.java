package Admin;

import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "ProcessAdminDeleteProduct", value = "/ProcessAdminDeleteProduct")
public class ProcessAdminDeleteProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            int productId = Integer.parseInt(request.getParameter("productId"));
            System.out.println("proId " + productId);
            boolean deleteResult = ProductDAO.deleteProduct(productId);
            if(deleteResult) {
                out.println("success");
            } else {
                out.println("error");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}