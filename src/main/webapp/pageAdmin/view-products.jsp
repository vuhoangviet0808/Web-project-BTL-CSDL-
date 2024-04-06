<%@ page import="model.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>
<%@ page import="model.Category" %>
<%@ page import="dao.CategoryDAO" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<!doctype html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
        <meta name="generator" content="Jekyll v3.8.5">
        <title>Dashboard Template · Bootstrap</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <link rel="canonical" href="https://getbootstrap.com/docs/4.2/examples/dashboard/">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <link rel="stylesheet" href="file_js/adminPage.css">
    </head>
    <body>
    <div id="table">
    <h2>View Products</h2>

        <table border="1"  style="text-align:center">
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
                <div id="product-list">
                <%  int current_page = (request.getParameter("page") != null) ? (Integer.parseInt(request.getParameter("page"))) : 1;
                    int pageSize = 4;
                    int totalProducts = ProductDAO.getTotalProduct();
                    ArrayList<Product> productList = ProductDAO.getPerPageProduct(current_page,pageSize);
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
<%--                <tr id="addProductRow">--%>
<%--                    <td></td>--%>
<%--                    <td><input type="text" id="newProductName" ></td>--%>
<%--                    <td><input type="number" id="newProductPrice" ></td>--%>
<%--                    <td><input type="number" id="newProductComparePrice"></td>--%>
<%--                    <td><input type="text" id="newProductDescription"></td>--%>
<%--                    <td><input type="file" id="newProductImage" accept="image/*"></td>--%>
<%--                    <td><%ArrayList<Category> categories = CategoryDAO.getCategory();%>--%>
<%--                        <select id="newProductCategory" onchange="checkOther()">--%>
<%--                            <%for (Category category : categories) {%>--%>
<%--                            <option value="<%=category.getTitle()%>"><%=category.getId()%>. <%=category.getTitle()%></option>--%>
<%--                            <%}%>--%>
<%--                            <option value="other">Khác</option>--%>
<%--                        </select>--%>
<%--                        <input type="text" id="otherCategoryInput" style="display:none;">--%>
<%--                    </td>--%>
<%--                    <td>--%>
<%--                        <button onclick="addProduct()">+</button>--%>
<%--                    </td>--%>
<%--                </tr>--%>
            </div>

        </table>
            <%
                int totalPages = (int) Math.ceil((double) totalProducts / pageSize);
                for (int pageNum = 1; pageNum <= totalPages; pageNum++) {
            %>
            <button><a href="#" class="pagination-link" data-page="<%=pageNum%>"><%=pageNum%></a></button>
            <%
                }
            %>
        </div>
    </body>
</html>
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

    function loadProducts(page) {
        $.ajax({
            type: "GET",
            url: "./view-product?page=" + page,
            success: function(data) {
                $("#table").html(data);
            },
            error: function() {
                alert("Error loading products.");
            }
        });
    }

    $(document).on("click", ".pagination-link", function(e) {
        e.preventDefault();
        var page = $(this).attr("data-page");
        loadProducts(page);
    });
</script>

