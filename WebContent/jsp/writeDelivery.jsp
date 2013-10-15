<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>



<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>

<%@ page import="org.apache.commons.fileupload.servlet.*"%>
<%@ page import="org.apache.commons.fileupload.*"%>

<%@ page import="org.apache.commons.fileupload.disk.*"%>

<%!Connection con = null;%>
<%!Statement st = null;%>

<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
	String deliveryName = null;
	String deliveryNumber = null;
	InputStream deliveryImage = null;
	long imageSize = 0;
	InputStream deliveryMenu = null;
	long menuSize = 0;
	//out.print("lunch name:::::");
	//out.print(request.getParameter("lunch_name"));
	//out.print("lunch date:::::");
	//out.print(request.getParameter("lunch_date"));
	//String id = request.getParameter("id");

	//Create a factory for disk-based file items
	DiskFileItemFactory factory = new DiskFileItemFactory();
	//Configure a repository (to ensure a secure temp location is used)
	ServletContext servletContext = this.getServletConfig()
			.getServletContext();
	File repository = (File) servletContext
			.getAttribute("javax.servlet.context.tempdir");
	factory.setRepository(repository);

	//Create a new file upload handler
	ServletFileUpload upload = new ServletFileUpload(factory);

	//Parse the request
	List<FileItem> items = upload.parseRequest(request);
	Iterator<FileItem> iter = items.iterator();
	while (iter.hasNext()) {
		FileItem item = iter.next();

		if (item.isFormField()) {
			String name = item.getFieldName();
			String value = item.getString("UTF-8");
			
			if (name.equals("delivery_name"))
				deliveryName = value;
			
			else if (name.equals("delivery_number"))
				deliveryNumber = value;

		} else {
			
			String name = item.getFieldName();
			if(name.equals("delivery_image")){
				deliveryImage = item.getInputStream();
				imageSize = item.getSize();				
			}else if(name.equals("delivery_menu")){
				deliveryMenu = item.getInputStream();
				menuSize = item.getSize();
			}
			
			//String fieldName = item.getFieldName();
			//String fileName = item.getName();
			//String contentType = item.getContentType();
			//boolean isInMemory = item.isInMemory();
			//long sizeInBytes = item.getSize();
			//out.print("fieldName : " + fieldName+"<br/>");
			//out.print("fileName : " + fileName+"<br/>");
		}
	}
	//out.print("DELIVERY NAME : :::::::: " +deliveryName);
	//out.print("DELIVERY NUMBER : :::::::: " +deliveryNumber);
	try {
		String message = null;

		String driver = "com.mysql.jdbc.Driver";
		//String url = "jdbc:mysql://localhost:3306/first_app&useUnicode=true&characterEncoding=UTF-8";
		String url = "jdbc:mysql://localhost:3306/first_app";
		String user = "root";
		String password = "asd462";
		Class.forName("com.mysql.jdbc.Driver").newInstance();
		con = DriverManager.getConnection(url, user, password);

		String querySetLimit = "SET GLOBAL max_allowed_packet=104857600;"; // 10 MB
		Statement stSetLimit = con.createStatement();
		stSetLimit.execute(querySetLimit);

		String sql = "insert into delivery_contact(delivery_name,delivery_number,delivery_image,delivery_menu) values(?,?,?,?)";
		PreparedStatement statement = con.prepareStatement(sql);

		statement.setString(1, deliveryName);
		statement.setString(2, deliveryNumber);
		if (deliveryImage != null) {
			// fetches input stream of the upload file for the blob column
			out.print("SIZE :::::::::::::::"
					+ (int) repository.length());

			statement
					.setBinaryStream(3, deliveryImage, (int) imageSize);
		}

		if (deliveryImage != null) {
			// fetches input stream of the upload file for the blob column
			out.print("SIZE :::::::::::::::"
					+ (int) repository.length());

			statement
					.setBinaryStream(4, deliveryMenu, (int) menuSize);
		}

		
		// sends the statement to the database server
		statement.executeQuery("set names 'UTF8'");
		int row = statement.executeUpdate();
		if (row > 0) {
			message = "File uploaded and saved into database";
		}
	} catch (SQLException ex) {

		ex.printStackTrace();
	} finally {
		if (con != null) {
			// closes the database connection
			try {
				con.close();
			} catch (SQLException ex) {
				ex.printStackTrace();
			}
		}
		//this.getServletContext().getRequestDispatcher("/jsp/menu.jsp").forward(request,response);
		String url = response
				.encodeRedirectUrl("/ThirdApp/jsp/delivery.jsp");
		response.sendRedirect(url);

	}
%>
