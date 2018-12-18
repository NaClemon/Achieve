<%@page import="com.dev.vo.MemberVO" %>
<%@page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>

<% ArrayList<MemberVO> list = (ArrayList<MemberVO>)request.getAttribute("list"); if(!list.isEmpty()) {%>
   	<table border="1">
   		<tr><th>ID</th><th>게임이름</th><th>게임가격</th><th>출시날짜</th><th>개발사</th><th>배급사</th><th>게임설명</th><th>img_url</th></tr>
   		
   		<% for (int i=0;i<list.size();i++){
   			MemberVO member = list.get(i); %>
   		<tr><td><%=member.getGame_id() %></td>
   			<td><%=member.getGame_name() %></td>
   			<td><%=member.getGame_price() %></td>
   			<td><%=member.getGame_date() %></td>
   			<td><%=member.getGame_dev()%></td>
   			<td><%=member.getGame_pub() %></td>
   			<td><%=member.getGame_cont() %></td>
   			<td><%=member.getImg_url() %></td>
   		</tr>
   		
   	<%	}
   	}else{
   		System.out.print("<h3>등록된 회원정보가 없습니다.</h3>");
   	}%>
   	</table>
   	
   	<%@include file="home.jsp" %>

</body>
</html>