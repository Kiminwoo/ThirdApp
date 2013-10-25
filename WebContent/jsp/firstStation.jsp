<%@page import="org.apache.http.HttpResponse"%>
<%@page import="org.apache.http.client.methods.HttpGet"%>
<%@page import="org.apache.http.impl.client.DefaultHttpClient"%>
<%@page import="org.apache.http.client.HttpClient"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>


<%! Connection con=null; %>
<%! Statement st= null; %>



<% 
HttpClient client = new DefaultHttpClient();

HttpGet req = new HttpGet("http://ws.bus.go.kr/api/rest/stationinfo/getStationByUid?ServiceKey=J6xG0tjVoVWunfpmecmNqFAeMEV3ZfEIgBmlpo7eKlE8rJzFy1E%2BlSYBNXvxVOaUgoFPKLt5jWk3O%2FsUbKLadA%3D%3D&arsId=14112");

HttpResponse resp = client.execute(req);

BufferedReader rd = new BufferedReader (new InputStreamReader(resp.getEntity().getContent()));

String line = "";

while ((line = rd.readLine()) != null) {
	out.print(line);
  //System.out.println(line);
  //System.out.println("**called time**");

}
%>


