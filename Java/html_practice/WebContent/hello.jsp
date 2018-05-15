<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
double r = Math.random();
if(r>0.6){
%>
<h2 style="color: red">오늘은 행운의 날입니다!</h2>
<p>확률: <%= r %></p>
<%
}else{
%>
<h2>오늘은 평범한 날입니다.</h2>
<p>확률: <%= r %></p>
<%} %>
<a href="<%= request.getRequestURI() %>"><h3>다시 시도</h3></a>
</body>
</html>