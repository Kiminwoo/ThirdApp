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
			Blob img;
			byte[] imgData = null;
			String sql = "SELECT * FROM delivery_contact where id="
					+ id;
			PreparedStatement ps = con.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				String req = "";

				// Query

				img = rs.getBlob("delivery_image");
				imgData = img.getBytes(1, (int) img.length());

				response.setContentType("image/jpg");
				OutputStream o = response.getOutputStream();
				o.write(imgData);
				o.flush();
				o.close();
			}
		} catch (SQLException e) {
			//e.printStackTrace();
		}
	} catch (ClassNotFoundException ce) {
		//out.println(ce);
	}
%>
