
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
    <title>Books</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }

        th {
            background-color: #4CAF50;
            color: white;
            position: sticky;
            top: 0;
            z-index: 1;
        }

        td {
            background-color: #fff;
        }
    </style>
</head>
<body>
    <h1>Books</h1>

    <table>
        <thead>
            <tr>
                <th>Image</th>
                
                <th>Title</th>
                <th>Author</th>
                <th>Price</th>
                <th>Quantity</th>
                <th>Publisher</th>
                <th>Publication Date</th>
                <th>ISBN</th>
                <th>Genre</th>
                <th>Rating</th>
                <th>Description</th>
            </tr>
        </thead>
        <tbody>
            <%
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC&useSSL=false";
                Connection conn = DriverManager.getConnection(connURL);

                // Retrieve the genreId parameter from the URL
                int genreId = Integer.parseInt(request.getParameter("genreId"));

                // Prepare a SQL statement to fetch books related to the genreId
                PreparedStatement pstmt = conn.prepareStatement("SELECT b.id, b.title, b.author, b.price, b.quantity, b.publisher, b.publication_date, b.isbn, g.genre, b.rating, b.description,b.image FROM books b JOIN genre g ON b.genre_id = g.id WHERE b.genre_id = ?");
                pstmt.setInt(1, genreId);

                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
                	String imagePath = rs.getString("image");
                    String imageUrl = "image/" + imagePath;
                    
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
                    %>
                    <tr>
                       <td><img src="<%= imageUrl %>" width="100" height="150" /></td>
                        <td><%= title %></td>
                        <td><%= author %></td>
                        <td><%= price %></td>
                        <td><%= quantity %></td>
                        <td><%= publisher %></td>
                        <td><%= publicationDate %></td>
                        <td><%= isbn %></td>
                        <td><%= genre %></td>
                        <td><%= rating %></td>
                        <td><%= description %></td>
                    </tr>
                    <%
                }

                rs.close();
                pstmt.close();
                conn.close();
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
        </tbody>
    </table>
</body>
</html>