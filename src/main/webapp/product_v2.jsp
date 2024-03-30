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

    <%-- Get type from session --%>
    <% String type = (String) request.getParameter("type");
        ArrayList<ProductInCart> cart = new ArrayList<>();
        if (session.getAttribute("cart") != null) {
            cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        }
    %>


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

        /* Cable Configuration */
        .size-choose {
            margin-top: 10px;
            margin-bottom: 20px;
        }

        .quantity-button {
            border: 2px solid #E1E8EE;
            border-radius: 6px;
            padding: 13px 20px;
            font-size: 14px;
            color: #5E6977;
            background-color: #fff;
            cursor: pointer;
            transition: all .5s;
        }

        .quantity-button:hover,
        .quantity-button:active,
        .quantity-button:focus {
            outline: none;
            background-color: #e07c51;
            color: white;
        }

        .size-config {
            border-bottom: 1px solid #E1E8EE;
            margin-bottom: 20px;
        }

        .size-config a {
            color: #358ED7;
            text-decoration: none;
            font-size: 12px;
            position: relative;
            margin: 10px 0;
            display: inline-block;
        }

        .size-config a:before {
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
            border: none;
            outline: none;
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

        .clicked {
            background-color: #e07c51;
            color: white;
        }

    </style>

    <body>
        <% if (prod != null) { %>
        <%-- Process product found --%>
        <main class="container" style="border-bottom: 1px solid #bdbdbd; padding-bottom: 60px">

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
                    <div id="div-price"
                         style="font-size: 26px; color: #e07c51; font-weight: 600"><%= CurrencyService.formatPrice(prod.getPrice())%>
                        đ
                    </div>
                </div>

                <!-- Product Configuration -->
                <div class="product-configuration">
                    <br><br>
                    <!-- Cable Configuration -->
                    <div class="size-config">
                        <span style="font-size: 16px">Chọn size (bắt buộc)</span>
                        <div class="size-choose">
                            <button id="small" class="quantity-button clicked">Nhỏ + 0 đ</button>
                            <button id="medium" class="quantity-button">Vừa + 6.0000 đ</button>
                            <button id="big" class="quantity-button">Lớn + 16.000 đ</button>
                        </div>
                    </div>
                </div>

                <label for="quantity">Số lượng</label>
                <div>
                    <button type="button" onclick="decrement()">-</button>
                    <input type="text" id="quantity" name="quantity" value="1" style=""  >
                    <button type="button" onclick="increment()">+</button>
                </div>
                <br><br>
                <form method="POST" action="./product" id="add-to-cart">
                    <input type="hidden" id="image-form" name="image-form" value="<%=prod.getImageURL()%>">
                    <input type="hidden" id="title-form" name="title-form" value="<%=prod.getTitle()%>">
                    <input type="hidden" id="price-form" name="price-form" value="">
                    <input type="hidden" id="option-form" name="option-form" value="Small">
                    <input type="hidden" id="quantity-form" name="quantity-form" value="">
                    <input type="hidden" id="product-id" name="product-id" value="<%=prod.getId()%>">
                    <input class="cart-btn" type="submit"<% if (user == null ) { %> disabled
                           value="Đăng nhập để thêm vào giỏ hàng" <% } else { %> value="Thêm vào giỏ hàng" <% } %>>
                </form>

            </div>
        </main>


        <script>
            function increment() {
                var quantityField = document.getElementById('quantity');
                var currentValue = parseInt(quantityField.value);
                quantityField.value = currentValue + 1;
            }

            function decrement() {
                var quantityField = document.getElementById('quantity');
                var currentValue = parseInt(quantityField.value);
                if (currentValue > 1) {
                    quantityField.value = currentValue - 1;
                }
            }

            var optionForm = document.getElementById("option-form");
            // Lấy phần hiển thị giá tiền
            var priceDisplay = document.querySelector(".product-price div");

            // Lấy các button kích thước
            var smallButton = document.getElementById("small");
            var mediumButton = document.getElementById("medium");
            var bigButton = document.getElementById("big");
            var mediumbuttonClicked = false;
            var smallbuttonClicked = true;
            var bigbuttonClicked = false;

            // Lấy giá tiền ban đầu
            var initialPrice = <%= prod.getPrice()%>;

            // Thiết lập sự kiện click cho mỗi button
            smallButton.addEventListener("click", function () {
                updatePrice(0);
                optionForm.value = 'Small';
                if(!smallbuttonClicked){
                    smallbuttonClicked = true;
                    smallButton.classList.add("clicked");
                    if(mediumbuttonClicked) {
                        mediumButton.classList.remove("clicked");
                        mediumbuttonClicked = false;
                    }else{
                        bigButton.classList.remove("clicked");
                        bigbuttonClicked = false;
                    }
                }
            });

            mediumButton.addEventListener("click", function () {
                updatePrice(6000);
                optionForm.value = 'Medium';
                if (!mediumbuttonClicked) {
                    mediumbuttonClicked = true; // Đánh dấu button đã được click
                    mediumButton.classList.add("clicked");
                    if(smallbuttonClicked) {
                        smallButton.classList.remove("clicked");
                        smallbuttonClicked = false;
                    }else{
                        bigButton.classList.remove("clicked");
                        bigbuttonClicked = false;
                    }
                }
            });

            bigButton.addEventListener("click", function () {
                updatePrice(16000);
                optionForm.value = 'Big';
                if(!bigbuttonClicked){
                    bigbuttonClicked = true;
                    bigButton.classList.add("clicked");
                    if(mediumbuttonClicked) {
                        mediumButton.classList.remove("clicked");
                        mediumbuttonClicked = false;
                    }else{
                        smallButton.classList.remove("clicked");
                        smallbuttonClicked = false;
                    }
                }
            });

            // Hàm cập nhật giá tiền khi chọn kích thước
            function updatePrice(additionalPrice) {
                var newPrice = initialPrice + additionalPrice;
                var res = formatPrice(newPrice) + " đ";
                priceDisplay.textContent = res; // Cập nhật giá mới và định dạng số
            }

            // Process form submit

            function getQuantity() {
                return document.getElementById('quantity').value;
            }

            function formatPrice(price) {
                var tmp = price.toString();
                var count = 0;
                var res = "";
                for (var i = tmp.length - 1; i >= 0; i--) {
                    count++;
                    res = tmp.at(i) + res;
                    if (count % 3 == 0 && i != 0) {
                        res = "." + res;
                    }
                }
                return res;
            }

            function getPrice() {
                var price = document.getElementById('div-price');
                var valueWithComma = price.textContent.trim();
                var result = valueWithComma.replace('.', '');
                return result.slice(0, -2);
            }

            document.getElementById('add-to-cart').addEventListener('submit', function (event) {
                // Ngăn chặn hành động mặc định của biểu mẫu (chẳng hạn, gửi yêu cầu HTTP)
                event.preventDefault();

                // Đặt giá trị của trường ẩn trong biểu mẫu thành số lượng
                document.getElementById('quantity-form').value = getQuantity();
                document.getElementById("price-form").value = getPrice();
                // Gửi biểu mẫu
                this.submit();
            });
        </script>
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