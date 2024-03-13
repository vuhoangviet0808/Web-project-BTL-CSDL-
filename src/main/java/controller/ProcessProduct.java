package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;


@WebServlet(name = "ProcessProduct", value = "/product")
public class ProcessProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = (String) request.getParameter("id");
        String type = (String) request.getParameter("type");
        System.out.println(id);
        System.out.println(type);
        if (id != null) {
            Product prod = ProductDAO.getProductById(Integer.parseInt(id));
            if (prod != null) {
                Category productCategory = CategoryDAO.getCategoryById(prod.getCategory_id());
                request.setAttribute("productCategory", productCategory);
                request.setAttribute("product", prod);
            } else {
                request.setAttribute("product", null);
                request.setAttribute("noProductFoundMessage", "Sản phẩm không tồn tại");
            }
            RequestDispatcher rd = request.getRequestDispatcher("product_v2.jsp");
            rd.forward(request, response);
        }
        else
        {
            ArrayList<Product> productList = ProductDAO.getAllProduct(type);
            request.setAttribute("productList", productList);
            request.setAttribute("categoryId", type);
            ArrayList<Category> categoriesList = null;
            try {
                categoriesList = CategoryDAO.getCategory();
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            request.setAttribute("categoryList", categoriesList);
            RequestDispatcher rd = request.getRequestDispatcher("product_by_category_v3.jsp");
            rd.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}