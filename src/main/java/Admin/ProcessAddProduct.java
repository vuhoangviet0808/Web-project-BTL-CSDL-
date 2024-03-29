package Admin;

import dao.CategoryDAO;
import dao.ProductDAO;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import java.io.File;
import java.io.IOException;


@WebServlet(name = "ProcessAddProduct", value = "/addproduct")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10,      // 10MB
        maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class ProcessAddProduct extends HttpServlet {
    private static final String UPLOAD_DIRECTORY = "uploads";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

 //   @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        response.setContentType("text/html;charset=UTF-8");
//
//
//
//        String productName = request.getParameter("productName");
//        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
//        String productDescription = request.getParameter("productDescription");
//        String supplier = request.getParameter("supplier");
//        String categoryProduct = request.getParameter("categoryProduct");
//        String otherCategory = request.getParameter("otherCategory");
//        String uploadFilePath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY + File.separator + getFileName(request.getPart("fileUpload"));
//        boolean checkProductExisted = ProductDAO.checkExistedProduct(productName);
//
//        if(!checkProductExisted){
//            if(categoryProduct.equals("Khác")) {
//                boolean checkExistedCategory = CategoryDAO.checkExistedCategory(otherCategory);
//                if(!checkExistedCategory){
//                    boolean addCategory = CategoryDAO.addCategory(otherCategory);
//                    if(addCategory){
//                        boolean addProduct = ProductDAO.addProduct(otherCategory,supplier,productName,productPrice,productPrice,productDescription,uploadFilePath);
//                        if(addProduct) {
//                            response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
//                            response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
//                        } else {
//                            request.setAttribute("message", "Add Product failed. Unknown error happened.");
//                            RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/add-products.jsp");
//                            dis.forward(request, response);
//                        }
//                    } else {
//                        request.setAttribute("message", "Add Category failed. Unknown error happened.");
//                        RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/add-products.jsp");
//                        dis.forward(request, response);
//                    }
//                } else {
//                    request.setAttribute("message","Category Already Exist");
//                    RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/add-products.jsp");
//                    dis.forward(request, response);
//                }
//            } else {
//                boolean addProduct = ProductDAO.addProduct(categoryProduct,supplier,productName,productPrice,productPrice,productDescription,uploadFilePath);
//                if(addProduct) {
//                    response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
//                    response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
//                } else {
//                    request.setAttribute("message", "Add Product failed. Unknown error happened.");
//                    RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/add-products.jsp");
//                    dis.forward(request, response);
//                }
//            }
//        } else {
//            request.setAttribute("message","Ten san pham da ton tai");
//
//        }
//    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        response.setContentType("text/html; charset=UTF-8");

        String productName = request.getParameter("productName");
        int productPrice = Integer.parseInt(request.getParameter("productPrice"));
        String productDescription = request.getParameter("productDescription");
        String supplier = request.getParameter("supplier");
        String categoryProduct = request.getParameter("categoryProduct");
        String otherCategory = request.getParameter("otherCategory");
        Part filePart = request.getPart("fileUpload");
        String uploadFilePath = request.getServletContext().getRealPath("") + File.separator + UPLOAD_DIRECTORY + File.separator + getFileName(filePart);
        boolean checkProductExisted = ProductDAO.checkExistedProduct(productName);

        System.out.println("productName: " + productName);
        System.out.println("productPrice: " + productPrice);
        System.out.println("productDescription: " + productDescription);
        System.out.println("supplier: " + supplier);
        System.out.println("categoryProduct: " + categoryProduct);
        System.out.println("otherCategory: " + otherCategory);
        System.out.println("uploadFilePath: " + uploadFilePath);



        if (!checkProductExisted) {
            if (categoryProduct.equals("Khác")) {
                boolean checkExistedCategory = CategoryDAO.checkExistedCategory(otherCategory);
                if (!checkExistedCategory) {
                    boolean addCategory = CategoryDAO.addCategory(otherCategory);
                    if (addCategory) {
                        if (downfile(request, response)) {
                            boolean addProduct = ProductDAO.addProduct(otherCategory, supplier, productName, productPrice, productPrice, productDescription, uploadFilePath);
                            if (addProduct) {
                                response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
                                response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
                            } else {
                                request.setAttribute("message", "Add Product failed. Unknown error happened.");
                                RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                                dis.forward(request, response);
                            }
                        } else {
                            request.setAttribute("message", "File upload failed.");
                            RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                            dis.forward(request, response);
                        }
                    } else {
                        request.setAttribute("message", "Add Category failed. Unknown error happened.");
                        RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                        dis.forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "Category Already Exist");
                    RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                    dis.forward(request, response);
                }
            } else {
                if (downfile(request, response)) {
                    boolean addProduct = ProductDAO.addProduct(categoryProduct, supplier, productName, productPrice, productPrice, productDescription, uploadFilePath);
                    if (addProduct) {
                        response.getWriter().println("Sản phẩm " + productName + " đã được thêm thành công");
                        response.setHeader("Refresh", "3;url=" + request.getHeader("referer"));
                    } else {
                        request.setAttribute("message", "Add Product failed. Unknown error happened.");
                        RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                        dis.forward(request, response);
                    }
                } else {
                    request.setAttribute("message", "File upload failed.");
                    RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
                    dis.forward(request, response);
                }
            }
        } else {
            request.setAttribute("message", "Tên sản phẩm đã tồn tại");
            RequestDispatcher dis = request.getRequestDispatcher("pageAdmin/admin.jsp");
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
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadFilePath = applicationPath + File.separator + UPLOAD_DIRECTORY;

            File fileUploadDirectory = new File(uploadFilePath);
            if (!fileUploadDirectory.exists()) {
                fileUploadDirectory.mkdirs();
            }
            Part filePart = request.getPart("fileUpload");
            String fileName = getFileName(filePart);
            filePart.write(uploadFilePath + File.separator + fileName);
            //  response.getWriter().println("File " + fileName + " has been uploaded successfully!");
            return true;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }
}