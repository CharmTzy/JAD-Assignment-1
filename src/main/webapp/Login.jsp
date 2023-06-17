<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login Page</title>
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
        .register-button-container {
		text-align: center;
		margin-top: 20px;
		}
    </style>
</head>
<body>

    <div class="login-container">
    
        <h1>Login</h1>
        <%
	String errCode = request.getParameter("errCode");
	if (errCode != null && errCode.equals("invalidLogin")) {
		out.println("<p style='color: red; text-align: center;'>You have entered an invalid ID/Password</p>");
	}
	%>
        <form method="post" action="verify.jsp">
            <input type="text" name="usernameOrEmail" pattern="[a-zA-Z0-9\s@.]+" title="Only characters and numbers are allowed" placeholder="Username or Email" required>
            <input type="password" name="password"  placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
    </div><br>
    
    	<%-- Register button --%>
	<div class="register-button-container">
		<p>
			Don't have an account? <a href="Member/customer_registration.jsp">Register</a>
		</p>
	</div>
    
<%@ include file="/footer.jsp" %>

</body>
</html>
