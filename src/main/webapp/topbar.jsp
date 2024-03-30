<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Currency" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="model.Category" %>
<%@ page import="model.ProductInCart" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
        <script src="https://kit.fontawesome.com/628d1a6561.js" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/he@1.2.0/he.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="shortcut icon" href="resources/Banner/d.png" type="image/x-icon"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <% Product prod = (Product) request.getAttribute("product"); %>
        <% if (prod == null) { %>
        <title>Linh Coffee - For The Good Teacher</title>
        <%} else { %>
        <title><%= prod.getTitle()%>
        </title>
        <% } %>
    </head>

    <%-- Get user information from session --%>
    <% User user = (User) session.getAttribute("user");%>
    <% String userName = null;
        if (user != null) { %>
    <% userName = "Welcome " + user.getFirst_name() + user.getLast_name();%>
    <% } else {%>
    <% userName = "Login";
    }%>

    <%-- Get type from session --%>
    <% String type = (String) request.getParameter("type");
        ArrayList<ProductInCart> cart = new ArrayList<>();
        if (session.getAttribute("cart") != null) {
            cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        }
    %>

    <% String productAddedMessage = (String) request.getAttribute("productAddedMessage");
        if (productAddedMessage != null) {%>
    <style>
        .notification {
            position: fixed;
            bottom: 20px;
            right: 30px;
            background-color: #e07c51;
            color: #ffffff;
            padding: 10px 20px;
            border-radius: 5px;
            box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
            opacity: 0;
            transition: opacity 0.3s ease;
            z-index: 9999;
        }

        .show {
            opacity: 1;
        }
    </style>

    <div class="notification" id="notification">Sản phẩm đã được thêm vào giỏ hàng</div>

    <script src="script.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            var notification = document.getElementById('notification');
            notification.classList.add('show');

            setTimeout(function () {
                notification.classList.remove('show');
            }, 3000);
        });
    </script>

    <% } %>


    <!-- Top-bar -->
    <%  ArrayList<ProductInCart> cart = new ArrayList<>();
        if (session.getAttribute("cart") != null) {
            cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        }
    %>
    <style>

        .top-bar {
            display: flex;
            justify-content: space-between;
            background-color: #ffffff;
            color: #020202;
            padding: 5px;
            align-items: center;
            position: relative;
            z-index: 2;
        }

        .phone-icon {
            font-size: 15px;
            margin-right: 5px;
        }

        .phone-number {
            margin-right: auto;
            color: #e07c51;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
        }

        .text-highlight {
            text-decoration: none;
            color: black;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            position: relative;
            z-index: 3;
        }

        .top-bar .text-highlight:hover {
            text-decoration: none;
            color: #e07c51;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;

            z-index: 3;
        }

        .btn.dropdown-toggle {
            color: black;
            text-decoration: none;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            background-color: transparent !important;
            border: none !important;

        }

        .btn.dropdown-toggle:focus {

            color: #e07c51;
            text-decoration: none;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            background-color: transparent !important;
            border: none !important;
            outline: none;
        !important;
            box-shadow: none !important;
        }

        .btn.dropdown-toggle:hover {

            color: #e07c51;
            text-decoration: none;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            background-color: transparent !important;
            border: none !important;
            outline: none;
        }

        .dropdown-toggle::after {
            display: none !important;
        }

        .cart-count {
            position: absolute;
            top: -8px; /* Điều chỉnh vị trí theo y để số lượng được hiển thị bên trong biểu tượng */
            right: -8px; /* Điều chỉnh vị trí theo x để số lượng được hiển thị bên trong biểu tượng */
            background-color: #e07c51; /* Màu nền */
            color: white; /* Màu chữ */
            border-radius: 50%; /* Bo tròn viền */
            width: 20px; /* Độ rộng */
            height: 20px; /* Chiều cao */
            text-align: center; /* Căn giữa nội dung */
            line-height: 20px; /* Chỉnh chiều cao dòng */
            font-size: 12px; /* Kích thước chữ */
        }

        .user-cart-container {
            display: flex;
            align-items: center;
            margin-right: 80px;
        }

        .user-cart-container .text-highlight {
            margin-right: 2px;
        }

    </style>



    <div class="top-bar">
        <span class="phone-icon">&#128222;</span>
        <span class="phone-number">Order: 0936 849 516</span>
        <div class="user-cart-container">
            <% if (user == null) { %>
            <a href="login" class="text-highlight">Login</a>
            <% } else { %>
            <div class="d-flex align-items-center">
                <a href="./cart" class="text-highlight" style="font-size: 24px; position: relative;">
                    <i class="fa-solid fa-cart-shopping"></i>
                    <div class="cart-count" id="cartCount">0</div>
                </a>
                <div class="dropdown text-highlight">
                    <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                            data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <%= user.getLast_name() + " " + user.getFirst_name()%>
                    </button>
                    <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                        <a class="dropdown-item" href="#">Thông tin tài khoản</a>
                        <a class="dropdown-item" href="./logout">Đăng xuất</a>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </div>



    <script src="script.js"></script>
    <script>

        // Số lượng sản phẩm trong giỏ hàng được lưu trong biến cartItemCount
        var cartItemCount = <%= cart.size() %>; // Đổi số lượng sản phẩm ở đây

        // Cập nhật số lượng sản phẩm trong biểu tượng giỏ hàng
        function updateCartCount() {
            var cartCountElement = document.getElementById('cartCount');
            cartCountElement.textContent = cartItemCount;

            // Ẩn phần tử cart-count nếu số lượng sản phẩm là 0
            if (cartItemCount === 0) {
                cartCountElement.style.display = 'none';
            } else {
                cartCountElement.style.display = 'block'; // Hiển thị phần tử nếu số lượng sản phẩm không phải là 0
            }
        }

        // Cập nhật số lượng sản phẩm khi trang được tải
        document.addEventListener('DOMContentLoaded', function () {
            updateCartCount();
        });

    </script>


    <%-- Bootstrap Script --%>
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
            integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

</html>