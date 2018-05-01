<!-- 학번:2013041049 이름:최재웅 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%request.setCharacterEncoding("UTF-8"); %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ch06 : config 테스트</title>
</head>
<body>
<div align = "center">
<h2>config 예제</h2>
<hr>
<%=config.getInitParameter("workspace") %>
</div>
</body>
</html>