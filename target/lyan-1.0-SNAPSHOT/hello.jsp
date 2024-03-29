<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML>
<html lang="en">
    <head>
        <!-- Google Tag Manager -->
        <script>(function(w,d,s,l,i){w[l]=w[l]||[];w[l].push({'gtm.start':
                new Date().getTime(),event:'gtm.js'});var f=d.getElementsByTagName(s)[0],
            j=d.createElement(s),dl=l!='dataLayer'?'&l='+l:'';j.async=true;j.src=
            'https://www.googletagmanager.com/gtm.js?id='+i+dl;f.parentNode.insertBefore(j,f);
        })(window,document,'script','dataLayer','GTM-58KF28J');</script>
        <!-- End Google Tag Manager -->
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <link rel="shortcut icon" href="resources/Banner/d.png" type="image/x-icon"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Linh Coffee - For The Good Teacher</title>

        <!-- ======= Icons used for dropdown (you can use your own) ======== -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.0/font/bootstrap-icons.css">

        <style type="text/css">

            .sidebar li .submenu{
                list-style: none;
                margin: 0;
                padding: 0;
                padding-left: 1rem;
                padding-right: 1rem;
            }

            .sidebar .nav-link {
                font-weight: 500;
                color: var(--bs-dark);
            }
            .sidebar .nav-link:hover {
                color: var(--bs-primary);
            }

        </style>


        <script type="text/javascript">

            document.addEventListener("DOMContentLoaded", function(){

                document.querySelectorAll('.sidebar .nav-link').forEach(function(element){

                    element.addEventListener('click', function (e) {

                        let nextEl = element.nextElementSibling;
                        let parentEl  = element.parentElement;

                        if(nextEl) {
                            e.preventDefault();
                            let mycollapse = new bootstrap.Collapse(nextEl);

                            if(nextEl.classList.contains('show')){
                                mycollapse.hide();
                            } else {
                                mycollapse.show();
                                // find other submenus with class=show
                                var opened_submenu = parentEl.parentElement.querySelector('.submenu.show');
                                // if it exists, then close all of them
                                if(opened_submenu){
                                    new bootstrap.Collapse(opened_submenu);
                                }

                            }
                        }

                    });
                })

            });
            // DOMContentLoaded  end
        </script>

    </head>


    <%-- Get user information from session --%>
    <% User user = (User) session.getAttribute("user");%>
    <% String userName = null;
        if (user != null) { %>
    <% userName = "Welcome " + user.getFirst_name() + user.getLast_name();%>
    <% } else {%>
    <% userName = "Login";
    }%>

    <!-- Top-bar -->
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
    </style>

    <div class="top-bar">
        <span class="phone-icon">&#128222;</span> <!-- Biểu tượng hình điện thoại -->
        <span class="phone-number">Order: 0936 849 516</span>
        <a class="UserCenter" href="login"><%=userName%>
        </a>
    </div>


    <%-- Navbar --%>
    <style>
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
                            <a class="dropdown-item" href="product" style="font-size: 14px; line-height: 22px">Tất cả</a>
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

    <body class="bg-light">

        <header class="section-header py-3">
            <div class="container">
                <h2>Demo page </h2>
            </div>
        </header> <!-- section-header.// -->

        <div class="container">

            <section class="section-content py-3">
                <div class="row">
                    <aside class="col-lg-3">
                        <!-- ============= COMPONENT ============== -->
                        <nav class="sidebar card py-2 mb-4">
                            <ul class="nav flex-column" id="nav_accordion">
                                <li class="nav-item">
                                    <a class="nav-link" href="#"> Link name </a>
                                </li>
                                <li class="nav-item has-submenu">
                                    <a class="nav-link" href="#"> Submenu links <i class="bi small bi-caret-down-fill"></i> </a>
                                    <ul class="submenu collapse">
                                        <li><a class="nav-link" href="#">Submenu item 1 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 2 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 3 </a> </li>
                                    </ul>
                                </li>
                                <li class="nav-item has-submenu">
                                    <a class="nav-link" href="#"> More menus <i class="bi small bi-caret-down-fill"></i> </a>
                                    <ul class="submenu collapse">
                                        <li><a class="nav-link" href="#">Submenu item 4 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 5 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 6 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 7 </a></li>
                                    </ul>
                                </li>
                                <li class="nav-item has-submenu">
                                    <a class="nav-link" href="#"> Another submenus <i class="bi small bi-caret-down-fill"></i> </a>
                                    <ul class="submenu collapse">
                                        <li><a class="nav-link" href="#">Submenu item 8 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 9 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 10 </a></li>
                                        <li><a class="nav-link" href="#">Submenu item 11 </a></li>
                                    </ul>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#"> Demo link </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#"> Menu item </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#"> Something </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="#"> Other link </a>
                                </li>
                            </ul>
                        </nav>
                        <!-- ============= COMPONENT END// ============== -->
                    </aside>
                    <main class="col-lg-9">

                        <%ArrayList<Product> productList = (ArrayList<Product>) request.getAttribute("productList");%>
                        <% for (Product product : productList) { %>
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

                        <div class="col-sm-9  col-md-9 col-lg-9">
                            <div class="container product-list">
                                <div class="card product">
                                    <a href="product?id=<%= product.getId() %>">
                                        <img class="card-img-top"
                                             src="<%= product.getImageURL() %>"
                                             alt="Card image cap">
                                    </a>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title"><a href="product?id=<%= product.getId() %>"><%= product.getTitle()%>
                                    </a></h5>
                                    <p class="card-text"><%= product.getPrice()%> đ</p>
                                </div>
                            </div>
                        </div>

                        <% } %>

                    </main>
                </div>
            </section>

        </div><!-- container //  -->

    </body>
</html>