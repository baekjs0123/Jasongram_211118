<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Jasongram-회원가입</title>
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
			<h2 class="mt-3 font-weight-bold">회원가입</h2>
			<form id="signUpForm" method="post" action="/user/sign_up">
				<div class="sign-up-box">
					<div class="pl-3 pt-3">
						<span>ID(6자 이상)</span>
						<div class="d-flex">
							<input type="text" id="loginId" name="loginId" class="form-control col-9">
							<button type="button" id="checkDuplicateBtn" class="btn btn-info ml-3">중복확인</button>
						</div>
						<div id="idCheckLength" class="small text-danger d-none">ID를 6자 이상 입력해주세요.</div>
						<div id="idCheckDuplicated" class="small text-danger d-none">이미 사용중인 ID입니다.</div>
						<div id="idCheckOk" class="small text-success d-none">사용 가능한 ID 입니다.</div>
					</div>	
					<div class="pl-3 pt-3">
						<span>password</span>
						<input type="password" id="password" name="password" class="form-control col-9">
					</div>	
					<div class="pl-3 pt-3">
						<span>confirm password</span>
						<input type="password" id="confirmPassword" class="form-control col-9">
					</div>	
					<div class="pl-3 pt-3">
						<span>이름</span>
						<input type="text" id="name" name="name" class="form-control col-9" placeholder="이름을 입력해주세요.">
					</div>	
					<div class="pl-3 pt-3">
						<span>이메일</span>
						<input type="text" id="email" name="email" class="form-control col-9" placeholder="이메일을 입력해주세요.">
					</div>	
					<div class="d-flex justify-content-center pt-3">
						<button type="button" id="signUpBtn" class="btn btn-info">가입하기</button>
					</div>
				</form>
			</div>
		</section>
	</div>
<script>
$(document).ready(function() {
	$('#checkDuplicateBtn').on('click', function() {
		//alert("중복확인 버튼");
		let loginId = $('#loginId').val().trim();
		
		// 경고 문구 초기화
		$('#idCheckLength').addClass('d-none');
		$('#idCheckDuplicated').addClass('d-none');
		$('#idCheckOk').addClass('d-none');
		
		if (loginId.length < 6) {
			$('#idCheckLength').removeClass('d-none');
			return;
		}
		
		$.ajax({
			url: "/user/is_duplicated_id",
			data: {"loginId":loginId},
			success: function(data) {
				if (data.result) { // 중복인 경우
					$('#idCheckDuplicated').removeClass('d-none');
				} else { // 사용가능
					$('#idCheckOk').removeClass('d-none');
				}
			},
			error: function(error) {
				alert("아이디 중복확인에 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
		
	});
	$('#signUpBtn').on('click', function() {
		//alert("가입하기 버튼");
		let loginId = $('#loginId').val().trim();
		if (loginId == '') {
			alert("아이디를 입력하세요.");
			return;
		}
		
		let password = $('#password').val().trim();
		let confirmPassword = $('#confirmPassword').val().trim();
		if (password == '' || confirmPassword == '') {
			alert("비밀번호를 입력하세요.");
			return;
		}
		
		// 비밀번호 확인 일치 여부
		if (password != confirmPassword) {
			alert("비밀번호가 일치하지 않습니다. 다시 입력하세요.");
			// 텍스트박스의 값을 초기화 한다.
			$('#password').val('');
			$('#confirmPassword').val('');
			return;
		}
		
		let name = $('#name').val().trim();
		if (name == '') {
			alert("이름을 입력하세요.");
			return;
		}
		let email = $('#email').val().trim();
		if (email == '') {
			alert("이메일 주소를 입력하세요.");
			return;
		}
		
		// 아이디 중복확인이 완료되었는지 확인
		//-- idCheckOk <div> 클래스에 d-none이 없으면 사용 가능
		// idCheckOk d-none이 있으면 => alert 띄운다.
		if ($('#idCheckOk').hasClass('d-none')) {
			alert("아이디 중복확인을 해주세요.");
			return;
		}
		
		let url = $('#signUpForm').attr('action'); // form에 있는 action 주소를 가져오기
		let params = $('#signUpForm').serialize();
		
		$.post(url, params)
		.done(function(data) {
			if (data.result == "success") {
				alert("가입을 환영합니다! 로그인을 해주세요.");				
				location.href="/user/sign_in_view";
			} else {
				alert("가입에 실패했습니다. 다시 시도해주세요.");
			}
		});
			
	});
});
</script>
</body>
</html>