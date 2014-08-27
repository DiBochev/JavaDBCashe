<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html>
<html>
<body>

<%
String url = "jdbc:postgresql://localhost:5432/javadb";
String username = "postgres";
String password = "123456";
Connection conn = null;
String userID = request.getParameter("users");
ResultSet rs= null;
StringBuilder sb= new StringBuilder();
try {
	Class.forName("org.postgresql.Driver");
	conn = DriverManager.getConnection (url, username, password );
	Statement stmt = conn.createStatement();
	rs = stmt.executeQuery("SELECT * FROM public.pics;");
}catch(SQLException e){
	e.printStackTrace();
}finally {
	if(conn != null){
		conn.close();
	}
}
	if (userID.equals("all")){
		while(rs.next()){
			String picSRC = rs.getString("pic_src");
			sb.append("<img src=\""+picSRC+"\"height=\"100\" width=\"100\">");
		}out.print(sb.toString());
	}else{
		while(rs.next()){
			String picSRC = rs.getString("pic_src");
			String idUserDB = rs.getString("id_user");
			if(userID.equals(idUserDB)){
				sb.append("<img src=\""+picSRC+"\"height=\"100\" width=\"100\">");
			}
		}out.print(sb.toString());
	}
%>
<%
ResultSet rss= null;
try{
	conn = DriverManager.getConnection (url, username, password );
	Statement stmst = conn.createStatement();
	rss = stmst.executeQuery("SELECT * FROM public.users;");
}catch(SQLException e){
	e.printStackTrace();
}catch(NullPointerException e){
	out.println("Възникна грешка при изпълнението на заявката " + e.getMessage());
	e.printStackTrace();
}finally {
	if(conn != null){
		conn.close();
	}
}
	if (userID.equals("all")){
		while(rss.next()){
			String usernames = rss.getString("username");
			out.println(usernames);
		}
	}else{
		while(rss.next()){
			String usernames = rss.getString("username");
			String id = rss.getString("id");
			if(userID.equals(id)){
				out.println(usernames);
			}
		}
	}
%>
</body>
</html>