<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.regex.*" %>

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
    <title>Update Member</title>
</head>
<body>
<%
String memberId = request.getParameter("memberId");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");

// Validating input
boolean isValid = true;
String errorMsg = "";

if (name == null || name.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Name is required.";
} else if (email == null || email.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Email is required.";
} else if (address == null || address.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Address is required.";
} else if (phone == null || phone.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Phone is required.";
}

if (!isValid) {
    response.sendRedirect("editMember.jsp?memberId=" + memberId + "&errorMsg=" + errorMsg);
    return;
}

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);
    PreparedStatement pstmt = conn.prepareStatement("UPDATE user SET username = ?, email = ?, address = ?, phnumber = ? WHERE id = ?");
    pstmt.setString(1, name);
    pstmt.setString(2, email);
    pstmt.setString(3, address);
    pstmt.setString(4, phone);
    pstmt.setString(5, memberId);
    int count = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("displayAdmin.jsp?successMsg=Member updated successfully.");
} catch (Exception e) {
    out.println("Error: " + e);
}
%>
</body>
</html>
