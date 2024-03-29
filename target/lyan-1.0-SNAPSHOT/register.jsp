<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Register</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                text-align: center;
                margin: 50px;
            }

            form {
                max-width: 400px;
                margin: 0 auto;
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                text-align: left;
            }

            input {
                width: 100%;
                padding: 10px;
                margin: 8px 0;
                box-sizing: border-box;
            }

            button {
                background-color: #4caf50;
                color: white;
                padding: 10px 15px;
                margin: 8px 0;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }

            #title {
                text-align: center;
            }
        </style>
    </head>
    <body>
        <form action="./register" method="POST">
            <h2 id="title">Register</h2>

            <div style="display: flex; justify-content: space-between;">
                <div style="width: 48%;">
                    <label for="firstName">First Name:</label>
                    <input type="text" id="firstName" name="firstName" required>
                </div>
                <div style="width: 48%;">
                    <label for="lastName">Last Name:</label>
                    <input type="text" id="lastName" name="lastName" required>
                </div>
            </div>

            <label for="userName">Username:</label>
            <input type="text" id="userName" name="userName" required>

            <label for="password">Password:</label>
            <input type="password" id="password" name="password" required>

            <label for="confirmPassword">Confirm Password:</label>
            <input type="password" id="confirmPassword" name="c" required>

            <% String passwordMismatch = (String) request.getAttribute("passwordMismatch"); %>
            <% if (passwordMismatch != null) { %>
            <span style="color: red"><%= passwordMismatch  %></span><br>
            <% } %>

            <% String message = (String) request.getAttribute("message"); %>
            <% if (message != null) { %>
            <span style="color: red"><%= message  %></span><br>
            <% } %>
            <button type="submit">Confirm</button>
        </form>
    </body>
</html>
