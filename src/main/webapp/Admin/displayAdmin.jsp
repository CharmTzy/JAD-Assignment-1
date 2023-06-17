<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"> 
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Admin DashBoard</title>
</head>
<body>
<%

String AdminID = (String) session.getAttribute("sessAdminID");
String loginStatus = (String) session.getAttribute("loginStatus");
if ( AdminID == null || !loginStatus.equals("success")){
	response.sendRedirect("../Login.jsp?errCode=invalidLogin");
}

%>

<style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }
        .container {
		  display: flex;
		  align-items: center;
		}
        
        h1 {
            color: #333;
             display: inline-block;
        }
        h2 {
            color: #666;
            margin-top: 50px;
        }
        form {
            margin-top: 20px;
            margin-left: 20px;
        }
        label {
            display: inline-block;
            width: 200px;
        }
         input[type="file"],
        textarea {
            width: 300px;
            padding: 5px;
            margin-bottom: 10px;
            margin-left:10px;
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
        .quantity-buttons {
		  display: flex;
		  align-items: center;
		}
		 .button-group {
		  display: flex;
		  flex-direction: column;
		}
		.quantity-buttons form {
		  margin-right: 10px;
		}
		
		.quantity-value {
		  margin: 0 10px;
		}
		
		.quantity-button.plus {
		  margin-bottom: 10px;
		}
		
		.quantity-button.minus {
		  margin-bottom: 10px;
		  
		}
		.value-field{
		margin-top:10px;
		width: 40px;
		}
		.container {
	    display: flex;
	    flex-direction: column;
	    align-items: center;
	    float: right;
	    flex-wrap: wrap;
	    margin-top: 20px;
	    margin-right: 80px;
	   
	  }
	  
	  .role {
	    display: flex;
	    align-items: center;
	   
	  }
	
	  .role a {
	    display: flex;
	    justify-content: center;
	    width: 50px;
	    border-radius: 5px;
	  }
	
	  .slider-container {
	    display: none;
	    padding: 20px;
	    background-color: #f2f2f2;
	    margin-top: 50px;
	    position: absolute;
	  }
    </style>
    
    <h1>Admin Dashboard</h1>
    <div class="container">
     <div class="role">
     
    <a>
      <i class="fas fa-address-card"></i> 
    </a>
    <h4 class="admin-id"> <%= AdminID %></h4>

  </div>
    

  <div class="slider-container">
 
  <%  
try {
  Class.forName("com.mysql.jdbc.Driver");
  String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
  Connection conn = DriverManager.getConnection(connURL);
  Statement stmt = conn.createStatement();

  String sqlStr = "SELECT * FROM user WHERE username = ? OR email = ?";
  PreparedStatement pstmt = conn.prepareStatement(sqlStr);
  pstmt.setString(1, AdminID);
  pstmt.setString(2, AdminID);
  ResultSet rs = pstmt.executeQuery();

  if (rs.next()) {
    String username = rs.getString("username");
    String email = rs.getString("email");
    String role = rs.getString("role");
%>
    
    <p>Username: <%= username %></p>
    <p>Email: <%= email %></p>
    <p>Role: <%= role %></p>
<% 
  } else {
%>
    <p>No user found.</p>
<%
  }
  rs.close();
  pstmt.close();
  conn.close();
} catch (Exception e) {
  e.printStackTrace();
}
%>


</div>
     </div>

    <%-- Create a new book form --%>
    <h2>Create a new book:</h2>
    <form method="post" action="displayAdmin.jsp" >
	    
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




	<%-- Insert new book data into the database --%>
<%
    
    if (request.getParameter("title") != null) {
        // Retrieve form field values
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
        <th>Inventory</th>
        <th>Actions</th>
        
    </tr>
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
            int inventory = rs.getInt("quantity");
    %>
    <tr>
        <td><%= title %></td>
        <td><%= author %></td>
        <td>
            <div class="quantity-buttons">
            
                <form method="post" action="displayAdmin.jsp">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="hidden" name="currentInventory" value="<%= inventory %>">
                    <button class="quantity-button plus" type="submit" name="addQuantity">+</button>
                </form>
                <div class="value-field">
                <span class="quantity-value"><%= inventory %></span>
              </div>
                <div class="button-group">
                <form method="post" action="displayAdmin.jsp">
                    <input type="hidden" name="bookId" value="<%= bookId %>">
                    <input type="hidden" name="currentInventory" value="<%= inventory %>">
                    <button class="quantity-button minus" type="submit" name="reduceQuantity">-</button>
                </form>
                  </div>
            </div>
        </td>
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

    // Update book quantity
    if (request.getParameter("addQuantity") != null || request.getParameter("reduceQuantity") != null) {
        String bookId = request.getParameter("bookId");
        int currentInventory = Integer.parseInt(request.getParameter("currentInventory"));

        int newInventory = currentInventory;
        if (request.getParameter("addQuantity") != null) {
            newInventory++;
        } else if (request.getParameter("reduceQuantity") != null) {
            newInventory--;
            if (newInventory < 0) {
                newInventory = 0;
            }
        }

        try {
            Class.forName("com.mysql.jdbc.Driver");
            String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";
            Connection conn = DriverManager.getConnection(connURL);
            PreparedStatement pstmt = conn.prepareStatement("UPDATE books SET quantity = ? WHERE id = ?");
            pstmt.setInt(1, newInventory);
            pstmt.setString(2, bookId);
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
</table>
<script>
$(document).ready(function() {
    $(".role").click(function() {
      $(".slider-container").slideToggle();
    });
  });
  </script>

</body>
</html>