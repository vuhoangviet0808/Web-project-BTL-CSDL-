package Admin;

import dao.UserDao;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;
import java.io.PrintWriter;


@WebServlet(name = "ProcessAdminStatusUser", value = "/ProcessAdminStatusUser")
public class ProcessAdminStatusUser extends HttpServlet {

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
        response.setCharacterEncoding("UTF-8");
        String userIdStr = request.getParameter("userId");
        int userId = Integer.parseInt(userIdStr);
        String action = request.getParameter("action");

        if ("lock".equals(action)) {
            try (PrintWriter out = response.getWriter()) {
                boolean statusResult = UserDao.statusUser(userId,"lock");
                if(statusResult) {
                    out.println("success");
                } else {
                    out.println("error");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else if ("unlock".equals(action)) {
            try (PrintWriter out = response.getWriter()) {
                boolean statusResult = UserDao.statusUser(userId,"unlock");
                if(statusResult) {
                    out.println("success");
                } else {
                    out.println("error");
                }
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Yêu cầu không hợp lệ");
        }
    }
}