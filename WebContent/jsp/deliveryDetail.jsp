<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%!Connection con = null;%>
<%!Statement st = null;%>



<%
	try {
		String id = request.getParameter("id");
		ResultSet rs = null;
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/first_app";
		String user = "root";
		String password = "asd462";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(url, user, password);
		try {
			String sql = "SELECT * FROM delivery_contact where id="
					+ id + " order by id desc";
			PreparedStatement ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
%>
<!DOCTYPE html>

<html>
<head>
<title>Access App</title>
<meta charset="UTF-8" />
<meta name="viewport"
	content="width=device-width,
		initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no" />
<link href="/ThirdApp/lib/jquery/jquery.mobile-1.3.2.css"
	rel="stylesheet" type="text/css" />
<script src="/ThirdApp/lib/jquery/jquery-1.9.1.js"></script>
			<script src="/ThirdApp/lib/jquery/jquery.mobile-1.3.2.js"></script>

		


</head>
<body>
	<div data-role="page">
		<div data-role="header">
			<h1>DELIVERY STORE PAGE</h1>
			<a href="#" data-rel="back" data-icon="arrow-l">Back</a>
		</div>

		<div data-role="content">
			<link href="/ThirdApp/lib/star-rating/jquery.rating.css"
				rel="stylesheet" type="text/css" />
				<script src="/ThirdApp/lib/star-rating/jquery.form.js"></script>
			<script src="/ThirdApp/lib/star-rating/jquery.MetaData.js"></script>
			<script src="/ThirdApp/lib/star-rating/jquery.rating.js"></script>
			<script src="/ThirdApp/lib/star-rating/jquery.rating.pack.js"></script>
			

			<!--
			<li><img src="/FirstApp/assets/img/1.jpg" />2013-10-08 똥맛카레</li>
			<li><img src="/FirstApp/assets/img/2.jpg" />2013-10-08 카레맛똥</li>
			-->
			<%
				while (rs.next()) {
							String deliveryName = rs.getString("delivery_name");
							String deliveryNumber = rs.getString("delivery_number");

							out.print("<img src='/ThirdApp/jsp/deliveryImage.jsp?id="
									+ id + "'/><br/>");
							out.print("<img src='/ThirdApp/jsp/deliveryMenu.jsp?id="
									+ id + "'/><br/>");

							out.print(deliveryName + " " + deliveryNumber);
							//out.print("<a href='#' data-role='button' data-inline='true' data-mini='true'>메뉴판</a>");
							//out.print("<a href='#' data-role='button' data-inline='true' data-mini='true'>전화걸기</a>");

							out.print("<br/><br/>");
							out.print("<a href='tel:"
									+ deliveryNumber
									+ "' data-role='button' data-inline='true'>전화걸기</a>");

						}
					} catch (SQLException e) {
						//e.printStackTrace();
					}
				} catch (ClassNotFoundException ce) {
					//out.println(ce);
				}
			%>

			<input name="star1" type="radio" class="star" /> <input name="star1"
				type="radio" class="star" /> <input name="star1" type="radio"
				class="star" /> <input name="star1" type="radio" class="star" /> <input
				name="star1" type="radio" class="star" />







		</div>
	</div>

</body>
</html>

