<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin DashBook</title>
</head>
<body>
<%
String AdminID = (String) session.getAttribute("sessAdminID");
String loginStatus = (String) session.getAttribute("loginStatus");
if ( AdminID == null || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}

out.print("<h1>Welcome!.." + AdminID + "</h1><br>");
%>

<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        h1 {
            color: #333;
        }
        h2 {
            color: #666;
            margin-top: 30px;
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
            margin-left:10px;
        }
        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 20px;
            cursor: pointer;
            margin-top:20px;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
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
    <h1>Admin Page</h1>

    <%-- Create a new book form --%>
    <h2>Create a new book:</h2>
    <form method="post" action="displayAdmin.jsp">
        <label>Title:</label>
        <input type="text" name="title" required><br><br>
        <label>Author:</label>
        <input type="text" name="author" required><br><br>
        <label>Price:</label>
        <input type="text" name="price" required><br><br>
        <label>Quantity:</label>
        <input type="text" name="quantity" required><br><br>
        <label>Publisher:</label>
        <input type="text" name="publisher" required><br><br>
        <label>Publication Date:</label>
        <input type="text" name="publicationDate" required><br><br>
        <label>ISBN:</label>
        <input type="text" name="isbn" required><br><br>
        <label>Genre:</label>
        <input type="text" name="genre" required><br><br>
        <label>Rating:</label>
        <input type="text" name="rating" required><br><br>
        <div class="description-field">
        <label for="description">Description:</label>
           <textarea name="description" id="description" required></textarea>
        </div>
        <input type="submit" value="Create">
    </form>

    <% 
        // Insert new book data into the database
        if (request.getParameter("title") != null) {
            String title = request.getParameter("title");
            String author = request.getParameter("author");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String publisher = request.getParameter("publisher");
            String publicationDate = request.getParameter("publicationDate");
            String isbn = request.getParameter("isbn");
            String genre = request.getParameter("genre");
            double rating = Double.parseDouble(request.getParameter("rating"));
            String description = request.getParameter("description");

            try {
                Class.forName("com.mysql.jdbc.Driver");
                String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC&useSSL=false";
                Connection conn = DriverManager.getConnection(connURL);
                PreparedStatement pstmt = conn.prepareStatement("INSERT INTO books (title, author, price, quantity, publisher, publication_date, isbn, genre, rating, description) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
                pstmt.setString(1, title);
                pstmt.setString(2, author);
                pstmt.setDouble(3, price);
                pstmt.setInt(4, quantity);
                pstmt.setString(5, publisher);
                pstmt.setString(6, publicationDate);
                pstmt.setString(7, isbn);
                pstmt.setString(8, genre);
                pstmt.setDouble(9, rating);
                pstmt.setString(10, description);
                pstmt.executeUpdate();
                pstmt.close();
                conn.close();
            } catch (ClassNotFoundException e) {
                out.println("Error: " + e);
            } catch (SQLException e) {
                out.println("Error: " + e);
            }
        }
    %>
            
            
            
    <%-- Display existing books --%>
    <h2>Existing books:</h2>
    <table>
        <tr>
            <th>Title</th>
            <th>Author</th>
            <th>Actions</th>
        </tr>
        <%-- Retrieve books from the database --%>
        <%
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            Statement stmt = conn.createStatement();

            String sqlStr = "SELECT * FROM books";
            ResultSet rs = stmt.executeQuery(sqlStr);

            while (rs.next()) {
                String bookId = rs.getString("id");
                String title = rs.getString("title");
                String author = rs.getString("author");
        %>
        <tr>
            <td><%= title %></td>
            <td><%= author %></td>
            <td>
                <a href="updateBook.jsp?bookId=<%= bookId %>"><button>Edit</button></a>
                <a href="deleteBook.jsp?bookId=<%= bookId %>"><button>Delete</button></a>
            </td>
        </tr>
        <% }
            conn.close();
        } catch (Exception e) {
            out.println("Error: " + e);
        }
        %>
    </table>
</body>
</html>
