package controller;

import com.mysql.cj.Session;
import dao.ProductDAO;
import model.Product;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;


@WebServlet(name = "ProcessHome", value = "/home")
public class ProcessHome extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String s = null;
        ArrayList<Product> productList = ProductDAO.getAllProduct(s);
        request.setAttribute("productList", productList);
        RequestDispatcher dis = request.getRequestDispatcher("home.jsp");
        dis.forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
         //User user = (User) session.getAttribute("user");
        //if (user == null)
        //{
        //    response.sendRedirect("./login");
        //}
        //else
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws
            ServletException, IOException {

    }
}