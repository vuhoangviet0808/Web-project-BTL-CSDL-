<%@ page import="model.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>

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
            <th>Action</th>
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
                         alt="Card image cap" width="10px" height="100px"></td>
                <td><%=product.getCategory_id()%></td>
                <td>
                    <button onclick="deleteProduct('<%=product.getId()%>')">-</button>
                </td>
            </tr>
        <%}%>
        <tr id="addProductRow">
            <td></td>
            <td><input type="text" id="newProductName" ></td>
            <td><input type="number" id="newProductPrice" ></td>
            <td><input type="number" id="newProductComparePrice"></td>
            <td><input type="text" id="newProductDescription"></td>
            <td><input type="file" id="newProductImage" accept="image/*"></td>
            <td><%ArrayList<Category> categories = CategoryDAO.getCategory();%>
                <select id="newProductCategory" onchange="checkOther()">
                    <%for (Category category : categories) {%>
                    <option value="<%=category.getTitle()%>"><%=category.getId()%>. <%=category.getTitle()%></option>
                    <%}%>
                    <option value="other">Khác</option>
                </select>
                <input type="text" id="otherCategoryInput" style="display:none;">
            </td>
            <td>
                <button onclick="addProduct()">+</button>
            </td>
        </tr>
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

    function addProduct() {
        var name = $("#newProductName").val();
        var price = $("#newProductPrice").val();
        var comparePrice = $("#newProductComparePrice").val();
        var description = $("#newProductDescription").val();
        var image = $("#newProductImage").val();
        var category = $("#newProductCategory").val();
        var otherCategory = $("#otherCategoryInput").val();

        if(name && price && comparePrice && description && image && categoryId) {
            if(confirm("Xác nhận thêm sản phẩm ?")) {
                $.ajax({
                    type: "POST",
                    url: "./ProcessAdminAddProduct",
                    data: {
                        productName: name,
                        productPrice: price,
                        productComparePrice: comparePrice,
                        productDescription: description,
                        image: image,
                        categoryProduct: category,
                        otherCategory: otherCategory
                    },
                    success: function (response) {
                        alert(response);
                        if (response.trim() === "success") {
                            location.reload();
                        }
                    }
                });
            }
        } else {
            alert("Vui lòng nhập đầy đủ thông tin sản phẩm mới.");
        }
    }

    function checkOther(){
        var selectBox = document.getElementById("categoryProduct");
        var otherInput = document.getElementById("otherCategoryInput");

        if(selectBox.value === "other") {
            otherInput.style.display = "block";
        } else {
            otherInput.style.display = "none";
        }
    }


</script>

