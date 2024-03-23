<%@ page import="model.Product" %>
<%@ page import="java.util.*" %>



<h2>View Products</h2>
    <table border="1" style="text-align:center">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Price</th>
            <th>Compare at Price</th>
            <th>Description</th>
            <th>Image</th>
            <th>Category_Id</th>
        </tr>
        <%ArrayList<Product> productList = (ArrayList<Product>) session.getAttribute("productList"); %>
        <%for(Product product : productList) {%>
            <tr>
                <td><%=product.getId()%></td>
                <td><%=product.getTitle()%></td>
                <td><%=product.getPrice()%></td>
                <td><%=product.getCompareAtPrice()%></td>
                <td><%=product.getDescription()%></td>
                <td><img class="card-img-top"
                         src="<%= product.getImageURL() %>"
                         alt="Card image cap" width="50px" height="50px"></td>
                <td><%=product.getCategory_id()%></td>
            </tr>
        <%}%>
    </table>

