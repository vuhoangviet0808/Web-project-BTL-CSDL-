package Admin;

import dao.CategoryDAO;
import dao.ProductDAO;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.File;
import java.io.IOException;



@WebServlet(name = "ProcessAdminAddProduct", value = "/ProcessAdminAddProduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProcessAdminAddProduct extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/add-products.jsp");
        dis.forward(request,response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        response.setContentType("text/html; charset=UTF-8");

        String productName = request.getParameter("productName");
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
        int productComparePrice = Integer.parseInt(request.getParameter("productComparePrice"));
        String productDescription = request.getParameter("productDescription");
        String supplier = request.getParameter("supplier");
        String categoryProduct = request.getParameter("categoryProduct");
        String otherCategory = request.getParameter("otherCategory");
        Part filePart = request.getPart("fileUpload");
        String uploadFilePath = "target\\lyan-1.0-SNAPSHOT\\resources\\uploads"+ File.separator + getFileName(filePart);

        boolean checkProductExisted = ProductDAO.checkExistedProduct(productName);
        System.out.println("filePath"+ uploadFilePath);



        if (!checkProductExisted) {
            if (categoryProduct.equals("Khác")) {
                boolean checkExistedCategory = CategoryDAO.checkExistedCategory(otherCategory);
                if (!checkExistedCategory) {
                    boolean addCategory = CategoryDAO.addCategory(otherCategory);
                    if (addCategory) {
                        if (downfile(request, response)) {
                            boolean addProduct = ProductDAO.addProduct(otherCategory, supplier, productName, productPrice, productComparePrice, productDescription, uploadFilePath);
                            if (addProduct) {
                                response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
                                response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
                            } else {
                                request.setAttribute("message", "Add Product failed. Unknown error happened.");
                                RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                                dis.forward(request, response);
                            }
                        } else {
                            request.setAttribute("message", "File upload failed.");
                            RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                            dis.forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Add Category failed. Unknown error happened.");
                        RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                        dis.forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Category Already Exist");
                    RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                    dis.forward(request, response);
                }
            } else {
                if (downfile(request, response)) {
                    boolean addProduct = ProductDAO.addProduct(categoryProduct, supplier, productName, productPrice, productComparePrice, productDescription, uploadFilePath);
                    if (addProduct) {
                        response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
                        response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
                    } else {
                        request.setAttribute("message", "Add Product failed. Unknown error happened.");
                        RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                        dis.forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "File upload failed.");
                    RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
                    dis.forward(request, response);
                }
            }
        } else {
            request.setAttribute("message", "Tên sản phẩm đã tồn tại");
            RequestDispatcher dis = request.getRequestDispatcher("admin_v2.jsp");
            dis.forward(request, response);
        }
    }

    private String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf("=") + 2, token.length()-1);
            }
        }
        return "";
    }

    private boolean downfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String uploadFilePath = request.getServletContext().getRealPath("/resources/uploads");
            System.out.println(uploadFilePath);
            File fileUploadDirectory = new File(uploadFilePath);
            if (!fileUploadDirectory.exists()) {
                fileUploadDirectory.mkdirs();
            }
            Part filePart = request.getPart("fileUpload");
            String fileName = getFileName(filePart);
            filePart.write(uploadFilePath +File.separator + fileName);
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}