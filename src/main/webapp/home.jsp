<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.Base64" %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bookstore</title>
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
	        position: sticky; /* Add this line to make the header sticky */
	        top: 0; /* Add this line to position the sticky header at the top */
	        z-index: 1; /* Add this line to ensure the header appears above the table content */
	    }
	
	    td {
	        background-color: #fff;
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
        
        .login-button,.register-button {
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
        .register-button:hover {
            background-color: #4B0082;
        }
        
        .register-button:active {
            background-color: #DAA520;
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
        .footer {
	        margin-left:700px;
		    text-align: center;
		    width: 100%;
		    position: relative;
		    margin-top: 20px;
		}
	    
    </style>
</head>
<body>

    <h1>Welcome to the Bookstore</h1>
    <br>
    <div class="login-button-container">
   
        <button class="register-button" onclick="window.location.href='Member/customer_registration.jsp'">Member Register</button>
        <button class="login-button" onclick="window.location.href='Login.jsp'"> Login</button>
         <button class ="register-button" onclick ="window.location.href='genre.jsp'">Search By Genre</button>
    </div>
    
    <form method="get" action="home.jsp" onsubmit="showLoader()">
        <input type="text" name="search" placeholder="Search by title or author">
        <input type="submit" value="Search">
    </form>
    
   
    
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
        <tr id="loaderContainer" style="display: none;">
        <td colspan="10">
            <div class="loader">
                <span></span>
                <span></span>
                <span></span>
                <span></span>
                <span></span>
            </div>
        </td>
    </tr>
            <% 
            String searchQuery = request.getParameter("search");
            boolean hasResults = false;
            
            try {
                // Step 1: Load JDBC Driver
                Class.forName("com.mysql.jdbc.Driver");
                
                // Step 2: Define Connection URL
               String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
                
                // Step 3: Establish connection to URL
                Connection conn = DriverManager.getConnection(connURL);
                
                // Step 4: Create Statement object
                Statement stmt = conn.createStatement();
                
                // Step 5: Execute SQL Query
                String sqlStr = "SELECT books.*, genre.genre FROM books INNER JOIN genre ON books.genre_id = genre.id";

                
               
                // If search query is provided, modify the SQL query to filter results
                if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                    sqlStr += " WHERE title LIKE '%" + searchQuery + "%' OR author LIKE '%" + searchQuery + "%'";
                }
                
                ResultSet rs = stmt.executeQuery(sqlStr);
                
                // Step 6: Process Result
                while (rs.next()) {
                    hasResults = true;
                    
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
                
                // Step 7: Close connection
                rs.close();
                stmt.close();
                conn.close();
                
            } catch (ClassNotFoundException e) {
                e.printStackTrace();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            
            if (!hasResults) {
            	
                %>
                <tr>
                    <td colspan="11">No books found.</td>
                </tr>
                <%
            }
            %>
            
 
        </tbody>
    </table>
   
    
     <div class="footer">
     
        <%@ include file="/footer.jsp" %>
        
    </div>
    <script>
        function showLoader() {
            document.getElementById('loaderContainer').style.display = 'table-row';
        }
        
    </script>
</body>
</html>
