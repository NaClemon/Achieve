<!--학번 : 2014041030 이름: 손광호  -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.text.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	request.setCharacterEncoding("UTF-8");

	String msg = request.getParameter("msg");
	
	Object username = session.getAttribute("user");
	
	ArrayList<String> msgs = (ArrayList<String>)application.getAttribute("msgs");
	
	if(msgs == null){
		msgs = new ArrayList<String>();
		application.setAttribute("msgs",msgs);
	}
	Date date = new Date();
	SimpleDateFormat f = new SimpleDateFormat("E MMM dd HH:mm", Locale.KOREA);
	msgs.add(username+" :: "+msg+", "+f.format(date));
	
	application.log(msg+"추가됨");
	response.sendRedirect("twitter_list.jsp");
%>