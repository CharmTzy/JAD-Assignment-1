<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin DashBook</title>
</head>
<body>
    <h1>Admin Page</h1>

    <%-- Create a new book form --%>
    <h2>Create a new book:</h2>
    <form method="post" action="createBook.jsp">
        <label>Title:</label>
        <input type="text" name="title" required><br>
        <label>Author:</label>
        <input type="text" name="author" required><br>
        <input type="submit" value="Create">
    </form>

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
                <a href="editBook.jsp?id=<%= bookId %>">Edit</a>
                <a href="deleteBook.jsp?id=<%= bookId %>">Delete</a>
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
