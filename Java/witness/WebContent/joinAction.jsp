<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="user.UserDAO" %>
    <%@ page import="java.io.PrintWriter" %>
    <% request.setCharacterEncoding("UTF-8"); %>
    <jsp:useBean id="user" class="user.User" scope="page"/>
    <jsp:setProperty name="user" property="userID" />
    <jsp:setProperty name="user" property="userPassword"/>
    <jsp:setProperty name="user" property="userName" />
    <jsp:setProperty name="user" property="userGender"/>
    <jsp:setProperty name="user" property="userEmail" />
    <jsp:setProperty name="user" property="userHeight" />
    <jsp:setProperty name="user" property="userWeight" />
    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>게시판 만들기 준비사항</title>
</head>
<body>
	<%
	String userID = null;
	if(session.getAttribute("userID")!=null){
		userID=(String)session.getAttribute("userID");
	}
	if (userID!=null){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href = 'main_temp.jsp'");
		script.println("history.back()");
		script.println("</script>");
	}
	
	
		UserDAO userDAO =new UserDAO();
	
	int result = userDAO.join(user);
	
	if(user.getUserID()==null||user.getUserPassword()==null||user.getUserName()==null||user.getUserEmail()==null)
	{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력되지 않는 사항이 있습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}	

	
	else if(result == -1){
		PrintWriter script =response.getWriter();
		script.println("<script>");
		script.println("alert('이미 존재하는 아이디입니다.')");
		script.println("history.back()");
		script.println("</script>");
	}
	
	else 
	{
		//회원가입에 성공한 경우 세션을 분류하여 따로 관리한다.
		session.setAttribute("userID", user.getUserID());
		PrintWriter script=response.getWriter();
		script.println("<script>");
		script.println("location.href = 'main_temp.jsp'");
		script.println("</script>");
	}
	
	
	%>
</body>
</html>