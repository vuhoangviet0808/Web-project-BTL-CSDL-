<%@ page import="model.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.CategoryDAO" %><%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 09/04/2024
  Time: 11:55 CH
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Add Product</title>
    <link rel="stylesheet" href = "file_js/addProduct.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
<form id="addProductForm" action="./ProcessAdminAddProduct" method="post">
    <div class="row">
        <!-- First column-->
        <div class="col-12 col-lg-8">
            <!-- Product Information -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Product information</h5>
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <label class="form-label" for="ecommerce-product-name">Name</label>
                        <input type="text" class="form-control" id="ecommerce-product-name" placeholder="Product title" name="productName" aria-label="Product title">
                    </div>
                    <!-- Description -->
                    <div class="mb-3">
                        <label class="form-label" for="ecommerce-category-description">Description <span class="text-muted">(Optional)</span></label>
                        <textarea name="productDescription" class="form-control autoExpand" id="ecommerce-category-description" rows="3" placeholder="Enter description here..." style="overflow-y:hidden;"></textarea>
                    </div>
                </div>
            </div>
            <!-- /Product Information -->
            <!-- Media -->
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 card-title">Media</h5>
                    <button class="fw-medium btn btn-primary" onclick="toggleInputUrl();">Add media from URL</button>
                </div>
                <div class="card-body">
                    <form action="./ProcessAdminAddProduct" method="post" class="dropzone needsclick" id="dropzone-basic" enctype="multipart/form-data">
                        <div class="input-group mb-3" id="urlInputField" style="display:none;">
                            <label for="imageUrlInput"></label><input name="imageUrlInput" type="text" class="form-control" placeholder="Enter Image URL" id="imageUrlInput">
                            <button class="btn btn-outline-secondary" type="button" onclick="addMediaFromUrl();">Submit</button>
                        </div>
                        <div class="dz-message needsclick my-5">
                            <p class="fs-4 note needsclick my-2">Drag and drop your image here</p>
                            <small class="text-muted d-block fs-6 my-2">or</small>
                            <span class="note needsclick btn bg-label-primary d-inline" id="btnBrowse">Browse image</span>
                        </div>
                        <div class="fallback">
                            <input name="file" type="file" multiple />
                        </div>
                        <input type="hidden" name="mediaUrl" id="mediaUrl" />
                    </form>
                </div>
            </div>
            <!-- /Media -->


        </div>
        <!-- Second column -->
        <div class="col-12 col-lg-4">
            <!-- Pricing Card -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Pricing</h5>
                </div>
                <div class="card-body">
                    <!-- Base Price -->
                    <div class="mb-3">
                        <label class="form-label" for="ecommerce-product-price">Base Price</label>
                        <input type="number" class="form-control" name="productPrice" id="ecommerce-product-price" placeholder="Price"  aria-label="Product price">
                    </div>
                    <!-- Discounted Price -->
                    <div class="mb-3">
                        <label class="form-label" for="ecommerce-product-discount-price">Discounted Price</label>
                        <input type="number" class="form-control" name="productComparePrice" id="ecommerce-product-discount-price" placeholder="Discounted Price"  aria-label="Product discounted price">
                    </div>
                </div>
            </div>
            <!-- /Pricing Card -->
            <!-- Organize Card -->
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="card-title mb-0">Organize</h5>
                </div>
                <div class="card-body">
                    <!-- Category -->
                    <div class="mb-3 col ecommerce-select2-dropdown">
                        <label class="form-label mb-1 d-flex justify-content-between align-items-center" for="category-org">
                            <span>Category</span><a href="javascript:void(0);" class="fw-medium" onclick="toggleAdd()">Add new category</a>
                        </label>
                        <label for="otherCategory"></label><input id="otherCategory" name="otherCategory" type="text" placeholder="Nhập vào một Category mới" style="display: none;">
                        <%ArrayList< Category> categoryList = CategoryDAO.getCategory();%>
                        <select name="categoryProduct" id="category-org" class="select2 form-select" data-placeholder="Select Category">
                            <%for(Category category : categoryList) {%>
                                <option value="<%=category.getTitle()%>"><%=category.getTitle()%></option>
                            <%}%>
                        </select>
                    </div>
                    <div class="mb-3 col">
                        <label class="form-label" for="supplier">Supplier</label>
                        <input type="text" class="form-control" id="supplier" placeholder="Product title" name="supplier" aria-label="Supplier">
                    </div>
                </div>
            </div>
            <!-- /Organize Card -->
        </div>
        <!-- /Second column -->
    </div>
    <div class="modal-footer">
        <button type="submit" class="btn btn-primary">Submit</button>
    </div>
</form>

</body>
</html>

<script>
    document.addEventListener('input',function (event) {
        if(event.target.classList.contains('autoExpand')) {
            adjustTextAreaHeight(event.target);
        }
    },false);

    function adjustTextAreaHeight(textarea) {
        textarea.style.height = 'auto';
        textarea.style.height = textarea.scrollHeight + 'px';
    }

    function toggleInputUrl() {
        const urlInputField = document.getElementById('urlInputField');
        if (urlInputField.style.display === "none") {
            urlInputField.style.display = "";
        } else {
            urlInputField.style.display = "none";
        }
    }

    function addMediaFromUrl() {
        const url = document.getElementById('imageUrlInput').value;
        if (url) {
            if (/^(https?:\/\/.+\.(jpeg|jpg|gif|png))(\?.*)?$/i.test(url)) {
                document.getElementById('mediaUrl').value = url;
                const displayArea = document.getElementById("urlInputField");
                const newImg = document.createElement('img');
                newImg.src = url;
                newImg.alt = "ảnh sản phẩm";
                newImg.style = "max-width: 100%; max-height: 300px;";
                displayArea.appendChild(newImg);
                document.getElementById('urlInputField').style.display = "none";
            } else {
                alert("Đường dẫn lỗi, hãy thử lại");
            }
        } else {
            alert("Hãy nhập đường dẫn của bạn.");
        }
    }
    function toggleAdd() {
        const categoryList = document.getElementById("category-org");
        const otherCategory = document.getElementById("otherCategory");
        if(categoryList.style.display === "none"){
            categoryList.style.display = "";
            otherCategory.style.display = "none";
        }
        else {
            categoryList.style.display = "none";
            otherCategory.style.display = "";
        }
    }
    function addCategory() {

    }
    document.getElementById("addProductForm").addEventListener("submit", function(event) {
       event.preventDefault();

        var productName = document.getElementById("ecommerce-product-name").value;
        var productDescription = document.getElementById("ecommerce-category-description").value;
        var productPrice = document.getElementById("ecommerce-product-price").value;
        var productComparePrice = document.getElementById("ecommerce-product-discount-price").value;
        var categoryProduct = document.getElementById("category-org").value;
        var supplier = document.getElementById("supplier").value;
        var mediaUrl = document.getElementById("mediaUrl").value;

        fetch('./ProcessAdminAddProduct', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                productName: productName,
                productDescription: productDescription,
                productPrice: productPrice,
                productComparePrice: productComparePrice,
                categoryProduct: categoryProduct,
                supplier: supplier,
                mediaUrl: mediaUrl
            })
        }).then(response => {
            if (response.ok) {
                alert("Sản phẩm được thêm thành công!");
                location.reload();
            } else {
                alert("Thêm sản phẩm thất bại");
            }
        }).catch(error => {
            console.error('Error:', error);
            alert("Có lỗi xảy ra, hãy thử lại.");
        });
    });


</script>