package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import model.Category;
import model.Product;
import model.ProductInCart;

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
        // gia tien, so luong san pham, thuoc tinh san pham se duoc xu ly o  Product.jsp
        HttpSession session = request.getSession();
        ArrayList<ProductInCart> cart = new ArrayList<>();
        if (session.getAttribute("cart") != null)
        {
            cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        }
        String quantity = request.getParameter("quantity-form");
        System.out.println(quantity);
        String option = request.getParameter("option-form");
        System.out.println(option);
        String price = request.getParameter("price-form");
        System.out.println(price);
        String title = request.getParameter("title-form");
        System.out.println(title);

        ProductInCart product = new ProductInCart(title, Integer.parseInt(price), Integer.parseInt(quantity), option);
        boolean check = false;
        int cartNumber = cart.size();
        for (int i = 0; i < cartNumber; i++)
        {
            ProductInCart prod = cart.get(i);
            if (prod.equals(product))
            {
                check = true;
                prod.setQuantity(prod.getQuantity() + product.getQuantity());
                break;
            }
        }
        if (check == false) cart.add(product);


        session.setAttribute("cart", cart);

        String id = (String) request.getParameter("product-id");
        String productAddedMessage = "Product was added to cart.";

        request.setAttribute("productAddedMessage", productAddedMessage);
        Product prod = ProductDAO.getProductById(Integer.parseInt(id));
        Category productCategory = CategoryDAO.getCategoryById(prod.getCategory_id());
        request.setAttribute("productCategory", productCategory);
        request.setAttribute("product", prod);
        RequestDispatcher rd = request.getRequestDispatcher("product_v2.jsp");
        rd.forward(request, response);
        }
}