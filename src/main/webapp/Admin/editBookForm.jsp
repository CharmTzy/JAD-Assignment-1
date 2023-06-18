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
    <title>Edit Book Form</title>
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
        input[type="text"],
        textarea {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            margin-left: 10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-top: 20px;
        }
        p {
            color: #999;
        }
        .description-field {
            display: flex;
            align-items: center;
        }
        .description-field textarea {
            margin-left: 15px;
        }
    </style>
</head>
<body>
<%
String bookId = request.getParameter("bookId");

try {
    int testId = Integer.parseInt(bookId);
} catch (Exception e) {
    response.sendRedirect("displayAdmin.jsp?errCode=nobook");
    return;
}

if (bookId == null || bookId.equalsIgnoreCase("")) {
    response.sendRedirect("displayAdmin.jsp?errCode=SelectError");
    return;
}

String title = "";
String author = "";
double price = 0.0;
int quantity = 0;
String publisher = "";
String publicationDate = "";
String isbn = "";
int genreId = 0;
double rating = 0.0;
String description = "";
String genre = ""; // New variable to hold genre information

boolean found = false;

try {
    Class.forName("com.mysql.jdbc.Driver");
    String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
    Connection conn = DriverManager.getConnection(connURL);
    PreparedStatement pstmt = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
    pstmt.setString(1, bookId);
    ResultSet rs = pstmt.executeQuery();

    if (rs.next()) {
        found = true;
        title = rs.getString("title");
        author = rs.getString("author");
        price = rs.getDouble("price");
        quantity = rs.getInt("quantity");
        publisher = rs.getString("publisher");
        publicationDate = rs.getString("publication_date");
        isbn = rs.getString("isbn");
        genreId = rs.getInt("genre_id");
        rating = rs.getDouble("rating");
        description = rs.getString("description");

        // Retrieve the genre information from the 'genre' table
        PreparedStatement genreStmt = conn.prepareStatement("SELECT genre FROM genre WHERE id = ?");
        genreStmt.setInt(1, genreId);
        ResultSet genreRs = genreStmt.executeQuery();
        if (genreRs.next()) {
            genre = genreRs.getString("genre");
        }
        genreStmt.close();
    }

    pstmt.close();
    conn.close();
} catch (Exception e) {
    out.println("Error: " + e);
}

if (!found) {
    response.sendRedirect("displayAdmin.jsp?errCode=nobook");
    return;
}
%>

<h1>Edit Book Form</h1>

<form method="post" action="updateBook.jsp">
    <input type="hidden" name="bookId" value="<%= bookId %>">
    <label>Title:</label>
    <input type="text" name="title" value="<%= title %>" required><br><br>
    <label>Author:</label>
    <input type="text" name="author" value="<%= author %>" required><br><br>
    <label>Price:</label>
    <input type="text" name="price" value="<%= price %>" required><br><br>
    <label>Quantity:</label>
    <input type="text" name="quantity" value="<%= quantity %>" required><br><br>
    <label>Publisher:</label>
    <input type="text" name="publisher" value="<%= publisher %>" required><br><br>
    <label>Publication Date:</label>
    <input type="text" name="publicationDate" value="<%= publicationDate %>" required><br><br>
    <label>ISBN:</label>
    <input type="text" name="isbn" value="<%= isbn %>" required><br><br>
    <label>Genre:</label>
    <input type="text" name="genre" value="<%= genre %>" required><br><br>
    <label>Rating:</label>
    <input type="text" name="rating" value="<%= rating %>" required><br><br>
    <div class="description-field">
        <label for="description">Description:</label>
        <textarea name="description" id="description" required><%= description %></textarea>
    </div>
    <input type="submit" value="Update Book">
</form>
</body>
</html>