package controller;

import dao.UserDao;
import model.User;
import model.Admin;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


@WebServlet(name = "ProcessLogin", value = "/login")
public class ProcessLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null) {
            response.sendRedirect("./home");
        } else {
            Admin admin = (Admin) session.getAttribute("admin");
            if(admin != null){
                response.sendRedirect("./admin");

            }
            else {
                RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
                dis.forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if(username.equals("admin") && password.equals("08082004")) {
            HttpSession session = request.getSession();
            Admin admin = new Admin();
            session.setAttribute("admin",admin);
            response.sendRedirect("/lyan_war_exploded/admin");
            return;
        }
        User user = UserDao.handleLogin(username, password);
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            response.sendRedirect("/lyan_war_exploded/home");
        } else {
            request.setAttribute("message", "Login failed. Please try again.");
            RequestDispatcher dis = request.getRequestDispatcher("login.jsp");
            dis.forward(request, response);
        }
    }
}