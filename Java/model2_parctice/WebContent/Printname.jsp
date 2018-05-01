<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<center>
		<h2>이름</h2>
		<form action="name.do" method="post">
			<table width="300" border="1">
			<tr height="40">
				<td width="120">이름</td>
				<td width="180"> <input type="text" name="name"> </td>
			</tr>
			<tr height="40">
				<td align="center" colspan="2">
					<input type="submit" value="입력">
				</td>
			</tr>
			</table>
		</form>
	</center>
</body>
</html>