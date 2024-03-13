<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Currency" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
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
    <% String type = (String) request.getParameter("type");%>


    <!-- Top-bar -->
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

        .UserCenter {
            text-decoration: none;
            color: black;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            margin-right: 80px;
            position: relative;
            z-index: 3;
        }

        .top-bar .UserCenter:hover {
            text-decoration: none;
            color: #e07c51;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            margin-right: 80px;
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
            margin-right: 45px;
        }

        .btn.dropdown-toggle:focus {
            margin-right: 45px;
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
            margin-right: 45px;
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

    </style>

    <div class="top-bar">
        <span class="phone-icon">&#128222;</span> <!-- Biểu tượng hình điện thoại -->
        <span class="phone-number">Order: 0936 849 516</span>
        <a class="userCenter" style="z-index: 900">
            <% if (user == null) { %>
            <a href="login" class="UserCenter">Login</a>
            <% } else {%>
            <div class="dropdown UserCenter">
                <button class="btn btn-secondary dropdown-toggle" type="button" id="dropdownMenuButton"
                        data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <%= user.getLast_name() + " " + user.getFirst_name()%>
                </button>
                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                    <a class="dropdown-item" href="#">Thông tin tài khoản</a>
                    <a class="dropdown-item" href="./logout">Đăng xuất</a>
                </div>
            </div>
            <% } %>
        </a>
    </div>


    <%-- Navbar --%>
    <style>
        .navbar {
            border-bottom: 0.5px solid #bdbdbd;
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
         style="height: 60px; background-color: white">
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
    <br>
    <br>


    <!-- Web body -->
    <style>
        /* Basic Styling */
        html, body {
            height: 100%;
            width: 100%;
            margin: 0;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 15px;
            display: flex;
        }

        .left-column {
            width: 55%;
            position: relative;
        }

        .right-column {
            width: 45%;
            margin-top: 60px;
        }

        /* Left Column */
        .left-column img {
            border-radius: 15px;
            width: 80%;
            position: relative;
            left: 0;
            top: 37px;
            opacity: 0;
            transition: all 0.3s ease;
        }

        .left-column img.active {
            opacity: 1;
        }

        .left-column h1 {
            font-size: 20px;
            position: relative;
        }

        /* Product Description */
        .product-description {
            margin-bottom: 10px;
        }

        .product-description span {
            font-size: 12px;
            color: #358ED7;
            letter-spacing: 1px;
            text-transform: uppercase;
            text-decoration: none;
        }

        .product-description h1 {
            font-weight: 500;
            font-size: 25px;
            color: #43484D;

        }

        .product-description p {
            font-size: 16px;
            font-weight: 300;
            color: #86939E;
            line-height: 24px;
        }

        .product-color {
            margin-bottom: 30px;
        }

        .color-choose div {
            display: inline-block;
        }

        .color-choose input[type="radio"] {
            display: none;
        }

        .color-choose input[type="radio"] + label span {
            display: inline-block;
            width: 40px;
            height: 40px;
            margin: -1px 4px 0 0;
            vertical-align: middle;
            cursor: pointer;
            border-radius: 50%;
            border: 2px solid #FFFFFF;
            box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.33);
        }

        .color-choose input[type="radio"]#red + label span {
            background-color: #C91524;
        }

        .color-choose input[type="radio"]#blue + label span {
            background-color: #314780;
        }

        .color-choose input[type="radio"]#black + label span {
            background-color: #323232;
        }

        .color-choose input[type="radio"]:checked + label span {
            background-image: url(//product.hstatic.net/1000075078/product/1697446642_ca-phe-den-da-tui_a178a9f2d9a84425b5c5397da639bf92_large.jpg);
            background-repeat: no-repeat;
            background-position: center;
        }

        /* Cable Configuration */
        .cable-choose {
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .cable-choose button {
            border: 2px solid #E1E8EE;
            border-radius: 6px;
            padding: 13px 20px;
            font-size: 14px;
            color: #5E6977;
            background-color: #fff;
            cursor: pointer;
            transition: all .5s;
        }

        .cable-choose button:hover,
        .cable-choose button:active,
        .cable-choose button:focus {
            outline: none;
            background-color: #e07c51;
            color: white;
        }

        .cable-config {
            border-bottom: 1px solid #E1E8EE;
            margin-bottom: 20px;
        }

        .cable-config a {
            color: #358ED7;
            text-decoration: none;
            font-size: 12px;
            position: relative;
            margin: 10px 0;
            display: inline-block;
        }

        .cable-config a:before {
            content: "?";
            height: 15px;
            width: 15px;
            border-radius: 50%;
            border: 2px solid rgba(53, 142, 215, 0.5);
            display: inline-block;
            text-align: center;
            line-height: 16px;
            opacity: 0.5;
            margin-right: 5px;
        }

        .product-price {
            display: flex;
            align-items: center;
        }

        .product-price span {
            font-size: 26px;
            font-weight: 300;
            color: #43474D;
            margin-right: 20px;
        }

        .cart-btn {
            display: inline-block;
            background-color: #e07c51;
            border-radius: 6px;
            font-size: 16px;
            color: #FFFFFF;
            text-decoration: none;
            padding: 12px 30px;
            transition: all .5s;
        }

        .cart-btn:hover {
            background-color: #e07c51;
            text-decoration: none;
            color: white;
        }

        .default-link {
            color: black;
        }

        .default-link:hover {
            color: #e07c51;
            text-decoration: none;
        }
    </style>

    <body>
        <% if (prod != null) { %>
        <%-- Process product found --%>
        <main class="container">

            <!-- Left Column / Headphones Image -->
            <div class="left-column">
                <%Category productCategory = (Category) request.getAttribute("productCategory");%>
                <h1><a href="./product" class="default-link">Menu</a> <a style="color: #86939E"> / </a> <a
                        href="./product?type=<%= productCategory.getId()%>"
                        class="default-link"><%= productCategory.getTitle() %>
                </a> <a style="color: #86939E"> / </a> <a style="color: #86939E;"><%=prod.getTitle()%>
                </a></h1>
                <img data-image="red" class="active" src="<%= prod.getImageURL()%>" alt="">
            </div>


            <!-- Right Column -->
            <div class="right-column">

                <!-- Product Description -->
                <div class="product-description">
                    <h1><%= prod.getTitle()%>
                    </h1>
                </div>

                <!-- Product Pricing -->
                <div class="product-price">
                    <span style="font-size: 26px; color: #e07c51; font-weight: 600"><%= CurrencyService.formatPrice(prod.getPrice())%> đ</span>
                </div>

                <!-- Product Configuration -->
                <div class="product-configuration">
                    <br><br>
                    <!-- Cable Configuration -->
                    <div class="cable-config">
                        <span style="font-size: 16px">Chọn size (bắt buộc)</span>
                        <div class="cable-choose">
                            <button>Nhỏ + 0 đ</button>
                            <button>Vừa + 6.0000 đ</button>
                            <button>Lớn + 16.000 đ</button>
                        </div>

                    </div>
                </div>


                <a href="#" class="cart-btn">Thêm vào giỏ hàng</a>
            </div>
        </main>
        <% } else { %>
        <style>

            /*======================
                404 page
            =======================*/


            .page_404 {
                padding: 40px 0;
                background: #fff;
                font-family: 'Arvo', serif;
            }

            .page_404 img {
                width: 100%;
            }

            .four_zero_four_bg {

                background-image: url(https://cdn.dribbble.com/users/285475/screenshots/2083086/dribbble_1.gif);
                height: 400px;
                background-position: center;
            }


            .four_zero_four_bg h1 {
                font-size: 80px;
            }

            .four_zero_four_bg h3 {
                font-size: 80px;
            }

            .link_404 {
                color: #fff !important;
                padding: 10px 20px;
                background: #39ac31;
                margin: 20px 0;
                display: inline-block;
            }

            .contant_box_404 {
                margin-top: -50px;
            }
        </style>

        <section class="page_404">
            <div class="container">
                <div class="row">
                    <div class="col-sm-12 ">
                        <div class="col-sm-10 col-sm-offset-1  text-center">
                            <div class="four_zero_four_bg">
                                <h1 class="text-center ">404</h1>


                            </div>

                            <div class="contant_box_404">
                                <h3 class="h2">
                                    Lạc à bạn ơi
                                </h3>

                                <p>Hình như sản phẩm bạn tìm không có, nhưng bấm nút dưới, mình có rất nhiều món ngon
                                    đó!</p>

                                <a href="./product" class="link_404">Đây đây</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <% } %>
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