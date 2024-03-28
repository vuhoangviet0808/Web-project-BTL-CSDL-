package controller;

import model.ProductInCart;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;


@WebServlet(name = "ProcessDeleteProduct", value = "/ProcessDeleteProduct")
public class ProcessDeleteProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        ArrayList<ProductInCart> cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        int id = Integer.parseInt(request.getParameter("id"));
        cart.remove(id);
        RequestDispatcher rq = request.getRequestDispatcher("checkout.jsp");
        rq.forward(request,response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}