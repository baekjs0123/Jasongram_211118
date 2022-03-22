<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<section class="contents">
	<h2 class="mt-3 font-weight-bold">로그인</h2>
	<form id="loginForm" action="/user/sign_in" method="post">
		<div class="login-box">
			<div class="d-flex justify-content-end align-items-center pt-5 pr-5">
				<span>아이디</span> <input type="text" id="loginId" name="loginId"
					class="form-control col-9 ml-2">
			</div>
			<div class="d-flex justify-content-end align-items-center pt-2  pr-5">
				<span>비밀번호</span> <input type="password" id="password"
					name="password" class="form-control col-9 ml-2">
			</div>
			<div class="form-inline d-felx justify-content-center buttons pt-3">
				<div>
					<a class="btn btn-block btn-dark" href="/user/sign_up_view">회원가입</a>
				</div>
				<div>
					<input type="submit" id="loginBtn"
						class="btn btn-primary ml-3" value="로그인">
				</div>
			</div>
		</div>
	</form>
</section>
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
			let params = $(this).serialize(); // form의 name 속성으로 data를 구성한다.

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