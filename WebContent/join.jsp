<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join jsp</title>
</head>
<body>
    <form action="joinOK.jsp" method="post" name="reg_frm">
        아이디 : <input type = "text" name ="id" size="20"><br/>
        비밀번호 : <input type = "password" name="password" size="50"><br/>
        <!-- 비밀번호 확인 : <input type="password" name="password_check" size="50"> -->
        이름 : <input type = "text" name ="name" size="50"><br/>
        전화 : <input type = "text" name ="phone" size="20"><br/>
        이메일 : <input type = "text" name ="email" size="50"><br/>
        <input type="submit" value="회원가입"> &nbsp;&nbsp;
        <input type="reset" value="취소" onclick="javascript:window.location='login.jsp'">
    </form>
</body>
</html>