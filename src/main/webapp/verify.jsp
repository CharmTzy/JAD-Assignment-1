<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
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
</head>
<meta charset="ISO-8859-1">
<body>


	<%
	//---------------START - initialisation of variables--------------------
	
	String username = request.getParameter("usernameOrEmail");
	String password = request.getParameter("password");
	Boolean found = false; //to indicate if user exits
	String role = ""; // to store the user's role
	//---------------ENd   - initialization of variables-------------------

	int id;
	String name;
	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/book_db?user=JAD&password=root@123mml&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);
		// Step 4: Create Statement object
		Statement stmt = conn.createStatement();
		// Step 5: Execute SQL Command

		String sqlStr = "SELECT * FROM user WHERE (username=? OR email=?) AND BINARY password=?";

		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, username);
		pstmt.setString(2, username); // Use the same value for email
		pstmt.setString(3, password);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
			System.out.print("record found!");
			found = true;
			 role = rs.getString("role");
		} else {
			//do nothing
			System.out.print("record not found!");
		}

		// Step 7: Close connection
		conn.close();
	} catch (Exception e) {
		out.println("Error :" + e);
	}

	if (found) {
		//--------------Store values to the Session Object------------
		session.setAttribute("sessAdminID", username);
		session.setAttribute("sessCustomerID", username);
		session.setAttribute("loginStatus", "success");
		session.setMaxInactiveInterval(60); //to set valid time for the session , in this case 60sec

		if (role.equalsIgnoreCase("admin")) {
            response.sendRedirect("Admin/displayAdmin.jsp");
        } else if (role.equalsIgnoreCase("member")) {
            response.sendRedirect("Member/displayMember.jsp");
        } 
	} else {
		response.sendRedirect("Login.jsp?errCode=invalidLogin");
	}
	%>



</body>
</html>