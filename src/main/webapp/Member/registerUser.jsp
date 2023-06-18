<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
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
    <meta charset="ISO-8859-1">
    <title>Register User</title>
</head>
<body>
    <%@page import="java.sql.*"%>
    <%
    /* 
    ****************************
    Author: Zayar Hpoun Myint
    Date: 18/05/2023
    Description: Pract5-Part1
    ****************************
    */

    // Retrieve user input from the registration form
    String username = request.getParameter("username");
    String email = request.getParameter("email");
    String password = request.getParameter("password");
    String role = "customer";
    String address = request.getParameter("address");
    String phnumber = request.getParameter("phnumber");

    // Database connection variables
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // Step 1: Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Step 2: Define Connection URL
        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";

        // Step 3: Establish connection to URL
        conn = DriverManager.getConnection(connURL);

        // Step 4: Create PreparedStatement object
        String sqlStr = "INSERT INTO user (username, email, role, password, address, phnumber) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sqlStr);
        pstmt.setString(1, username);
        pstmt.setString(2, email);
        pstmt.setString(3, role);
        pstmt.setString(4, password);
        pstmt.setString(5, address);
        pstmt.setString(6, phnumber);

        // Step 5: Execute SQL Query
        int rowsAffected = pstmt.executeUpdate();

        if (rowsAffected > 0) {
            // Registration successful
            response.sendRedirect("../Login.jsp?registrationSuccess=true");
        } else {
            // Registration failed
            response.sendRedirect("customer_registration.jsp?registrationError=true");
        }

    } catch (Exception e) {
        out.println("Error: " + e);
    } finally {
        // Step 6: Close connection and statement
        try {
            if (pstmt != null) {
                pstmt.close();
            }
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            out.println("Error: " + e);
        }
    }
    %>
</body>
</html>
