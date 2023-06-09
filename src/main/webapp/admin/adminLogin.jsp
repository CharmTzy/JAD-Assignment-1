<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        .login-container {
            width: 300px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
        }
        
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        
        input[type="text"],
        input[type="password"] {
            width: 90%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }
        
        input[type="submit"] {
            padding: 10px 20px;
            font-size: 16px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }
        
        input[type="submit"]:hover {
            background-color: #45a049;
        }
        
        input[type="submit"]:active {
            background-color: #3e8e41;
        }
         .footer-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100px;
        }
        .footer {
            width: 10%;
            height: 50px;
            background-size: cover;
           position: center;
    
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Admin Login</h1>
        <form method="post" action="verifyAdmin.jsp">
            <input type="text" name="usernameOrEmail" placeholder="Username or Email" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
    </div><br>
    <div class="footer-container">
    <div class="footer"></div>
    </div>
    <%
    
        try {
            // Step1: Load JDBC Driver
            Class.forName("com.mysql.jdbc.Driver");

            // Step 2: Define Connection URL
            String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";

            // Step 3: Establish connection to URL
            Connection conn = DriverManager.getConnection(connURL);
            // Step 4: Create Statement object
            Statement stmt = conn.createStatement();

            // Step 5: Execute SQL Command
            String sqlStr = "SELECT image FROM images WHERE id = 1"; // Assuming the image you want to retrieve has ID 1
            ResultSet rs = stmt.executeQuery(sqlStr);

            // Step 6: Process Result
             if (rs.next()) {
                byte[] imageDataBytes = rs.getBytes("image");
                String base64Image = Base64.getEncoder().encodeToString(imageDataBytes);
                %>
                <script>
                    var imageData = '<%= base64Image %>';
                    document.querySelector('.footer').style.backgroundImage = 'url(data:image/jpeg;base64,' + imageData + ')';
                </script>
                <%
            }

            // Step 7: Close connection
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e);
        }
    %>
</body>
</html>
