<!-- 학번:2013041049 이름:최재웅 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<div align = "center">
<h2>application 예제</h2>

<hr>

username에 설정된 값은 ㅣ <%= application.getAttribute("username") %><p>
<%
	Integer count = (Integer)application.getAttribute("count");
	int cnt = count.intValue()+1;
	application.setAttribute("count",cnt);
%>
count : <%=cnt %>
</div>
</body>
</html>