<!-- 학번:2013041049 이름:최재웅 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>
<body>
<div align = "center">
<h2>계산</h2>
선택한 상품 목록
<hr>
<%
	ArrayList list = (ArrayList)session.getAttribute("productlist");
	if(list==null)
	{
		out.println("선택한 상품이 없습니다.!!!");
	}
	else{
		for(Object productname:list)
		{
			out.println(productname+"<br>");
		}
	}

%>
<hr>
</div>
</body>
</html>