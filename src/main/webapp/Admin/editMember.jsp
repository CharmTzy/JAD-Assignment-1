<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
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
    <title>Edit Member Form</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        form {
            margin-top: 20px;
            margin-left: 20px;
        }
        label {
            display: inline-block;
            width: 200px;
        }
        input[type="text"] {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<%
String memberId = request.getParameter("memberId");

try {
    int testId = Integer.parseInt(memberId);
} catch (Exception e) {
    response.sendRedirect("displayAdmin.jsp?errCode=nomember");
    return;
}

if (memberId == null || memberId.equalsIgnoreCase("")) {
    response.sendRedirect("displayAdmin.jsp?errCode=SelectError");
    return;
}

String name = "";
String email = "";
String address = "";
String phone = "";

boolean found = false;

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM user WHERE id = ?");
    pstmt.setString(1, memberId);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        found = true;
        name = rs.getString("username");
        email = rs.getString("email");
        address = rs.getString("address");
        phone = rs.getString("phnumber");
    }

    pstmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error: " + e);
}

if (!found) {
    response.sendRedirect("displayAdmin.jsp?errCode=nomember");
    return;
}
%>

<h1>Edit Member Form</h1>

<form method="post" action="updateMember.jsp">
    <input type="hidden" name="memberId" value="<%= memberId %>">
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required><br><br>
    <label>Email:</label>
    <input type="text" name="email" value="<%= email %>" required><br><br>
    <label>Address:</label>
    <input type="text" name="address" value="<%= address %>" required><br><br>
    <label>Phone:</label>
    <input type="text" name="phone" value="<%= phone %>" required><br><br>
    <input type="submit" value="Update Member">
</form>

</body>
</html>
