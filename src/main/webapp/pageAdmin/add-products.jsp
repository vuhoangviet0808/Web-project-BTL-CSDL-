<%--
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
    <link rel="stylesheet" href = "../file_js/addProduct.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
</head>
<body>
<div class="row">
    <!-- First column-->
    <div class="col-12 col-lg-8">
        <!-- Product Information -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-tile mb-0">Product information</h5>
            </div>
            <div class="card-body">
                <div class="mb-3">
                    <label class="form-label" for="ecommerce-product-name">Name</label>
                    <input type="text" class="form-control" id="ecommerce-product-name" placeholder="Product title" name="productTitle" aria-label="Product title">
                </div>
                <div class="row mb-3">
                    <div class="col"><label class="form-label" for="ecommerce-product-sku">SKU</label>
                        <input type="number" class="form-control" id="ecommerce-product-sku" placeholder="SKU" name="productSku" aria-label="Product SKU"></div>
                    <div class="col"><label class="form-label" for="ecommerce-product-barcode">Barcode</label>
                        <input type="text" class="form-control" id="ecommerce-product-barcode" placeholder="0123-4567" name="productBarcode" aria-label="Product barcode"></div>
                </div>
                <!-- Description -->
                <div>
                    <label class="form-label">Description <span class="text-muted">(Optional)</span></label>
                    <div class="form-control p-0 pt-1">
                        <div class="comment-toolbar border-0 border-bottom">
                        </div>
                        <div class="comment-editor border-0 pb-4" id="ecommerce-category-description">
                        </div>

                    </div>
                </div>
            </div>
        </div>
        <!-- /Product Information -->
        <!-- Media -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <h5 class="mb-0 card-title">Media</h5>
                <a href="javascript:void(0);" class="fw-medium">Add media from URL</a>
            </div>
            <div class="card-body">
                <form action="/upload" class="dropzone needsclick" id="dropzone-basic">
                    <div class="dz-message needsclick my-5">
                        <p class="fs-4 note needsclick my-2">Drag and drop your image here</p>
                        <small class="text-muted d-block fs-6 my-2">or</small>
                        <span class="note needsclick btn bg-label-primary d-inline" id="btnBrowse">Browse image</span>
                    </div>
                    <div class="fallback">
                        <input name="file" type="file" />
                    </div>
                </form>
            </div>
        </div>
        <!-- /Media -->
        <!-- Variants -->
        <div class="card mb-4">
            <div class="card-header">
                <h5 class="card-title mb-0">Variants</h5>
            </div>
            <div class="card-body">
                <form class="form-repeater">
                    <div data-repeater-list="group-a">
                        <div data-repeater-item>
                            <div class="row">

                                <div class="mb-3 col-4">
                                    <label class="form-label" for="form-repeater-1-1">Options</label>
                                    <select id="form-repeater-1-1" class="select2 form-select" data-placeholder="Size">
                                        <option value="">Size</option>
                                        <option value="size">Size</option>
                                        <option value="color">Color</option>
                                        <option value="weight">Weight</option>
                                        <option value="smell">Smell</option>
                                    </select>
                                </div>

                                <div class="mb-3 col-8">
                                    <label class="form-label invisible" for="form-repeater-1-2">Not visible</label>
                                    <input type="number" id="form-repeater-1-2" class="form-control" placeholder="Enter size" />
                                </div>

                            </div>
                        </div>
                    </div>
                    <div>
                        <button class="btn btn-primary" data-repeater-create>
                            Add another option
                        </button>
                    </div>
                </form>
            </div>
        </div>
        <!-- /Variants -->
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
                    <input type="number" class="form-control" id="ecommerce-product-price" placeholder="Price" name="productPrice" aria-label="Product price">
                </div>
                <!-- Discounted Price -->
                <div class="mb-3">
                    <label class="form-label" for="ecommerce-product-discount-price">Discounted Price</label>
                    <input type="number" class="form-control" id="ecommerce-product-discount-price" placeholder="Discounted Price" name="productDiscountedPrice" aria-label="Product discounted price">
                </div>
                <!-- Charge tax check box -->
                <div class="form-check mb-2">
                    <input class="form-check-input" type="checkbox" value="" id="price-charge-tax" checked>
                    <label class="form-label" for="price-charge-tax">
                        Charge tax on this product
                    </label>
                </div>
                <!-- Instock switch -->
                <div class="d-flex justify-content-between align-items-center border-top pt-3">
                    <span class="mb-0 h6">In stock</span>
                    <div class="w-25 d-flex justify-content-end">
                        <label class="switch switch-primary switch-sm me-4 pe-2">
                            <input type="checkbox" class="switch-input" checked="">
                            <span class="switch-toggle-slider">
                  <span class="switch-on">
                    <span class="switch-off"></span>
                  </span>
                </span>
                        </label>
                    </div>
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
                <!-- Vendor -->
                <div class="mb-3 col ecommerce-select2-dropdown">
                    <label class="form-label mb-1" for="vendor">
                        Vendor
                    </label>
                    <select id="vendor" class="select2 form-select" data-placeholder="Select Vendor">
                        <option value="">Select Vendor</option>
                        <option value="men-clothing">Men's Clothing</option>
                        <option value="women-clothing">Women's-clothing</option>
                        <option value="kid-clothing">Kid's-clothing</option>
                    </select>
                </div>
                <!-- Category -->
                <div class="mb-3 col ecommerce-select2-dropdown">
                    <label class="form-label mb-1 d-flex justify-content-between align-items-center" for="category-org">
                        <span>Category</span><a href="javascript:void(0);" class="fw-medium">Add new category</a>
                    </label>
                    <select id="category-org" class="select2 form-select" data-placeholder="Select Category">
                        <option value="">Select Category</option>
                        <option value="Household">Household</option>
                        <option value="Management">Management</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Office">Office</option>
                        <option value="Automotive">Automotive</option>
                    </select>
                </div>
                <!-- Collection -->
                <div class="mb-3 col ecommerce-select2-dropdown">
                    <label class="form-label mb-1" for="collection">Collection
                    </label>
                    <select id="collection" class="select2 form-select" data-placeholder="Collection">
                        <option value="">Collection</option>
                        <option value="men-clothing">Men's Clothing</option>
                        <option value="women-clothing">Women's-clothing</option>
                        <option value="kid-clothing">Kid's-clothing</option>
                    </select>
                </div>
                <!-- Status -->
                <div class="mb-3 col ecommerce-select2-dropdown">
                    <label class="form-label mb-1" for="status-org">Status
                    </label>
                    <select id="status-org" class="select2 form-select" data-placeholder="Published">
                        <option value="">Published</option>
                        <option value="Published">Published</option>
                        <option value="Scheduled">Scheduled</option>
                        <option value="Inactive">Inactive</option>
                    </select>
                </div>
                <!-- Tags -->
                <div class="mb-3">
                    <label for="ecommerce-product-tags" class="form-label mb-1">Tags</label>
                    <input id="ecommerce-product-tags" class="form-control" name="ecommerce-product-tags" value="Normal,Standard,Premium" aria-label="Product Tags" />
                </div>
            </div>
        </div>
        <!-- /Organize Card -->
    </div>
    <!-- /Second column -->
</div>
</body>
</html>
