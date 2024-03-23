<%@ page import="model.Product" %>

<!-- Nội dung biểu mẫu -->
<h2>Add Product</h2>
<form id="addProductForm">
    <label for="productName">Product Name:</label>
    <input type="text" id="productName" name="productName"><br>

    <label for="productPrice">Product Price:</label>
    <input type="text" id="productPrice" name="productPrice"><br>

    <!-- Thêm các trường thông tin khác nếu cần -->

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
</script>
