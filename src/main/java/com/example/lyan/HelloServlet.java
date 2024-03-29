package com.example.lyan;

import dao.ProductDAO;
import model.Product;

import java.io.*;
import java.util.ArrayList;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "helloServlet", value = "/hello")
public class HelloServlet extends HttpServlet {
    private String message;

    public void init() {
        message = "Hello World!";
    }

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        ArrayList<Product> productList = ProductDAO.getAllProduct(null);
        request.setAttribute("productList", productList);
        RequestDispatcher rd = request.getRequestDispatcher("hello.jsp");
        rd.forward(request,response);
    }

    public void destroy() {
    }
}