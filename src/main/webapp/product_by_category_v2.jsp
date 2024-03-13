<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="model.Category" %>
<!DOCTYPE html>
<html lang="en">
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
    <head>
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

    <style>
        .top-bar {
            display: flex;
            justify-content: space-between;
            background-color: #ffffff;
            color: #020202;
            padding: 5px;
            align-items: center;
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
            margin-right: 40px;
        }

        .top-bar .UserCenter:hover {
            text-decoration: none;
            color: #e07c51;
            font-size: 14px;
            line-height: 22px;
            font-weight: 600;
            margin-right: 40px;
        }

        .navbar {
            border-bottom: 0.5px solid #bdbdbd;
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
            flex: 3;
        }

        .category {
            text-decoration: none;
            color: #646464;
            font-size: 16px;
            padding: 0px 0px 8px 26px;
            line-height: 22px;
            font-weight: 600;
            margin-left: 275px;
        }

        .home-container .filter-container .category:hover {
            text-decoration: none;
            color: #e07c51;
            padding: 0px 0px 8px 26px;
            font-size: 16px;
            line-height: 22px;
            font-weight: 600;
            transition: 0.3s ease;
        }

        .sticky {
            position: sticky;
            top: 70px;
            font-size: 20px;

        }

         .selected {
            color: #e07c51;
            transition: 0.3s ease;
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



    </style>

    <%-- Get user information from session --%>
    <% User user = (User) session.getAttribute("user");%>
    <% String userName = null;
        if (user != null) { %>
    <% userName = "Welcome " + user.getFirst_name() + user.getLast_name();%>
    <% } else {%>
    <% userName = "Login";
    }%>

    <body>
        <div class="top-bar">
            <span class="phone-icon">&#128222;</span> <!-- Biểu tượng hình điện thoại -->
            <span class="phone-number">Order: 0936 849 516</span>
            <a class="UserCenter" href="login"><%=userName%>
            </a>
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
            <div class="filter-container">
                <div class="sticky">
                    <a class="category active" onclick="handleFilterByCategory(100)">Tất cả</a><br>
                    <% String categoryId = (String) request.getAttribute("categoryId"); %>
                    <% ArrayList<Category> categoryList = (ArrayList<Category>) request.getAttribute("categoryList"); %>

                    <% for (Category category : categoryList) { %>
                    <button class=" button-no-border category <%= categoryId != null && category.getId() == Integer.parseInt(categoryId) ? "selected" : "" %>"
                       onclick="handleFilterByCategory(<%= category.getId()%>)"><%= category.getTitle()%>
                    </button><br>
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

    <%-- Product card show Script--%>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            var productCards = document.querySelectorAll('.product-card');
            productCards.forEach(function (card, index) {
                setTimeout(function () {
                    card.classList.add('show');
                }, index * 30); // Thời gian hiển thị cho mỗi sản phẩm (200ms trong trường hợp này)
            });
        });
    </script>
    <script>

        // Chuyen ve dau trang khi chuyen sang category khac
        function scrollToTop() {
            // Lấy chiều cao của trang
            const windowHeight = window.innerHeight;

            // Thời gian lướt về đầu trang (2 giây)
            const duration = 3000;

            // Bước thời gian (10 miligiây)
            const step = 10;

            // Số bước cần lướt
            const steps = duration / step;

            // Kích thước bước lướt
            const scrollStep = windowHeight / steps;

            // Hàm lướt
            function animateScroll() {
                if (window.scrollY === 0) return; // Đã ở đầu trang

                // Lướt lên một bước
                window.scrollBy(0, -scrollStep);

                // Thực hiện hàm lặp lại sau một khoảng thời gian
                setTimeout(animateScroll, step);
            }

            // Bắt đầu hiệu ứng lướt
            animateScroll();
        }

        function handleFilterByCategory(id) {
            $.ajax({
                url: "./product",
                type: "get", // send through get method
                data: {
                    type: id,
                },
                success: function (data) {
                    // var productList = $(data).find('.product-list');
                    $("body").html(data);
                    scrollToTop();
                },
                error: function (xhr) {
                    // ok
                }
            });
        }
    </script>
</html>