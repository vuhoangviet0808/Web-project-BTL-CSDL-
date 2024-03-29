<%@ page import="model.User" %>
<%@ page import="model.ProductInCart" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="model.Product" %>
<%@ page import="utils.CurrencyService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!doctype html>
<html lang="en">
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <meta name="description" content="">
        <meta name="author" content="">
        <link rel="icon" href="/docs/4.0/assets/img/favicons/favicon.ico">
        <link rel="canonical" href="https://getbootstrap.com/docs/4.0/examples/checkout/">

        <!-- Bootstrap core CSS -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
              integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
              crossorigin="anonymous">
        <!-- Custom styles for this template -->
        <link href="form-validation.css" rel="stylesheet">
    </head>

    <style>
        .delete-button:hover
        {
            color:#e07c51;
        }
        .delete-button
        {
            color: #86939E;
        }
    </style>
    <% User user = (User) session.getAttribute("user");%>
    <%
        ArrayList<ProductInCart> cart = (ArrayList<ProductInCart>) session.getAttribute("cart");
        if (cart == null) {
            response.sendRedirect("./home");
        }
    %>
    <% if (cart != null) { %>
    <body class="bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h4 class="mb-3">Billing address</h4>
                    <form class="needs-validation" novalidate>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstName">First name</label>
                                <input type="text" class="form-control" id="firstName" placeholder=""
                                       value="<%if (user != null) { %> <%=user.getFirst_name()%> <% } %>" required>
                                <div class="invalid-feedback">
                                    Valid first name is required.
                                </div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastName">Last name</label>
                                <input type="text" class="form-control" id="lastName" placeholder=""
                                       value="<%if (user != null) { %> <%=user.getLast_name()%> <% } %>" required>
                                <div class="invalid-feedback">
                                    Valid last name is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <%--                            Auto fill current Address. In case address is null, user can update by hand,--%>
                            <%--                            and when send order, the address will be updated and store on user table based on the address in order form--%>
                            <label for="Address">Address</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="address" placeholder="Address" required>
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your address is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="Number">Phone number</label>
                            <div class="input-group">
                                <input type="text" class="form-control" id="number" placeholder="Number" required>
                                <div class="invalid-feedback" style="width: 100%;">
                                    Your number is required.
                                </div>
                            </div>
                        </div>

                        <div class="mb-3">
                            <label for="email">Email <span class="text-muted">(Optional)</span></label>
                            <input type="email" class="form-control" id="email" placeholder="you@example.com">
                            <div class="invalid-feedback">
                                Please enter a valid email address for shipping updates.
                            </div>
                        </div>
                        <hr class="mb-4">
                        <div class="custom-control custom-checkbox">
                            <input type="checkbox" class="custom-control-input" id="save-info">
                            <label class="custom-control-label" for="save-info">Save this information for next
                                time</label>
                        </div>
                        <hr class="mb-4">

                        <h4 class="mb-3">Payment</h4>

                        <div class="d-block my-3">
                            <div class="custom-control custom-radio">
                                <input id="credit" name="paymentMethod" type="radio" class="custom-control-input"
                                       checked required>
                                <label class="custom-control-label" for="credit">Ship COD</label>
                            </div>
                            <%--                            <div class="custom-control custom-radio">--%>
                            <%--                                <input id="debit" name="paymentMethod" type="radio" class="custom-control-input" required>--%>
                            <%--                                <label class="custom-control-label" for="debit">Debit card</label>--%>
                            <%--                            </div>--%>
                            <%--                            <div class="custom-control custom-radio">--%>
                            <%--                                <input id="paypal" name="paymentMethod" type="radio" class="custom-control-input" required>--%>
                            <%--                                <label class="custom-control-label" for="paypal">Paypal</label>--%>
                            <%--                            </div>--%>
                        </div>
                        <hr class="mb-4">
                        <button class="btn btn-primary btn-lg btn-block" type="submit">Continue to checkout</button>
                    </form>
                </div>
                <div class="col-md-6" id="your-cart">
                    <h4 class="d-flex justify-content-between align-items-center mb-3">
                        <span class="text-muted">Your cart</span>
                        <span class="badge badge-secondary badge-pill"><%= cart.size()%></span>
                    </h4>
                    <ul class="list-group mb-3">
                        <% int totalPrice = 0;
                           int index = 0;%>
                        <% for (ProductInCart prod : cart) {%>
                        <li class="list-group-item d-flex justify-content-between lh-condensed">
                            <div>

                                <h6 class="my-0"><img src="<%=prod.getImageURL()%>" style="max-width: 10%; height: auto">  <%=prod.getQuantity()%> x <%=prod.getTitle()%></h6>
                                <small class="text-muted"><%=prod.getOption()%></small><br>
                                <small class="delete-button" style="cursor: pointer" onclick="handleDeleteProduct(<%=index%>)">Delete</small>
                            </div>
                            <span class="text-muted"><%=CurrencyService.formatPrice(prod.getPrice() * prod.getQuantity())%></span>
                        </li>
                        <%  totalPrice += prod.getPrice() * prod.getQuantity();
                            index++;
                        } %>
                        <%--                        <li class="list-group-item d-flex justify-content-between bg-light">--%>
                        <%--                            <div class="text-success">--%>
                        <%--                                <h6 class="my-0">Promo code</h6>--%>
                        <%--                                <small>EXAMPLECODE</small>--%>
                        <%--                            </div>--%>
                        <%--                            <span class="text-success">-$5</span>--%>
                        <%--                        </li>--%>
                        <li class="list-group-item d-flex justify-content-between">
                            <span>Total (VND)</span>
                            <strong><%=CurrencyService.formatPrice(totalPrice)%> VND</strong>
                        </li>
                    </ul>

                    <form class="card p-2">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="Promo code">
                            <div class="input-group-append">
                                <button type="submit" class="btn btn-secondary">Redeem</button>
                            </div>
                        </div>
                    </form>
                </div>

            </div>

            <footer class="my-5 pt-5 text-muted text-center text-small">
                <p class="mb-1">&copy; 2017-2018 Company Name</p>
                <ul class="list-inline">
                    <li class="list-inline-item"><a href="#">Privacy</a></li>
                    <li class="list-inline-item"><a href="#">Terms</a></li>
                    <li class="list-inline-item"><a href="#">Support</a></li>
                </ul>
            </footer>
        </div>

        <!-- Bootstrap core JavaScript
        ================================================== -->
        <!-- Placed at the end of the document so the pages load faster -->
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"
                integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
                crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"
                integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
                crossorigin="anonymous"></script>
        <script>
            // Example starter JavaScript for disabling form submissions if there are invalid fields
            (function () {
                'use strict';

                window.addEventListener('load', function () {
                    // Fetch all the forms we want to apply custom Bootstrap validation styles to
                    var forms = document.getElementsByClassName('needs-validation');

                    // Loop over them and prevent submission
                    var validation = Array.prototype.filter.call(forms, function (form) {
                        form.addEventListener('submit', function (event) {
                            if (form.checkValidity() === false) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        }, false);
                    });
                }, false);
            })();
        </script>
    </body>
    <script>
        function handleDeleteProduct(id) {
            $.ajax({
                url: "./ProcessDeleteProduct",
                type: "get", // send through get method
                data: {
                    id: id,
                },
                success: function (data) {
                    var content = $(data).find('#your-cart').html();
                    console.log(content);
                    $("#your-cart").html(content);
                },
                error: function (xhr) {
                    // ok
                }
            });
        }
    </script>
    <% } %>
</html>