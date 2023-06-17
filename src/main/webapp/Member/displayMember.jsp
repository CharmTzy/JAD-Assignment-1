<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <title>Customer DashBook</title>
</head>
<body>
<%

String CustomerID = (String) session.getAttribute("sessCustomerID");
String loginStatus = (String) session.getAttribute("loginStatus");

if ( CustomerID == null || !loginStatus.equals("success")){
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
    
    <h1>Customer Dashbook</h1>
    <div class="container">
     <div class="role">
     
    <a>
      <i class="fas fa-address-card"></i> 
    </a>
    <h4 class="customer-id"> <%= CustomerID %></h4>

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
  pstmt.setString(1, CustomerID);
  pstmt.setString(2, CustomerID);
  ResultSet rs = pstmt.executeQuery();

  if (rs.next()) {
    String username = rs.getString("username");
    String email = rs.getString("email");
    String role = rs.getString("role");
    String address = rs.getString("address");
    String phnumber = rs.getString("phnumber");
%>
    
    <p>Username: <%= username %></p>
    <p>Email: <%= email %></p>
    <p>Role: <%= role %></p>
    <p>Address: <%= address %></p>
    <p>Phone Number:<%= phnumber %></p>
    <a href="updateMember.jsp">Update Profile</a>
    
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
     <script>
$(document).ready(function() {
    $(".role").click(function() {
      $(".slider-container").slideToggle();
    });
  });
  </script>
     </body>
     </html>