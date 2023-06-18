<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="java.util.*"%>
	<%@ page import="java.sql.*" %>
<%@ page import="books.*"%>
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
<title>Add to Cart</title>
</head>
<body>
	<%
    String bookId = request.getParameter("bookId");

    try {
        // Step 1: Load JDBC Driver
        Class.forName("com.mysql.cj.jdbc.Driver");

        // Step 2: Define Connection URL
        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC&useSSL=false";

        // Step 3: Establish connection to URL
        Connection conn = DriverManager.getConnection(connURL);

        // Step 4: Create Statement object
        Statement stmt = conn.createStatement();

        // Step 5: Execute SQL Query to retrieve book details by ID
        String sqlStr = "SELECT * FROM books WHERE id = " + bookId;
        ResultSet rs = stmt.executeQuery(sqlStr);

        if (rs.next()) {
            // Retrieve book details from the result set
            String title = rs.getString("title");
            String author = rs.getString("author");
            double price = rs.getDouble("price");
            int quantity = rs.getInt("quantity");
            String publisher = rs.getString("publisher");
            String publicationDate = rs.getString("publication_date");
            String isbn = rs.getString("isbn");
            String genre = rs.getString("genre");
            double rating = rs.getDouble("rating");
            String description = rs.getString("description");

            // You can now add the book details to the cart or perform any other necessary actions

            // For example, you can print the book details:
            out.println("Title: " + title);
            out.println("Author: " + author);
            out.println("Price: " + price);
            // ... and so on
        }

        // Close the database resources
        rs.close();
        stmt.close();
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

</body>
</html>