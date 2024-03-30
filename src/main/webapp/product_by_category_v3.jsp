<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="model.Category" %>
<%@ page import="model.ProductInCart" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
        <script src="https://kit.fontawesome.com/628d1a6561.js" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="shortcut icon" href="resources/Banner/d.png" type="image/x-icon"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Linh Coffee - For The Good Teacher</title>
    </head>
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

        .product-list {
            flex: 7;
            float: left;
            border-left: 1px solid #bdbdbd; /* Màu và độ dày của thanh viền bên phải */
            padding-left: 35px; /* Khoảng cách từ nội dung đến thanh viền bên phải */
        }

        .home-container {
            display: flex;

        }

        .filter-container {
            flex: 2;
        }

        .category {
            text-decoration: none;
            color: #646464;
            font-size: 16px;
            line-height: 22px;
            font-weight: 600;
        }


        @media (max-width: 768px) {
            /* Khi cửa sổ có chiều rộng nhỏ hơn hoặc bằng 768px */
            .home-container .filter-container {
                margin-left: 0; /* Thiết lập lề trái về 0 */
            }

            .category {
                margin-right: 10px; /* Giảm lề phải của category khi cửa sổ thu nhỏ */
            }
        }

        .home-container .filter-container .category:hover {
            text-decoration: none;
            color: #e07c51;
            font-size: 16px;
            line-height: 22px;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .sidebar a {
            display: block;
            color: #8e1414;
            text-align: left;
            padding: 0px 30px;
            text-decoration: none;
            transition: color 0.3s ease; /* Thêm hiệu ứng chuyển màu cho thẻ a */
        }

        .sidebar a:hover {
            text-decoration: none;
            color: #e07c51;
            font-size: 16px;
            line-height: 22px;
            font-weight: 600;
            transition: 0.3s;
        }

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

        button {
            border: none;
            background-color: transparent;
            padding: 10px; /* Optional: Set padding to adjust the button size */
            cursor: pointer;
            outline: none; /* Remove outline on focus (for better aesthetics) */
        }

        button:focus {
            outline: none;
        }

        .product-card {
            opacity: 0;
            transition: opacity 0.5s ease-in-out;
        }

        .product-card.show {
            opacity: 1;
        }

        .sticky {
            position: sticky;
            top: 70px;
            font-size: 20px;
        }

        .selected {
            color: #e07c51;
        }

    </style>

    <%-- Get user information from session --%>
    <% User user = (User) session.getAttribute("user");%>

    <body>
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
                        <div class="cart-count" id="cartCount"><%=cart.size()%></div>
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

        <div class="home-container">
            <div class="filter-container col-md-3">
                <div class="sidebar col-md-11 sticky">
                    <% String categoryId = (String) request.getAttribute("categoryId"); %>
                    <button class="category <%= categoryId == null || categoryId.equals("100") ? "selected" : "" %>"
                            onclick="handleFilterByCategory(100)">Tất cả  <%-- Lựa chọn tất cả có đầu vào id = null hoặc bằng 100 --%>
                    </button>
                    <br>
                    <% ArrayList<Category> categoryList = (ArrayList<Category>) request.getAttribute("categoryList"); %>
                    <% for (Category category : categoryList) { %>
                    <button class="category <%= categoryId != null && category.getId() == Integer.parseInt(categoryId) ? "selected" : "" %>"
                            onclick="handleFilterByCategory(<%= category.getId()%>)"><%= category.getTitle()%>
                    </button>
                    <br>
                    <% } %>
                </div>
            </div>
            <br> <br>
            <div class="product-list">
                <div class="row">
                    <%ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");%>
                    <% for (Product product : productList) { %>
                    <div class="col-sm-6 col-md-4 col-lg-4">
                        <div class="container product-card">
                            <div class="card product">
                                <a href="product?id=<%= product.getId() %>">
                                    <img class="card-img-top"
                                         src="<%= product.getImageURL() %>"
                                         alt="Card image cap">
                                </a>
                            </div>
                            <div class="card-body">
                                <h5 class="card-title"><a
                                        href="product?id=<%= product.getId() %>"><%= product.getTitle()%>
                                </a></h5>
                                <p class="card-text"><%= CurrencyService.formatPrice(product.getPrice()) %> đ</p>
                            </div>
                        </div>
                    </div>

                    <% } %>
                </div>
            </div>
        </div>
    </body>
    <%-- Bootstrap Script --%>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
            integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
            integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
            crossorigin="anonymous"></script>

    <script>
        function handleFilterByCategory(id) {
            $.ajax({
                url: "./product",
                type: "get", // send through get method
                data: {
                    type: id,
                },
                success: function (data) {
                    $("body").html(data);
                    $('html, body').animate({scrollTop: 0}, 1000); // 1000 milliseconds (1 second)
                },
                error: function (xhr) {
                    // ok
                }
            });
        }
    </script>
    <script>
        $(document).ajaxComplete(function () {
            var productCards = document.querySelectorAll('.product-card');

            productCards.forEach(function (card, index) {
                setTimeout(function () {
                    card.classList.add('show');
                }, index * 50);
            });
        });
    </script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var productCards = document.querySelectorAll('.product-card');

            productCards.forEach(function (card, index) {
                setTimeout(function () {
                    card.classList.add('show');
                }, index * 50); // Thời gian hiển thị cho mỗi sản phẩm (200ms trong trường hợp này)
            });
        });
    </script>

</html>