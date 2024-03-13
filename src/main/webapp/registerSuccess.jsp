<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register succesfully</title>
    <script>
        // Hàm tự động chuyển hướng sau 3 giây
        function redirectLogin() {
            setTimeout(function() {
                window.location.href = "./login";
            }, 3000); // 3000 milliseconds = 3 seconds
        }

        // Gọi hàm tự động chuyển hướng khi trang đã tải xong
        window.onload = redirectLogin();
    </script>
</head>
<body>
<div>
    <h1>Register successfully</h1>
    <p>Register successfully! Redirecting to login page in 3 seconds.</p>
</div>
</body>
</html>
