<%@ page import="model.Admin" %>
<%@ page import="model.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="utils.CurrencyService" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="dao.ProductDAO" %>


<%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 23/03/2024
  Time: 8:12 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }
        .container {
            width: 80%;
            margin: 20px auto;
        }
        h1 {
            text-align: center;
        }
        .menu {
            background-color: #f0f0f0;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .menu ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
        }
        .menu ul li {
            display: inline;
            margin-right: 20px;
        }
        .content {
            border: 1px solid #ccc;
            padding: 20px;
            border-radius: 5px;
        }
    </style>
</head>




<body>
<div class="container">
    <h1>Admin Dashboard</h1>

    <!-- Menu -->
    <div class="menu">
        <ul>
            <li><a href="#" onclick="loadViewProducts()">View Products</a></li>
            <li><a href="#" onclick="addProducts()">Add Product</a></li>
            <li><a href="#">Delete Product</a></li>
            <li><a href="#">Edit Product</a></li>
            <li><a href="#">Add New Category</a></li>
            <li><a href="#">Delete Category</a></li>
            <li><a href="#">Process Order</a></li>
            <li><a href="#">Track Profit</a></li>
        </ul>
    </div>

    <!-- Nội dung -->
    <div class="content">
        <%@include file="pageAdmin/view-products.jsp" %>
    </div>


<script>
    function loadViewProducts() {
        fetch("pageAdmin/view-products.jsp")
            .then(response => response.text())
            .then(data => {
                document.querySelector(".content").innerHTML = data;
            })
            .catch(error => console.error('Error:', error));
    }

    function addProducts() {
        fetch("pageAdmin/add-products.jsp")
            .then(response => response.text())
            .then(data => {
                document.querySelector(".content").innerHTML = data;
            })
            .catch(error => console.error('Error:', error));
    }
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

</body>
</html>

