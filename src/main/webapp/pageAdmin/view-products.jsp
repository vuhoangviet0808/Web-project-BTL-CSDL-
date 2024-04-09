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
                        <div class="col-sm-8">
                            <h2>Product <b>Details</b></h2>
                        </div>
                        <div class="col-sm-4">
                            <button type="button" class="btn btn-info add-new"><i class="fa fa-plus"></i> Add New</button>
                        </div>
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
                            <td style="text-align: center;vertical-align: middle;">
                                <button type="button" class="btn btn-outline-info btn-circle btn-sm ml-1" onclick="deleteProduct('<%=product.getId()%>')"><i class="fa fa-trash"></i></button>
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
<!-- Add Product Modal -->
<div class="modal" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="addProductModalLabel">Add New Product</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <iframe id="addProductIframe" src="" style="width:100%;height:400px;border:none;"></iframe>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
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
        const productPageSize = <%=pageSize%>;
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

    $(document).ready(function(){
        hideExtraRows();

        $('.add-new').click(function() {
            $('#addProductIframe').attr('src', 'url_to_your_add_product_page.html');
            $('#addProductModal').modal('show');
        });
    });


</script>
