<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
<body>

<%
	String url = "jdbc:postgresql://localhost:5432/javadb";
	String username = "postgres";
	String password = "123456";
	Connection conn = null;
	ResultSet rs=null;
	try {
		Class.forName("org.postgresql.Driver");
		conn = DriverManager.getConnection (url, username, password );
		Statement stmt = conn.createStatement();
		rs = stmt.executeQuery("SELECT * FROM public.users;");
	}catch(SQLException e){
		out.println("Възникна грешка при изпълнението на заявката " + e.getMessage());
		e.printStackTrace();
	}finally {
		if(conn != null){
			conn.close();
		}
	}
		out.println("<form action=\"pictureHandler.jsp\" method=\"get\">"+"<select name=\"users\">");
		StringBuilder sb= new StringBuilder();
		while(rs.next()){
			String usernameDB = rs.getString("username");
			int ID=rs.getInt("id");
			sb.append("<option value=\""+ID+"\">" + " " +  usernameDB + "<br />");
		}out.print(sb.toString());
		out.println("<option value=\"all\">*</option>"+"<input type=\"submit\" value=\"submit\">"+"</select>"+"</form>");
%>
</body>
</html>