<%@ page import="model.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
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
            <th></th>
        </tr>
        <%   ArrayList<Product> productList = ProductDAO.getAllProduct(null);
            for(Product product : productList) {%>
            <tr id="productRow_<%=product.getId()%>">
                <td><%=product.getId()%></td>
                <td><%=product.getTitle()%></td>
                <td><%=product.getPrice()%></td>
                <td><%=product.getCompareAtPrice()%></td>
                <td><%=product.getDescription()%></td>
                <td><img class="card-img-top"
                         src="<%= product.getImageURL() %>"
                         alt="Card image cap" width="50px" height="50px"></td>
                <td><%=product.getCategory_id()%></td>
                <td><button onclick="deleteProduct('<%=product.getId()%>')">-</button></td>
            </tr>
        <%}%>
    </table>

<script>
    function deleteProduct(productId){
        if(confirm("Xác nhận xóa sản phẩm ?")) {
            $.ajax ({
                type: "POST",
                url: "./ProcessAdminDeleteProduct",
                data: { productId: productId},
                success: function(response) {
                    alert(response);
                    if(response.trim() === "success"){
                        $("#productRow_" + productId).hide();
                    }
                }
            });
        }
    }
</script>

