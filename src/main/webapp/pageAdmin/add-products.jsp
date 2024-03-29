<%@ page import="model.Category" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="dao.CategoryDAO" %>


<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    label {
        display: inline-block;
        width: 150px;
        text-align: right;
        margin-right: 10px;
    }
    input {
        width: 250px;
    }
</style>


<h2>Add Product</h2>
<form action="./addproduct" method = "POST" enctype="multipart/form-data">
    <label for="productName">Product Name:</label>
    <input type="text" id="productName" name="productName" required><br>

    <label for="productPrice">Product Price:</label>
    <input type="number" id="productPrice" name="productPrice" required><br>

    <label for="supplier">Supplier:</label>
    <input type="text" id="supplier" name="supplier" required><br>

    <label for="productDescription">Description:</label>
    <input type="text" id="productDescription" name="productDescription" required><br>

    <label for="imageProduct">Image: </label>
    <input type="file" id="imageProduct" name="fileUpload" accept="image/*" required><br>

    <%ArrayList<Category> categories = CategoryDAO.getCategory();%>
    <label for="categoryProduct">Category_id: </label>
    <select id="categoryProduct" name="categoryProduct" onchange="checkOther()">
        <%for (Category category : categories) {%>
            <option value="<%=category.getTitle()%>"><%=category.getId()%>. <%=category.getTitle()%></option>
        <%}%>
        <option value="Khác">Khác</option>
    </select>
    <div id="other" style="display: none;">
        <label for="otherCategory">New Category:</label>
        <input type="text" id="otherCategory" name="otherCategory">
    </div>
    <br>
    <input type="submit" value="Add Product">
</form>

<!-- JavaScript để xử lý yêu cầu AJAX -->
<script>
    $(document).ready(function() {
        // Gửi yêu cầu AJAX khi biểu mẫu được gửi đi
        $("#addProductForm").submit(function(event) {
            // Ngăn chặn hành động mặc định của biểu mẫu
            event.preventDefault();

            // Thu thập dữ liệu từ biểu mẫu
            var formData = $(this).serialize();

            // Gửi yêu cầu AJAX
            $.ajax({
                type: "POST", // Phương thức HTTP sử dụng (POST)
                url: "add-product-handler.jsp", // Đường dẫn đến trang xử lý yêu cầu
                data: formData, // Dữ liệu gửi đi (dữ liệu biểu mẫu đã được serialized)
                success: function(response) {
                    // Xử lý kết quả trả về từ trang xử lý
                    alert(response); // Hiển thị thông báo hoặc thực hiện các hành động khác
                }
            });
        });
    });
    function checkOther(){
        var selectBox = document.getElementById("categoryProduct");
        var otherInput = document.getElementById("other");

        if(selectBox.value === "Khác") {
            otherInput.style.display = "block";
        }
        else otherInput.style.display = "none";
    }

</script>
