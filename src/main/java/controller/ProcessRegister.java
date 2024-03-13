package controller;

import dao.UserDao;
import model.User;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;


@WebServlet(name = "ProcessRegister", value = "/register")
public class ProcessRegister extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user != null)
        {
            response.sendRedirect("home");
        }
        else {
            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
            dis.forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String username = request.getParameter("userName");
        String password = request.getParameter(("password"));
        String confirmPassword = request.getParameter("c");
        String lastName = request.getParameter("lastName");
        String firstName = request.getParameter("firstName");
        String gender = request.getParameter("gender");
        String birthday = request.getParameter("dateOfBirth");

        if (password.compareTo(confirmPassword) != 0) {
            System.out.print("Password Mismatch");
            request.setAttribute("passwordMismatch", "Passwords do NOT match");
            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
            dis.forward(request, response);
            return;
        }
        boolean checkUserExisted = UserDao.checkUserExisted(username);
        if (!checkUserExisted) {
            boolean registerSuccess = UserDao.handleRegister(username, password, firstName, lastName, gender, birthday);
            if (registerSuccess) {
                response.setContentType("text/html;charset=UTF-8");
                RequestDispatcher dis = request.getRequestDispatcher("registerSuccess.jsp");
                dis.forward(request, response);
            } else {
                request.setAttribute("message", "Register failed. Unknown error happened.");
                RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
                dis.forward(request, response);
            }
        } else {
            request.setAttribute("message", "Register failed. Username already used.");
            RequestDispatcher dis = request.getRequestDispatcher("register.jsp");
            dis.forward(request, response);
        }

    }
}