package Admin;

import dao.CategoryDAO;
import dao.ProductDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;


@WebServlet(name = "ProcessAddProduct", value = "/addproduct")
public class ProcessAddProduct extends HttpServlet {

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
        String productName = request.getParameter("productName");
        String productPrice = request.getParameter("productPrice");
        String productDescription = request.getParameter("productDescription");
        String supplier = request.getParameter("supplier");

        String categoryProduct = request.getParameter("categoryProduct");
        String otherCategory = request.getParameter("otherCategory");

        boolean checkProductExisted = ProductDAO.checkExistedProduct(productName);

        if(!checkProductExisted){
            if(categoryProduct.equals("Khác")) {
                boolean checkExistedCategory = CategoryDAO.checkExistedCategory(otherCategory);
                if(!checkExistedCategory){

                }
            }
        }
    }
}