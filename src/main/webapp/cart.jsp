<%@ page import="model.ProductInCart" %>
<%@ page import="java.util.ArrayList" %><%--
  Created by IntelliJ IDEA.
  User: LynG
  Date: 3/11/2024
  Time: 3:48 PM
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Title</title>
        <meta charset="UTF-8">
        <link rel="shortcut icon" href="resources/Banner/d.png" type="image/x-icon"/>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <title>Linh Coffee - For The Good Teacher</title>
    </head>
    <body>
        <% HttpSession session1 = request.getSession();
            ArrayList<ProductInCart> cart = (ArrayList<ProductInCart>) session1.getAttribute("cart");
            if (cart == null) { %>
        <h3>Khong co gi trong gio hang</h3>
        <%
        } else {
            for (ProductInCart prod : cart) {
        %>
        <p>
            <%= prod.getTitle()%>
            <%= prod.getPrice()%>
            <%= prod.getOption()%>
            <%= prod.getQuantity()%>
        </p>
        <br>
        <% } %>
        <% } %>

    </body>
</html>
