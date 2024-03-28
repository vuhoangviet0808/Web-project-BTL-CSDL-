<%--
  Created by IntelliJ IDEA.
  User: LynG
  Date: 3/25/2024
  Time: 9:25 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
    <head>
        <title>Title</title>
    </head>
    <body>
        <form action="UploadServlet" method="post" enctype="multipart/form-data">
            Chọn tập tin để tải lên: <input type="file" name="fileUpload" /><br/><br/>
            <input type="submit" value="Tải lên" />
        </form>

    </body>
</html>
