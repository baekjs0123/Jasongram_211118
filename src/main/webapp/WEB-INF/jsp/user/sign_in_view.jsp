<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Jasongram-로그인</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
	<link rel="stylesheet" href="/css/sns.css">
</head>
<body>
	<div id="wrap">
		<header>
			<h1>Jasongram</h1>
		</header>
		<section class="contents">
			<h2 class="mt-3 font-weight-bold">로그인</h2>
			<div class="login-box">
				<div class="d-flex justify-content-end align-items-center pt-5 pr-5">
					<span>아이디</span>
					<input type="text" id="userId" class="form-control col-9 ml-2">
				</div>	
				<div class="d-flex justify-content-end align-items-center pt-2  pr-5">
					<span>비밀번호</span>
					<input type="password" id="userId" class="form-control col-9 ml-2">
				</div>
				<div class="d-felx justify-content-center buttons pt-3">
					<button type="button" id="loginBtn" class="btn btn-secondary ml-3">로그인</button>
					<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
				</div>	
			</div>
		</section>
	</div>
<script>
$(document).ready(function() {
	$('#loginForm').on('submit', function(e) {
		e.preventDefault(); // submit 수행 중단
		
		let loginId = $('#loginId').val().trim();
		
		// validation
		if (loginId == '') {
			alert("아이디를 입력해주세요");
			return false;
		}
		
		let password = $('#password').val();
		if (password == '') {
			alert("비밀번호를 입력해주세요.");
			return false;
		}
		
		// submit X AJAX O
		let url = $(this).attr("action");
		let params = $(this).serialize();  // form의 name 속성으로 data를 구성한다.
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				// 로그인 성공
				location.href="/post/post_list_view"; 
			} else {
				alert(data.error_message);
			}
		}); 
	});
});
</script>
</body>
</html>