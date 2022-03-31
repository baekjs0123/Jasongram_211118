<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<div>
	<%-- 내 정보 --%>
	<div class="my-profile-box d-flex">
		<div class="profile-img-box ml-5 mr-5">
			<a href="#" id="profileImageBtn">
				<img class="profile-img" src="/snsImages/default_profile.png" alt="내 프로필 사진">
			</a>
			<div id="profileImageSet" class="modal">
				<button type="button" id="imageUploadBtn" class="btn btn-primary w-100">사진 업로드</button>
				<button type="button" id="imageDeleteBtn" class="btn btn-danger w-100">사진 삭제</button>
				<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
				<div id="fileName" class="d-none"></div>
			</div>
		</div>
		<div class="ml-5">
			<h3>${userLoginId}</h3>
			<div class="mt-4">
				<span>게시물 ${postCount}</span>
				<span>팔로워 1</span>
				<span>팔로우 1</span>
			</div>
			<div class="mt-4">
				<span class="font-weight-bold">${userName}</span>
			</div>
		</div>
	</div>
	<%-- 내 게시물 --%>
	<hr>
	<div class="my-post-box d-flex justify-content-between flex-wrap">
	<c:forEach items="${cardViewList}" var="card">
		<c:if test="${card.post.userId eq userId}">
		<div class="post-images mb-5">
			<img class="post-image" src="${card.post.imagePath}" alt="게시물 사진">
		</div>
		</c:if>
	</c:forEach>
	</div>
</div>
<script>
$(document).ready(function() {
	$('#profileImageBtn').on('click', function(e) {
		//alert("프로필 이미지 변경");
		e.preventDefault(); // 위로 올라가는 현상 방지
		$('#profileImageSet').modal();
	});
	
	$('#imageUploadBtn').on('click', function() {
		//alert("사진 업로드");
		$('#file').click();
		
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
		});
		
		$.ajax({
			type:"post"
				, url:"/profile/update"
				, data: formData
				, enctype: "multipart/form-data" // 파일 업로드를 위한 필수 설정
				, processData: false // 파일 업로드를 위한 필수 설정
				, contentType: false // 파일 업로드를 위한 필수 설정
				, success: function(data) {
					if (data.result == "success") {
						alert("메모가 저장되었습니다.");
						location.href = "/timeline/timeline_view";
					} else {
						alret(data.error_message);
					}
				}
				, error: function(e) {
					alert("메모 저장에 실패했습니다. 관리자에게 문의 해주세요.");
				}
		});
	});
	
});
</script>