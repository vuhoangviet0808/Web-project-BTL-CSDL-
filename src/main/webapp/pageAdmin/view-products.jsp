<%@ page import="model.Product" %>
<%@ page import="java.util.*" %>
<%@ page import="dao.ProductDAO" %>

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
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="file_js/adminPage.css">
</head>
<body>
<div id="table">
    <div class="container-xl">
        <div class="table-responsive">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-4">
                            <h2>Order <b>Details</b></h2>
                        </div>
<%--                        <div class="col-sm-8">--%>
<%--                            <a href="#" class="btn btn-primary" onclick="Refresh()"><i class="material-icons">&#xE863;</i> <span>Refresh List</span></a>--%>
<%--                            <a href="#" class="btn btn-secondary"><i class="material-icons">&#xE24D;</i> <span>Export to Excel</span></a>--%>
<%--                        </div>--%>
                    </div>
                </div>
                <table border="1" class="table table-striped table-hover" style="text-align:center" id="productTable">
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
                        <tbody>
                        <%
                            int pageSize = 4;
                            ArrayList<Product> productList = ProductDAO.getAllProduct(null);
                            int totalProducts = productList.size();
                            for(Product product : productList) {
                        %>
                        <tr id="productRow_<%=product.getId()%>">
                            <td><%=product.getId()%></td>
                            <td><%=product.getTitle()%></td>
                            <td><%=product.getPrice()%></td>
                            <td><%=product.getCompareAtPrice()%></td>
                            <td><%=product.getDescription()%></td>
                            <td><img class="card-img-top"
                                     src="<%= product.getImageURL() %>"
                                     alt="Card image cap" width="100" height="100"></td>
                            <td><%=product.getCategory_id()%></td>
                            <td>
                                <button onclick="deleteProduct('<%=product.getId()%>')">-</button>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                        </tbody>
                    </div>
                </table>
                <div class="clearfix">
                    <ul class="pagination" id="pagination">
                        <li class="page-item disabled"><a href="#" onclick="navigatePage('prev')">Previous</a></li>
                        <%
                            int totalPage = (int)Math.ceil((double) totalProducts / pageSize);
                            for(int pageNum = 1;pageNum <= totalPage;pageNum++) {
                        %>
                        <li class="page-item <%= pageNum == 1 ? "active" : "" %>"><a href="#" class="page-link" onclick="goToPage(<%=pageNum%>)"><%=pageNum%></a></li>
                        <%
                            }
                        %>
                        <li class="page-item"><a href="#" class="page-link" onclick="navigatePage('next')">Next</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>

<script>
    $(document).ready(function(){
        hideExtraRows();
    });

    function hideExtraRows() {
        const defaultRowCount = 5;
        $('#productTable tbody tr').slice(defaultRowCount).hide();
    }

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

    function goToPage(pageNum){
        const li = document.querySelectorAll("#pagination li");
        for (let i = 0; i < li.length; i++) {
            if (li[i].classList.contains('active')) {
                li[i].classList.remove("active");
                break;
            }
        }
        li[pageNum].classList.add("active");
        updateProductTable(pageNum);
    }

    function updateProductTable(pageNum) {
        const productPageSize = 4; // Số lượng sản phẩm trên mỗi trang
        const startIndex = (pageNum - 1) * productPageSize + 1;
        const endIndex = pageNum * productPageSize;
        const rows = $('#productTable tbody tr');

        rows.hide();
        $(rows[0]).show();
        for (let i = startIndex; i <= endIndex; i++) {
            $(rows[i]).show();
        }
    }

    function navigatePage(direction) {
        const li = document.querySelectorAll("#pagination li");
        let currentPageNumber = 1;
        for (let i = 0; i < li.length; i++) {
            if (li[i].classList.contains('active')) {
                currentPageNumber = i;
                break;
            }
        }
        if (direction === "prev" && currentPageNumber > 1) {
            goToPage(currentPageNumber - 1);
        } else if (direction === 'next' && currentPageNumber < li.length - 2) {
            goToPage(currentPageNumber + 1);
        } else if (direction === "prev" && currentPageNumber === 1) {
            goToPage(1);
        } else if (direction === "next" && currentPageNumber === li.length - 2) {
            goToPage(li.length - 2);
        }
    }

</script>
