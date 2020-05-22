<%@ page import="info.example.dto.UserDto" %>
<%@ page import="info.example.dao.UserDao" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="info.example.dto.UserDto" %>
<%@ page import="info.example.dao.UserDao" %>

<% request.setCharacterEncoding("UTF-8"); %>
<%
String id = (String)session.getAttribute("id");
UserDao dao = UserDao.getInstance();
UserDto dto = dao.getUser(id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form action="modifyOK.jsp" method ="post" name="reg_frm">
아이디 : <%= dto.getId() %><br/>
비밀번호 : <input type = "password" name = "password" size ="50"><br/>
<!--  비밀번호 확인 : <input type = "password" name = "pw_check" size ="50"></br> -->
이름 : <%=dto.getName() %><br/>
전화 : <input type="text" name="phone" size="20" value="<%=dto.getPhone() %>"><br/>
메일 : <input type="text" name="email" size="50" value="<%=dto.getEmail() %>"><br/>
<input type = "button" value="수정" onclick="updateInfoConfirm()">&nbsp;&nbsp;&nbsp;
<input type ="reset" value="취소" onclick="javascript:window.location='login.jsp'">
</form>


</body>
</html>