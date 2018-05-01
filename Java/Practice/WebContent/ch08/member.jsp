<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% request.setCharacterEncoding("utf-8"); %>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb";
	
	int k=1;
	try{
		Class.forName(jdbc_driver);
		
		conn = DriverManager.getConnection(jdbc_url, "root", "dbqldhk@038");
		
		String sql = "insert into member values(?, ?, ?, ?)";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, request.getParameter("memberid"));
		pstmt.setString(2, request.getParameter("membername"));
		pstmt.setString(3, request.getParameter("membertel"));
		pstmt.setString(4, request.getParameter("gender"));
		
		if(request.getParameter("memberid") != null){
			pstmt.executeUpdate();
		}
	}
	catch(Exception e){
		System.out.println(e);
	}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>member</title>
</head>
<body>
	<div align="center">
		<h2>회원 정보</h2>
		<hr>
		<form name="form2" method="post" action="member.jsp">
			회원 ID: <input type="text" name="memberid">
			회원 이름: <input type="text" name="membername">
			전화번호: <input type="text" name="membertel">  
			<input type="radio" name="gender" value="남성"> 남성 
  			<input type="radio" name="gender" value="여성"> 여성 
  			<input type="submit" value="등록">
		</form>
		<hr>
		#등록 목록<br>
	</div>
	<%
		try{
			String sql = "select mem01, mem02, mem03, mem04 from member";
			
			pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next()){
				out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3) + ", " + rs.getString(4) + "<br>");
			}
			rs.close();
			pstmt.close();
			conn.close();
		}
		catch(Exception e){
			System.out.println(e);
		}
	%>
</body>
</html>