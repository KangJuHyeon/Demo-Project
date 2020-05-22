<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="info.example.dto.UserDto" %>
<%@ page import="info.example.dao.UserDao" %>

<% request.setCharacterEncoding("UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login Ok jsp</title>
</head>
<body>
<%
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	UserDao dao = UserDao.getInstance();
	
	int rCode = dao.checkUser(id, password);
	System.out.println("rCode : " + rCode);
	
	if(rCode == UserDao.USER_CHECK_IDNOTFOUND){
%>
	<script language="javascript">
		alert("이 아이디가 존재하지 않습니다.");
		history.go(-1);
	</script>
<%
	} else if(rCode == UserDao.USER_PASSWORD_NOTEQUAL) {
%>
	<script language="javascript">
		alert("비밀번호가 틀립니다.");
		history.go(-1);
	</script>
<%
	} else if(rCode == UserDao.USER_LOGIN_SUCCESS){
		UserDto dto = dao.getUser(id);
		if(dto == null) {
%>
	<script language = "javascript">
		alert("존재하지 않는 회원 입니다.");
		history.go(-1);
	</script>
<%
		} else {
			String name = dto.getName();
			System.out.println("name : "+ name);
			session.setAttribute("id", id);
			session.setAttribute("name", name);
			session.setAttribute("validUser", "yes");
			response.sendRedirect("main.jsp");
		}
	}
%>
</body>
</html>