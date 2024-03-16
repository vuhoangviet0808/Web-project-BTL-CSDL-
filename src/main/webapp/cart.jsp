<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ProductInCart" %><%--
  Created by IntelliJ IDEA.
  User: LynG
  Date: 3/16/2024
  Time: 5:08 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
            <% HttpSession session1 = request.getSession();
                ArrayList<ProductInCart> cart = (ArrayList<ProductInCart>) session1.getAttribute("cart");
                if(cart == null){ %>
            <h3>Khong co gi trong gio hang</h3>
            <%}%>


    </body>
</html>
