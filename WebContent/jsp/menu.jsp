<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%! Connection con=null; %>
<%! Statement st= null; %>



<% 


try {
ResultSet rs= null; 
String driver = "com.mysql.jdbc.Driver";
String url = "jdbc:mysql://localhost:3306/first_app";
String user = "root";
String password = "asd462"; 
Class.forName("com.mysql.jdbc.Driver").newInstance();
con = DriverManager.getConnection(url, user, password);
try {
	String sql = "SELECT * FROM lunch_menu order by id desc";
            PreparedStatement ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
           
%>
<!DOCTYPE html>

<html>
	<head>
		<title>Access App</title>
		<meta charset="UTF-8"/>
		<meta name="viewport" content="width=device-width,
		initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no"/>
		<link href="/ThirdApp/lib/jquery/jquery.mobile-1.3.2.css" rel="stylesheet" type="text/css" />
		
		<link href="/ThirdApp/lib/star-rating/jquery.rating.css" rel="stylesheet" type="text/css" />
		<script src="/ThirdApp/lib/jquery/jquery-1.9.1.js"></script>
		<script src="/ThirdApp/lib/jquery/jquery.mobile-1.3.2.js"></script>
		
		

	</head>
	<body>
		<div data-role="page">
	<div data-role="header">
		<h1>MENU PAGE</h1>
		<a href="#" data-rel="back" data-icon="arrow-l">Back</a>
		<a href="/ThirdApp/view/main.html" data-icon="home">Home</a>
	</div>

	<div data-role="content">
		<ul data-role="listview">
			<!--
			<li><img src="/FirstApp/assets/img/1.jpg" />2013-10-08 똥맛카레</li>
			<li><img src="/FirstApp/assets/img/2.jpg" />2013-10-08 카레맛똥</li>
			-->
			<%
			
			while(rs.next()){
				String date = rs.getString("lunch_date");
				String name = rs.getString("lunch_name");
				String id = rs.getString("id");
				out.print("<li>");
				//out.print("<img src='/ThirdApp/jsp/image.jsp?id="+id+"'/>");
				
				out.print(date + "<br/>" + name);




				out.print("</li>");
			}
			} catch (SQLException e) {
			//e.printStackTrace();
			}
			}catch(ClassNotFoundException ce){out.println(ce);}
			%>
			<a href="/ThirdApp/view/writeMenu.html" data-role="button">ADD LUNCH MENU</a>
			 
		</ul>
	</div>
</div>

	</body>
</html>

