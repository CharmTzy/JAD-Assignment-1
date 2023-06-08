<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookstore</title>
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
        
        input[type="text"] {
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
        table {
            width: 100%;
            border-collapse: collapse;
        }
        
        th, td {
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        
        th {
            background-color: #4CAF50;
            color: white;
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
        .login-button-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }
        
        .login-button {
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
        
        .login-button:hover {
            background-color: #4B0082;
        }
        
        .login-button:active {
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
        
    </style>
</head>
<body>
    <h1>Welcome to the Bookstore</h1>
    <br>
      <div class="login-button-container">
        <button class="login-button" onclick="window.location.href='customer-login.jsp'">Customer Login</button>
        <button class="login-button" onclick="window.location.href='admin-login.jsp'">Admin Login</button>
    </div>
    
    <form method="get" action="home.jsp" onsubmit="showLoader()">
        <input type="text" name="search" placeholder="Search by title or author">
        <input type="submit" value="Search">
    </form>
    
    <div id="loaderContainer" style="display: none;">
        <div class="loader">
            <span></span>
            <span></span>
            <span></span>
            <span></span>
            <span></span>
        </div>
    </div>
    
    <table>
        <thead>
            <tr>
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
                String searchQuery = request.getParameter("search");
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    try {
                        // Step 1: Load JDBC Driver
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        // Step 2: Define Connection URL
                        String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC&useSSL=false";
                        // Step 3: Establish connection to URL
                        Connection conn = DriverManager.getConnection(connURL);
                        // Step 4: Create PreparedStatement object
                        // LIKE operator with %, allows you to search for books where the title or author contains the search query, regardless of the position within the string
                        String sqlStr = "SELECT * FROM books WHERE title LIKE ? OR author LIKE ?";
                        PreparedStatement pstmt = conn.prepareStatement(sqlStr);
                        // Step 5: Set query parameters using parameterized queries
                        pstmt.setString(1, "%" + searchQuery + "%");
                        pstmt.setString(2, "%" + searchQuery + "%");
                        // Step 6: Execute SQL Query
                        ResultSet rs = pstmt.executeQuery();

                        // Step 7: Process Result
                        boolean Results = false;
                        while (rs.next()) {
                        	
                        	Results = true;
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
            
                        // Step 8: Close connection and statement
                        rs.close();
                        pstmt.close();
                        conn.close();
                        if (!Results) {
                            %>
                            <tr>
                                <td colspan="10">Sorry, the book is not available.</td>
                            </tr>
                            <% 
                        }
                    } catch (ClassNotFoundException e) {
                        out.println("Error: " + e);
                    }
                }
            %>
        </tbody>
    </table>

    <script>
        function showLoader() {
            document.getElementById("loaderContainer").style.display = "block";
        }
    </script>
</body>
</html>
