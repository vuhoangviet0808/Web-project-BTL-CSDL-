<%@ page import="java.util.ArrayList" %>
<%@ page import="model.ProductInOrder" %>
<%@ page import="model.Order" %>
<%@ page import="utils.CurrencyService" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<style>
    .card {
        box-shadow: 0 20px 27px 0 rgb(0 0 0 / 5%);
    }

    .card {
        position: relative;
        display: flex;
        flex-direction: column;
        min-width: 0;
        word-wrap: break-word;
        background-color: #fff;
        background-clip: border-box;
        border: 0 solid rgba(0, 0, 0, .125);
        border-radius: 1rem;
    }

    .text-reset {
        --bs-text-opacity: 1;
        color: inherit !important;
    }

    a {
        color: #5465ff;
        text-decoration: none;
    }
</style>
<html lang="en">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <script src="https://kit.fontawesome.com/628d1a6561.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
          integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
          crossorigin="anonymous">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8"/>
    <title>Linh Coffee - For the good teacher</title>
    <!-- CSS -->
    <link rel="stylesheet" href="style.css"/>
    <!-- Fontawesome CDN Link -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
</head>
<%
    ArrayList<ProductInOrder> productInOrders = (ArrayList<ProductInOrder>) request.getAttribute("productInOrder");
    int ordinalNumber = Integer.parseInt(request.getAttribute("ordinal-number").toString());
    Order order = (Order) request.getAttribute("order");
%>

<body>
<div class="container-fluid">
    <div class="container">
        <!-- Title -->
        <div class="d-flex justify-content-between align-items-center py-3">
            <h2 class="h5 mb-0"><a href="#" class="text-muted"></a> Order #<%=ordinalNumber + 1%>
            </h2>
        </div>

        <!-- Main content -->
        <div class="row">
            <div class="col-lg-8">
                <!-- Details -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="mb-3 d-flex justify-content-between">
                            <div>
                                <span class="me-3"><%=order.getOrderDate()%></span>
                                <span class="me-3">#<%=ordinalNumber + 1%></span>
                                <span class="badge rounded-pill bg-info"><%=order.getStatus()%></span>
                            </div>
                        </div>

                        <table class="table table-borderless">
                            <tbody>
                            <% for (ProductInOrder prod : productInOrders) { %>
                            <tr>
                                <td>
                                    <div class="d-flex mb-2">
                                        <div class="flex-shrink-0">
                                            <img src="<%=prod.getImageURL()%>" alt="" width="35"
                                                 class="img-fluid">
                                        </div>
                                        <div class="flex-lg-grow-1 ms-3">
                                            <h6 class="small mb-0"><a href="#"
                                                                      class="text-reset">&nbsp <%=prod.getTitle()%>
                                            </a></h6>
                                            <span class="small">&nbsp Size: <%=prod.getOption()%></span>
                                        </div>
                                    </div>
                                </td>
                                <td><%=prod.getQuantity()%>
                                </td>
                                <td class="text-end"><%=CurrencyService.formatPrice(prod.getQuantity() * prod.getPrice())%>
                                </td>
                            </tr>
                            <% } %>
                            </tbody>
                            <tfoot>
                            <tr class="fw-bold">
                                <td colspan="2">Tổng (VNĐ)</td>
                                <td class="text-end"><%=CurrencyService.formatPrice(order.getTotalMoney())%>
                                </td>
                            </tr>
                            </tfoot>
                        </table>
                    </div>
                </div>

                <!-- Payment -->
                <div class="card mb-4">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-lg-6">
                                <h3 class="h6">Payment Method</h3>
                                <p><%=order.getPaymentMethod()%><br>
                                    Tổng (VNĐ): <%=CurrencyService.formatPrice(order.getTotalMoney())%> <span
                                            class="badge bg-success rounded-pill">Chưa thanh toán</span></p>
                            </div>
                            <div class="col-lg-6">
                                <h3 class="h6">Địa chỉ thanh toán</h3>
                                <address>
                                    <strong><%=order.getFirstName() + " " + order.getLastName()%>
                                    </strong><br>
                                    <%=order.getAddress()%><br>
                                    <span>SĐT: <%=order.getPhoneNumber()%>
                                            </span>
                                </address>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-4">
                <!-- Customer Notes -->
                <div class="card mb-4">
                    <div class="card-body">
                        <h3 class="h6">Note</h3>
                        <p><%=order.getNote()%>
                        </p>
                    </div>
                </div>
                <div class="card mb-4">
                    <!-- Shipping information -->
                    <div class="card-body">
                        <h3 class="h6">Thông tin giao hàng</h3>
                        <strong>Linh Express</strong>
                        <span><a href="#" class="text-decoration-underline" target="_blank">FF1234567890</a> <i
                                class="bi bi-box-arrow-up-right"></i> </span>
                        <hr>
                        <h3 class="h6">Địa chỉ</h3>
                        <address>
                            <strong><%=order.getFirstName() + " " + order.getLastName()%>
                            </strong><br>
                            <%=order.getAddress()%><br>
                            <span>SĐT: <%=order.getPhoneNumber()%></span>
                        </address>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
        integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
        integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
        integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
</html>