<%@ page import="model.Order" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.OrderDAO" %><%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 01/04/2024
  Time: 10:51 CH
  To change this template use File | Settings | File Templates.
--%>



<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>Order Table</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="file_js/adminPage.css">
    <script>
        $(document).ready(function(){
            $('[data-toggle="tooltip"]').tooltip();
        });
    </script>
</head>
<body>
<div class="container-xl">
    <div class="table-responsive">
        <div class="table-wrapper">
            <div class="table-title">
                <div class="row">
                    <div class="col-sm-4">
                        <h2>Order <b>Details</b></h2>
                    </div>
                    <div class="col-sm-8">
                        <a href="#" class="btn btn-primary"><i class="material-icons">&#xE863;</i> <span>Refresh List</span></a>
                        <a href="#" class="btn btn-secondary"><i class="material-icons">&#xE24D;</i> <span>Export to Excel</span></a>
                    </div>
                </div>
            </div>
            <div class="table-filter">
                <div class="row">
                    <div class="col-sm-3">
                        <div class="show-entries">
                            <span>Show</span>
                            <select class="form-control" id="show-change" onchange="showChange()">
                                <option>5</option>
                                <option>10</option>
                                <option>15</option>
                                <option>20</option>
                                <option selected>25</option>
                            </select>
                            <span>entries</span>
                        </div>
                    </div>
                    <div class="col-sm-9">
                        <button type="button" class="btn btn-primary" onclick="nameSearch()"><i class="fa fa-search"></i></button>
                        <div class="filter-group">
                            <label>Name</label>
                            <input type="text" class="form-control"  id="searchName" placeholder="Search by Name">
                        </div>
                        <div class="filter-group">
                            <label>Location</label>
                            <select class="form-control">
                                <option>All</option>
                                <option>Berlin</option>
                                <option>London</option>
                                <option>Madrid</option>
                                <option>New York</option>
                                <option>Paris</option>
                            </select>
                        </div>
                        <div class="filter-group">
                            <label>Status</label>
                            <select class="form-control" id="status" onchange="statusChange()">
                                <option>Any</option>
                                <option>Pending</option>
                                <option>Processing</option>
                                <option>Shipped</option>
                                <option>Deliverd</option>
                                <option>Cancelled</option>
                            </select>
                        </div>
                        <span class="filter-icon"><i class="fa fa-filter"></i></span>
                    </div>
                </div>
            </div>
            <table class="table table-striped table-hover" id="orderTable">
                <thead>
                <tr>
                    <th></th>
                    <th>Customer</th>
                    <th>Location</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Net Amount</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>
                <%  int current_page = (request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1 );
                    int pageSize = 25;
                    int totalOrder = OrderDAO.getTotalOrder();
                    ArrayList<Order> ordersList = OrderDAO.getOrderPerPage(current_page,pageSize);%>
                <%
                    assert ordersList != null;
                    for(Order order : ordersList) {%>
                <tr>
                    <td><%=order.getId()%></td>
                    <td><a href="#"><%=order.getFirstName() + " " + order.getLastName() %></a></td>
                    <td><%=order.getAddress()%></td>
                    <td><%=order.getOrderDate()%></td>
                    <td><span class="status text-success">&bull;</span><%=order.getStatus()%></td>
                    <td><%=order.getTotalMoney()%></td>
                    <td><a href="#" class="view" title="View Details" data-toggle="tooltip"><i class="material-icons">&#xE5C8;</i></a></td>
                </tr>
                <%}%>
                </tbody>
            </table>
            <div class="clearfix">

                <div class="hint-text">Showing <b id = 'valueSelected'>25</b> out of <b>25</b> entries</div>
                <ul class="pagination">
                    <li class="page-item disabled"><a href="#">Previous</a></li>
                    <%int totalPage = (int)Math.ceil((double) totalOrder / pageSize);
                    for(int pageNum = 1;pageNum <= totalPage;pageNum++) {%>
                    <li class="page-item active"><a href="#" class="page-link"><%=pageNum%></a></li>
                    <%}%>
                    <li class="page-item"><a href="#" class="page-link">Next</a></li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>

<script>
    var valueSelected = 25;
    function showChange() {
        var selectedValue = document.getElementById("show-change").value;
        if(selectedValue == 'All') {
            valueSelected = 25;
            $('table tr').slice(1).show();
        }
        else {
            valueSelected = selectedValue;
            $('.table tr').slice(1).hide();
            $('.table tr').slice(1, parseInt(selectedValue) + 1).show();
        }
        document.getElementById('valueSelected').innerHTML = valueSelected;
    }
    function statusChange() {
        var statusSelected = document.getElementById("status").value;
        if(statusSelected == 'Any'){
            $('.table tr').slice(1).show();
        }
        else {
            $('.table tr').slice(1).hide();
            $('.table tr').each(function() {
               if($(this).find('td:nth-child(5)').text().includes(statusSelected.toLowerCase())){
                   $(this).show();
               }
            });
        }
    }

    function nameSearch() {
        var input, filter, table, tr, td, i, txtValue;
        input = document.getElementById("searchName");
        filter = input.value.toUpperCase();
        table = document.getElementById("orderTable");
        tr = table.getElementsByTagName("tr");

        for(i = 0; i < tr.length; i++) {
            td = tr[i].getElementsByTagName("td")[1];
            if (td) {
                txtValue = td.textContent || td.innerText;
                if(txtValue.toUpperCase().indexOf(filter) > -1) {
                    tr[i].style.display ="";
                } else {
                    tr[i].style.display = "none";
                }
            }
        }
    }
</script>

</html>




