<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<%-- 내 정보 --%>
	<div class="my-profile-box d-flex">
	
		<%-- 프로필 사진 --%>
		<div class="profile-img-box ml-5 mr-5">
			<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
			
			<%-- 내 프로필일 때만 사진 수정가능, 다른 유저 프로필일 경우 수정불가--%>
			<c:if test="${user.id eq userId}">
			<a href="#" id="profileImageBtn" data-toggle="modal" data-target="#profileImageModal" data-user-id="${user.id}">
				<c:if test="${not empty user.profileImagePath}">
					<img class="profile-img" src="${user.profileImagePath}" alt="내 프로필 사진">
				</c:if>
				<c:if test="${empty user.profileImagePath}">
					<img class="profile-img" src="/snsImages/default_profile.png" alt="프로필 사진">
				</c:if>
			</a>
			</c:if>
			<c:if test="${user.id ne userId}">
				<c:if test="${not empty user.profileImagePath}">
					<img class="profile-img" src="${user.profileImagePath}" alt="내 프로필 사진">
				</c:if>
				<c:if test="${empty user.profileImagePath}">
					<img class="profile-img" src="/snsImages/default_profile.png" alt="내 프로필 사진">
				</c:if>
			</c:if>
			<div id="fileName" class="d-none"></div>
		</div>
		
		<%-- 유저 아이디 ,게시물 수, 팔로워, 팔로우 등 정보 출력 --%>
		<div class="ml-5">
			<h3>${user.loginId}</h3>
			<div class="mt-4">
				<span>게시물 ${postCount}</span>
				<span>팔로워 1</span>
				<span>팔로우 1</span>
			</div>
			<div class="mt-4">
				<span class="font-weight-bold">${user.name}</span>
			</div>
		</div>
	</div>
	
	<%-- 내 게시물 --%>
	<hr>
	<div class="my-post-box d-flex justify-content-between flex-wrap">
	<c:forEach items="${cardViewList}" var="card">
		<c:if test="${card.post.userId eq user.id}">
		<div class="post-images mb-5">
			<img class="post-image" src="${card.post.imagePath}" alt="게시물 사진">
		</div>
		</c:if>
	</c:forEach>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="profileImageModal">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="text-center">
				<div class="my-3">
					<a href="#" id="imageUploadBtn" class="d-block text-primary">사진 업로드</a>
				</div>
				<hr>
				<div class="my-3">
					<a href="#" id="imageDeleteBtn" class="d-block text-danger">현재 사진 삭제</a>
				</div>
				<hr>
				<div class="my-3">
					<a href="#" class="d-block" data-dismiss="modal">취소</a>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {
	$('#profileImageBtn').on('click', function(e) {
		//alert("프로필 이미지 변경");
		e.preventDefault(); // 위로 올라가는 현상 방지
		
		let userId = $(this).data('user-id');
		$('#profileImageModal').data('user-id', userId);
	});
	
	$('#profileImageModal #imageUploadBtn').on('click', function(e) {
		//alert("사진 업로드");
		e.preventDefault();
		
		$('#file').click();
	});
	
	// 사용자가 파일 업로드를 했을 때 유효성 확인 및 업로드 된 파일 이름 노출
	$('#file').on('change', function(e) {
		//alert("체인지");
		let fileName = e.target.files[0].name;
		//alert(fileName);
		let fileArr = fileName.split(".")
		
		// 확장자 유효성 체크
		if (fileArr.length < 2 || 
				(fileArr[fileArr.length - 1].toLowerCase()) != "gif"
				&& (fileArr[fileArr.length - 1].toLowerCase()) != "png"
				&& (fileArr[fileArr.length - 1].toLowerCase()) != "jpeg"
				&& (fileArr[fileArr.length - 1].toLowerCase()) != "jpg") {
			alert("이미지 파일만 업로드 해주세요.");
			$(this).val(''); // 파일이 서버에 넘어가지 않도록 비워줌
			$('#fileName').text(''); // 파일명도 비워줌
			return;
		}
		
		$('#fileName').text(fileName);
		
		let file = $('#file').val();
		if (file == '') {
			alert("사진파일을 첨부해주세요.");
			return;
		}
		
		let formData = new FormData();
		formData.append("file", $('#file')[0].files[0]);
		
		$.ajax({
			type:"put"
				, url:"/profile/update"
				, data: formData
				, enctype: "multipart/form-data" // 파일 업로드를 위한 필수 설정
				, processData: false // 파일 업로드를 위한 필수 설정
				, contentType: false // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.result == "success") {
						//alert("프로필 이미지 등록 성공!");
						location.reload();
					} else {
						alret(data.error_message);
					}
				}
				, error: function(e) {
					alert("프로필 사진 업로드에 실패했습니다. 관리자에게 문의 해주세요.");
				}
		});
	});
	
	$('#profileImageModal #imageDeleteBtn').on('click', function(e) {
		//alert("사진 삭제");
		e.preventDefault();
		
		let userId = $('#profileImageModal').data('user-id');
		//alert(userId);
		
		$.ajax({
			type:"put"
			, url:"/profile/delete_profile_image"
			, data: {"userId":userId}
			, success:function(data) {
				if (data.result == "success") {
					//alert("프로필 사진 삭제 성공!");
					location.reload();
				} else {
					alert(data.error_message);
				}
				
			}
			, error:function(e) {
				alert("사진을 삭제하는데 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>