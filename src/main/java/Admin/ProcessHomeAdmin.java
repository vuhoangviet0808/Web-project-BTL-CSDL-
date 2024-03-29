package Admin;

import dao.ProductDAO;
import model.Product;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.util.ArrayList;
import model.Admin;

@WebServlet(name = "HomeAdmin", value = "/admin")
public class ProcessHomeAdmin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String s=null;
        ArrayList<Product> productList = ProductDAO.getAllProduct(s);
        request.setAttribute("productList",productList);
        RequestDispatcher dis = request.getRequestDispatcher("admin.jsp");
        dis.forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      /*  response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        Admin admin = (Admin)session.getAttribute("admin");
        if(admin == null){
            response.sendRedirect("./login");
        }
        else processRequest(request, response);*/
        HttpSession session = request.getSession();
        processRequest(request, response);
    }
}