<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page import="java.sql.*, java.util.Base64" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Footer</title>
</head>
<body>
		<style>
		.footer-container {
			display: flex;
			justify-content: center;
			align-items: center;
			height: 100px;
		}
		
		.footer {
			width: 10%;
			height: 50px;
			background-size: cover;
			position: center;
		}
		</style>
			<div class="footer-container">
				<div class="footer"></div>
			</div>
	<%
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
		String sqlStr = "SELECT image FROM images WHERE id = 1"; // Assuming the image you want to retrieve has ID 1
		ResultSet rs = stmt.executeQuery(sqlStr);

		// Step 6: Process Result
		if (rs.next()) {
			byte[] imageDataBytes = rs.getBytes("image");
			String base64Image = Base64.getEncoder().encodeToString(imageDataBytes);
	%>
	<script>
        var imageData = '<%=base64Image%>';
		document.querySelector('.footer').style.backgroundImage = 'url(data:image/jpeg;base64,'+ imageData + ')';
	</script>
	<%
	}

	// Step 7: Close connection
	conn.close();
	} catch (Exception e) {
	out.println("Error: " + e);
	}
	%>
</body>
</html>