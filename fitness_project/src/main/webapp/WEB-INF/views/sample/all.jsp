<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ALL</title>
</head>
<body>
	<h2>ALL</h2>
	<a href="member">member</a>
	<!-- <a href="kakao">kakao</a> 일단 주석 -->
	<a href="admin">admin</a>
	
	<hr>
	<p>principal : <sec:authentication property="principal"/></p>
	<sec:csrfInput/>
	<sec:authorize access="isAuthenticated()">
		<p>memberVo : <sec:authentication property="principal.memberVo"/></p>
		<p>userName : <sec:authentication property="principal.memberVo.userName"/></p>
		<p>username : <sec:authentication property="principal.username"/></p>
		<p>auth : <sec:authentication property="principal.memberVo.auths"/></p>
		
	</sec:authorize>
</body>
</html>