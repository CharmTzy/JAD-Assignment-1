<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<%--
	- Author 			: Wai Yan Aung
	- Date 				: 19/06/2023
	- Description 		: JAD Assignment 1
	- Admission no		: P2234993
	- Class 			: DIT/FT/2A/02
--%>
    <%--
	- Author 			: Zayar Hpoun Myint
	- Date 				: 19/06/2023
	- Description 		: JAD Assignment 1
	- Admission no		: P2235080
	- Class 			: DIT/FT/2A/02
--%>
    <meta charset="UTF-8">
    <title>Customer Registration</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }
        
        h1 {
            text-align: center;
            margin-bottom: 20px;
        }
        
        form {
            text-align: center;
            margin-bottom: 20px;
        }
        
        input[type="text"], input[type="password"] {
            padding: 10px;
            width: 300px;
            font-size: 16px;
        }
        
        input[type="submit"] {
             padding: 10px 20px;
            font-size: 16px;
            background-color: #008080;
            color: white;
            border: none;
            cursor: pointer;
            margin: 10px;
            border-radius: 5px;
            transition: background-color 0.3s;
            animation: pulseAnimation 1s infinite;
        }
        input[type="submit"]:hover {
            background-color: #4B0082;
        }
        
        input[type="submit"]:active {
            background-color: #DAA520;
        }
        
        .loader {
            margin: 20px auto;
            width: 50px;
            height: 40px;
            text-align: center;
            font-size: 10px;
        }
        
        .loader span {
            width: 5px;
            height: 100%;
            display: inline-block;
            background-color: #4CAF50;
            animation: loaderAnimation 1s infinite ease-in-out;
        }
        
        @keyframes loaderAnimation {
            0% { transform: scaleY(0.4); }
            20% { transform: scaleY(1); }
            40% { transform: scaleY(0.4); }
            100% { transform: scaleY(0.4); }
        }
        
        @keyframes pulseAnimation {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
    </style>
</head>
<body>
    <h1>Customer Registration</h1>
    
    <form method="post" action="registerUser.jsp">
        <input type="text" name="username" placeholder="Username" required>
        <br>
        <input type="text" name="email" placeholder="Email" required>
        <br>
        <input type="password" name="password" placeholder="Password" required>
        <br>
        <input type="text" name="address" placeholder="Address" required>
        <br>
        <input type="text" name="phnumber" placeholder="Phone Number" required>
        <br>
        <input type="submit" value="Register">
    </form>
    
    <script>
        function showLoader() {
            document.getElementById("loaderContainer").style.display = "block";
        }
    </script>
</body>
</html>
