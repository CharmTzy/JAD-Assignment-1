<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<body>


	<%
	//---------------START - initialisation of variables--------------------
	String userRole = "adminUser";

	String username = request.getParameter("usernameOrEmail");
	String password = request.getParameter("password");
	Boolean found = false; //to indicate if user exits
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

		String sqlStr = "SELECT * FROM admin WHERE (username=? OR email=?) AND password=?";

		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, username);
		pstmt.setString(2, username); // Use the same value for email
		pstmt.setString(3, password);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
			System.out.print("record found!");
			found = true;
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
		session.setAttribute("sessUserID", username);
		session.setAttribute("sessUserRole", userRole);
		session.setAttribute("loginStatus", "success");
		session.setMaxInactiveInterval(10); //to set valid time for the session , in this case 10sec

		response.sendRedirect("displayAdmin.jsp"); //no need to encode URL , we be using session 
	} else {
		response.sendRedirect("adminLogin.jsp?errCode=invalidLogin");
	}
	%>



</body>
</html>