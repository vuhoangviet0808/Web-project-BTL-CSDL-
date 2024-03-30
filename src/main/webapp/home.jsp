<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="model.ProductInCart" %>

<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
        <script src="https://kit.fontawesome.com/628d1a6561.js" crossorigin="anonymous"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="shortcut icon" href="resources/Banner/d.png" type="image/x-icon"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Linh Coffee - For The Good Teacher</title>
    </head>

    <%-- Get user information from session --%>
    <% User user = (User) session.getAttribute("user");%>
    <% String userName = null;
        if (user != null) { %>
    <% userName = "Welcome " + user.getFirst_name() + user.getLast_name();
    %>
    <% } else {%>
    <% userName = "Login";
    }%>

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


    <%-- Navbar --%>
    <style>
        .navbar {
            z-index: 1;
        }
        .navbar-nav .nav-link {
            margin-right: 10px;
            margin-left: 10px;
        }

        .navbar .navbar-nav .nav-link:hover {
            transition: 0.3s ease;
            color: #e07c51;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
        }

        .navbar .navbar-nav .nav-link {
            transition: 0.3s ease;
            color: black;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
        }

        .dropdown:hover > .dropdown-menu {
            display: block;
            transition: 0.3s ease;
        }


    </style>

    <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top"
         style="height: 60px; background-color: rgba(255, 255, 255, 0.8)">
        <!-- Container wrapper -->
        <div class="container-fluid">
            <!-- Toggle button -->
            <button
                    class="navbar-toggler"
                    type="button"
                    data-mdb-toggle="collapse"
                    data-mdb-target="#navbarCenteredExample"
                    aria-controls="navbarCenteredExample"
                    aria-expanded="false"
                    aria-label="Toggle navigation"
            >
                <i class="fas fa-bars"></i>
            </button>

            <!-- Collapsible wrapper -->
            <div
                    class="collapse navbar-collapse justify-content-center"
                    id="navbarCenteredExample"
            >
                <!-- Left links -->
                <a href="home"><img src="resources/Banner/Logo.png" width="200" height="40" alt=""></a>
                <ul class="navbar-nav">
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Cà phê</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Trà</a>
                    </li>
                    <!-- Navbar dropdown -->
                    <li class="nav-item dropdown" href="login">
                        <a class="nav-link dropdown-toggle " id="navbarDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                           style="font-size: 14px; line-height: 22px">
                            Menu
                        </a>
                        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                            <!-- Dropdown items -->
                            <a class="dropdown-item" href="product" style="font-size: 14px; line-height: 22px">Tất
                                cả</a>
                        </div>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px;">Câu chuyện</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Cửa hàng</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Tuyển dụng</a>
                    </li>
                </ul>
                <!-- Left links -->
            </div>
            <!-- Collapsible wrapper -->
        </div>
        <!-- Container wrapper -->

    </nav>


    <%-- Image slider --%>
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img class="d-block w-100" src="resources/Banner/banner1.webp" alt="First slide">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="resources/Banner/banner2.webp" alt="Second slide">
            </div>
            <div class="carousel-item">
                <img class="d-block w-100" src="resources/Banner/banner3.webp" alt="Third slide">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    <br>
    <br>


    <!-- Web body -->
    <body>

        <!-- Product card -->
        <div class="row">

            <%ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");%>
            <% for (Product prod : productList) { %>

            <style>
                /* Màu chữ mặc định */
                .card-title a {
                    color: black;
                    text-decoration: none; /* Loại bỏ gạch chân mặc định */
                    display: block;
                    word-wrap: break-word;
                    max-width: 250px;
                }

                /* Màu chữ khi hover */
                .card-title a:hover {
                    transition: 0.3s ease;
                    color: #e07c51;
                    display: block;
                    word-wrap: break-word;
                    max-width: 250px;
                }

                /* Phần viền chỉ bao quanh ảnh */
                .card {
                    border: none;
                    border-radius: 12px; /* Độ cong của góc */
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                }

                .card-img-top {
                    border-radius: 12px;
                }

                /* Loại bỏ phần viền của .card-body */
                .card-body {
                    border: none;
                }
            </style>

            <div class="col-sm-6 col-md-4 col-lg-3">
                <div class="container product-list">
                    <div class="card product">
                        <a href="product?id=<%= prod.getId() %>">
                            <img class="card-img-top"
                                 src="<%= prod.getImageURL() %>"
                                 alt="Card image cap">
                        </a>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title"><a href="product?id=<%= prod.getId() %>"><%= prod.getTitle()%>
                        </a></h5>

                        <p class="card-text"><%= CurrencyService.formatPrice(prod.getPrice()) %> đ</p>
                    </div>
                </div>
            </div>
            <% } %>
        </div>


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
    </body>
</html>