<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="java.sql.Timestamp" %>
    <%@page import="info.example.dao.*" %>
    <%@page import="info.example.dto.*" %>
    
    <jsp:useBean id="dto" class="info.example.dto.UserDto"/>
    <jsp:setProperty name="dto" property="*"/>
    
    <% request.setCharacterEncoding("UTF-8"); %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	UserDao dao = UserDao.getInstance();
	if(dao.confirmId(dto.getId()) == UserDao.USER_CONFIRM_SUCCESS) {
		
%>
	<script language="javascript"> 
	alert("아이디가 이미 존재 합니다.");
	history.back();
	</script>
<%
	} else {
		int ri = dao.insertUser (dto);
		System.out.println("dto:"+dto.toString());
		if(ri == UserDao.USER_JOIN_SUCCESS) {
			session.setAttribute("id", dto.getId());
%>
	<script language="javascript"> 
	alert("회원가입을 축하합니다.");
	document.location.href="login.jsp";
	</script>
<%
	} else {
%>
	<script language="javascript"> 
	alert("회원가입에 실패했습니다.");
	document.location.href="login.jsp";
	</script>
<%
	  }
	}
%>
</body>
</html>