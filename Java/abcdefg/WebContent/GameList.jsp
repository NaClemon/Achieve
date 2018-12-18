<%@page import="com.dev.vo.GameVO" %>
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

<form action="gameInsert.do" method="post">
	장르 <select>
		<option value="선택">선택</option>
		<option value="액션">액션</option>
		<option value="전략">전략</option>
	</select>
	
	<input type="submit" value="검색">
</form>

<% ArrayList<GameVO> list = (ArrayList<GameVO>)request.getAttribute("list");
   if(!list.isEmpty()) {%>
   	<table border="1">
   		
   		<% for (int i=0;i<list.size();i++){
   			GameVO game = list.get(i); %>
   		<tr>
   			<td><img src="<%=game.getImg_url()%>"></td>
   			<td><%=game.getGame_date()%></td>
   			<td><%=game.getGame_date() %></td>
   			<td><%=game.getGame_price() %></td>
   		</tr>
   		
   	<%	}
   	}else{
   		System.out.print("<h3>등록된 회원정보가 없습니다.</h3>");
   	}%>
   	</table>
   	
   	<!--%@include file="home.jsp" %>  -->

</body>
</html>