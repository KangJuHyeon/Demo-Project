<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "info.example.dao.UserDao" %>

<jsp:useBean id="dto" class="info.example.dto.UserDto" scope="page"/>
<jsp:setProperty name="dto" property="*"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify ok</title>
</head>
<body>

<%
    request.setCharacterEncoding("UTF-8");
    String id = (String)session.getAttribute("id");
    dto.setId(id);

    UserDao dao = UserDao.getInstance();
    int rCode = dao.updateUser(dto);
    System.out.println("rCode : " + rCode);

    if(rCode == 1) {
%>
    <script language="javascript">
        alert("정보수정 되었습니다.");
        document.location.href="main.jsp";
    </script>
<%
    } else {
%>
    <script language="javascript">
        alert("정보수정 실패입니다.");
        history.go(-1);
    </script>
<%
    }
%>

</body>
</html>