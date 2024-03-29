<%@ page import="model.User" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.CurrencyService" %>

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
        <title>Linh Coffee - For The Good Teacher</title>

        <!-- Thêm các tệp JavaScript cần thiết cho Bootstrap -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.bundle.min.js"></script>

        <style>
            /* Các style khác không thay đổi */

            .navbar .navbar-nav {
                margin: 0 auto;
            }

            @media (max-width: 767px) {
                .navbar-nav .nav-link {
                    padding: 0.5rem 1rem;
                }
                .navbar-nav .dropdown-menu {
                    background-color: #f8f9fa;
                }
                .navbar .navbar-nav {
                    margin: 0;
                }
            }
        </style>
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



    <%-- Navbar --%>
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom sticky-top"
         style="height: 60px; background-color: rgba(255, 255, 255, 0.8)">
        <!-- Container wrapper -->
        <div class="container-fluid">
            <!-- Toggle button -->
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <!-- Collapsible wrapper -->
            <div class="collapse navbar-collapse justify-content-end" id="navbarNav">
                <!-- Left links -->
                <a href="home"><img src="resources/Banner/Logo.png" width="200" height="40" alt=""></a>
                <ul class="navbar-nav">
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Cà phê</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Cà phê</a>
                    </li>
                    <li class="navbar-item">
                        <a class="nav-link " href="#" style="font-size: 14px; line-height: 22px">Trà</a>
                    </li>
                    <!-- Navbar dropdown -->
                    <!-- Navbar dropdown -->
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button"
                           data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"
                           style="font-size: 14px; line-height: 22px">
                            Menu
                        </a>
                        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
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