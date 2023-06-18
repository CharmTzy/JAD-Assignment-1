<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.regex.*" %>

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
    <title>Update Book</title>
</head>
<body>
<%
String bookId = request.getParameter("bookId");
String title = request.getParameter("title");
String author = request.getParameter("author");
String priceStr = request.getParameter("price");
String quantityStr = request.getParameter("quantity");
String publisher = request.getParameter("publisher");
String publicationDate = request.getParameter("publicationDate");
String isbn = request.getParameter("isbn");
String genre = request.getParameter("genre");
String ratingStr = request.getParameter("rating");
String description = request.getParameter("description");

// Validating input
boolean isValid = true;
String errorMsg = "";

if (title == null || title.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Title is required.";
} else if (author == null || author.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Author is required.";
} else if (priceStr == null || priceStr.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Price is required.";
} else if (quantityStr == null || quantityStr.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Quantity is required.";
} else if (publisher == null || publisher.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Publisher is required.";
} else if (publicationDate == null || publicationDate.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Publication Date is required.";
} else if (isbn == null || isbn.trim().isEmpty()) {
    isValid = false;
    errorMsg = "ISBN is required.";
} else if (genre == null || genre.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Genre is required.";
} else if (ratingStr == null || ratingStr.trim().isEmpty()) {
    isValid = false;
    errorMsg = "Rating is required.";
}

if (!isValid) {
    response.sendRedirect("editBookForm.jsp?bookId=" + bookId + "&errorMsg=" + errorMsg);
    return;
}

double price = Double.parseDouble(priceStr);
int quantity = Integer.parseInt(quantityStr);
double rating = Double.parseDouble(ratingStr);

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);

    // Fetch genre_id from genre table based on genre name
    String genreIdQuery = "SELECT id FROM genre WHERE genre = ?";
    PreparedStatement genreIdStmt = conn.prepareStatement(genreIdQuery);
    genreIdStmt.setString(1, genre);
    ResultSet genreIdResult = genreIdStmt.executeQuery();
    String fetchedGenreId = "";
    if (genreIdResult.next()) {
        fetchedGenreId = genreIdResult.getString("id");
    }
    genreIdResult.close();
    genreIdStmt.close();

    // Update books table with the fetched genre_id
    PreparedStatement pstmt = conn.prepareStatement("UPDATE books SET title = ?, author = ?, price = ?, quantity = ?, publisher = ?, publication_date = ?, isbn = ?, genre_id = ?, rating = ?, description = ? WHERE id = ?");
    pstmt.setString(1, title);
    pstmt.setString(2, author);
    pstmt.setDouble(3, price);
    pstmt.setInt(4, quantity);
    pstmt.setString(5, publisher);
    pstmt.setString(6, publicationDate);
    pstmt.setString(7, isbn);
    pstmt.setString(8, fetchedGenreId);
    pstmt.setDouble(9, rating);
    pstmt.setString(10, description);
    pstmt.setString(11, bookId);
    int count = pstmt.executeUpdate();

    pstmt.close();
    conn.close();

    response.sendRedirect("displayAdmin.jsp?successMsg=Book updated successfully.");
} catch (Exception e) {
    out.println("Error: " + e);
}
%>
</body>
</html>