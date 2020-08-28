<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" />
<link rel="stylesheet" href="/resources/css/login.css" />
<%--
	custom Login page 작성 규칙
    ① method = "post", action="/login" 으로 주기
    ② csrf 토큰 값 무조건 포함
	③ 아이디를 입력받는 부분의 이름은 반드시 username으로 하기
	④ 비밀번호를 입력받는 부분의 이름은 반드시 password 로 주기	
--%>
</head>
<script>
let msg = '${msg}';
if(msg!=''){
	alert(msg);
}
</script>
<body>

	<form action="/member/login" method="post" class="form-signin">
		<h1 class="h3 bm-3 font-weight-normal">Sign in</h1>
		<div>
			<label for="id" class="sr-only">아이디</label>
			<input type="text" name="userid" placeholder="아이디" required="required" autofocus="autofocus" class="form-control"/>
		</div>
		<div>
			<label for="password" class="sr-only">비밀번호</label>
			<input type="password" name="password" placeholder="비밀번호" required="required" class="form-control"/>
		</div>
		<div class="checkbox mb-3">
			<label for="">
				<input type="checkbox" name = "remember-me" />Remember me
			</label>
		</div>

		
		<div>
			<button class="btn btn-primary  btn-block"> Sign in</button>
		</div>
		
	</form>

	
	
	
</body>
</html>