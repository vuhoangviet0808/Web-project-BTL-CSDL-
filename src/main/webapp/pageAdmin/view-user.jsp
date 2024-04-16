<%@ page import="model.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.UserDao" %>
<%@ page import="java.util.Objects" %><%--
  Created by IntelliJ IDEA.
  User: ADMIN
  Date: 08/04/2024
  Time: 12:15 SA
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>View users</title>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto|Varela+Round">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
    <link href="file_js/adminPage.css" rel="stylesheet">
</head>
<body>
<div class="container">
    <div class="row">
        <div class="col-md-12">
            <div class="table-wrapper">
                <div class="table-title">
                    <div class="row">
                        <div class="col-sm-8"><h2>Manage <b>Users</b></h2></div>
                    </div>
                </div>
                <div class="table-filter">
                    <div class="row">
                        <div class="col-sm-12">
                            <!-- Các bộ lọc ở đây -->
                        </div>
                    </div>
                </div>
                <div class="table-responsive">
                    <table class="table table-striped table-hover">
                        <thead>
                        <tr>
                            <th scope="col" class="border-0 text-uppercase font-medium">#</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Name</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Username</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Gender</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Birthday</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Number</th>
                            <th scope="col" class="border-0 text-uppercase font-medium">Manage</th>
                        </tr>
                        </thead>
                        <%ArrayList<User> userList = UserDao.getAllUser();
                        %>
                        <tbody>
                        <%
                            assert userList != null;
                            for(User user : userList) {%>
                        <tr id="userRow_<%=user.getId()%>">
                            <td ><%=user.getId()%></td>
                            <td>
                                <h6 class="font-medium mb-0"><%=user.getFirst_name() + " " + user.getLast_name()%>></h6>
                            </td>
                            <td>
                                <%=user.getUsername()%>
                            </td>
                            <td>
                                <%=user.getGender()%>
                            </td>
                            <td>
                                <%=user.getBirthday()%>
                            </td>
                            <td>
                                <%=user.getNumber()%>
                            </td>
                            <td style="display: flex;justify-content: center;gap: 10px;">
                                <button id="userState<%=user.getId()%>" title="Lock" type="button" class="<%=((Objects.equals(user.getStatus(), "lock")) ? "active":"")%> btn btn-outline-info btn-circle btn-sm btn-lock" onclick="changeUserStatus(<%=user.getId()%>)"><i class="fa fa-key"></i></button>
                                <button title="Delete" type="button" class="btn btn-outline-info btn-circle btn-sm ml-1" onclick="deleteUser(<%=user.getId()%>)"><i class="fa fa-trash"></i></button>
                            </td>
                        </tr>
                        <%}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>

<script>
    function deleteUser(userId){
        if(confirm("Xác nhận xóa tài khoản ?")) {
            $.ajax ({
                type: "POST",
                url: "./ProcessAdminDeleteUser",
                data: { userId: userId},
                success: function(response) {
                    alert(response);
                    if(response.trim() === "success"){
                        $("#userRow_" + userId).hide();
                    }
                }
            });
        }
    }

    function changeUserStatus(userId) {
        $.ajax({
            type: "POST",
            url: "./ProcessAdminStatusUser",
            data: {
                userId: userId,
                action: $("#userState" + userId).hasClass('active') ? 'unlock' : 'lock'
            },
            success: function(response) {
                alert(response);
                if (response.trim() === "success") {
                    const button = $("#userState" + userId);
                    if (button.hasClass('active')) {
                        button.removeClass('active');
                    } else {
                        button.addClass('active');
                    }
                }
            }
        });
    }



</script>