<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member</title>
</head>
<body>
	<h2>Member</h2>
		<form action="/logout" method="post">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		<button>로그아웃</button>
		</form>
</body>
</html>