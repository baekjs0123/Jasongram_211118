<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<div class="contents">
	<c:if test="${not empty userName}">
		<div class="card border rounded mb-3">
			<textarea rows="3" cols="65" class="" id="content"></textarea>
			<div class="d-flex justify-content-between">
				<div class="file-upload d-flex">
					<input type="file" id="file" class="d-none" accept=".gif, .jpg, .png, .jpeg">
					<a href="#" id="fileUploadBtn"><img src="/snsImages/image-icon.png" alt="이미지" width="30px"></a>
					<div id="fileName" class="ml-2"></div>
				</div>
				<button type="button" id="contentUploadBtn" class="btn btn-info">게시</button>
			</div>
		</div>
	</c:if>
	<c:forEach items="${cardViewList}" var="card">
		<div class="card border rounded mt-3">
		
		<%-- 글쓴이명, 삭제버튼 --%>
			<div class="userId-box d-flex justify-content-between">
				<a href="/profile/profile_view?userId=${card.user.id}" class="font-weight-bold">
					${card.user.name}
				</a>
				
				<%-- 글쓴이와 로그인된 사용자가 같을 경우 더보기 아이콘 노출 --%>
				<c:if test="${card.user.id eq userId}">
				<a href="#" class="more-btn" data-toggle="modal" data-target="#moreModal" data-post-id="${card.post.id}">
					<img src="/snsImages/more-icon.png" alt="더보기 아이콘" width="30px">
				</a>
				</c:if>
			</div>
			
			<%-- 이미지 --%>
			<div class="card-img">
				<img src="${card.post.imagePath}" alt="사진" width="700px">
			</div>
			
			<%-- 좋아요 --%>
			<div class="card-like m-3">
				<a href="#" class="like-btn" data-post-id="${card.post.id}" data-user-id="${userId}">
					<%-- 좋아요 해제 상태 --%>
					<c:if test="${card.filledLike eq false}">
						<img src="/snsImages/empty-heart-icon.png" alt="빈 하트" width="20px">
					</c:if>
					<%-- 좋아요 상태 --%>
					<c:if test="${card.filledLike eq true}">
						<img src="/snsImages/red-heart-icon.png" alt="하트" width="20px">
					</c:if>
				</a>
				<a href="#" class="text-dark">좋아요 ${card.count}개</a>
			</div>
			
			<%-- 글(Post) --%>
			<div class="card-post m-3">
				<a href="/profile/profile_view?userId=${card.user.id}" class="font-weight-bold">
					${card.user.name}
				</a>
				<span>
					${card.post.content}
				</span>
			</div>
			<c:if test="${not empty card.commentList}">
				<div class="card-comment-desc border-bottom">
					<div class="ml-3 mb-1 font-weight-bold">댓글</div>
				</div>
				<div class="card-comment-list m-2">
				
				<%-- 댓글 리스트 --%>
				<c:forEach var="commentView" items="${card.commentList}">
					<div class="card-comment m-1">
						<a href="/profile/profile_view?userId=${commentView.comment.userId}" class="font-weight-bold">
							${commentView.user.name}
						</a>
						<span>${commentView.comment.content}</span>
						
						<%-- 댓글쓴이가 본인이면 삭제버튼 노출 --%>
						<c:if test="${commentView.user.id eq userId}">
							<a href="#" class="commentDeleteBtn" data-comment-id="${commentView.comment.id}">
								<img src="/snsImages/garbagecan-icon.png" alt="삭제하기" width="15px">
							</a>
						</c:if>
					</div>
				</c:forEach>
				</div>
			</c:if>
			<c:if test="${not empty userId}">
				<div class="comment-write d-flex border-top mt-2">
					<input type="text" id="comment${card.post.id}" class="form-control border-0 mr-2" placeholder="댓글 달기..."/> 
					<button type="button" class="commentBtn btn btn-light text-info" data-post-id="${card.post.id}">게시</button>
				</div>
			</c:if>
		</div>
	</c:forEach>
</div>


<!-- Modal -->
<div class="modal fade" id="moreModal">
	<div class="modal-dialog modal-sm modal-dialog-centered" role="document">
		<div class="modal-content">
			<div class="text-center">
				<div class="my-3">
					<a href="#" id="postDeleteBtn" class="d-block">삭제하기</a>
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
	// 파일 업로드 이미지 버튼 클릭 => 파일 선택 창이 떠야함
	$('#fileUploadBtn').on('click', function(e) {
		e.preventDefault(); // 위로 올라가는 현상 방지
		$('#file').click(); // input file을 클릭한 것과 같은 효과
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
	});
	
	$('#contentUploadBtn').on('click', function() {
		//alert("업로드 버튼");
		let content = $('#content').val();
		if (content == '') {
			alert("내용을 입력해주세요.");
			return;
		}
		
		let file = $('#file').val();
		if (file == '') {
			alert("사진파일을 첨부해주세요.");
			return;
		}
		
		let formData = new FormData();
		formData.append("content", content);
		formData.append("file", $('#file')[0].files[0]);
		
		// ajax 서버 통신
		$.ajax({
			type:"post"
			, url:"/post/create"
			, data: formData
			, enctype: "multipart/form-data" // 파일 업로드를 위한 필수 설정
			, processData: false // 파일 업로드를 위한 필수 설정
			, contentType: false // 파일 업로드를 위한 필수 설정
			, success: function(data) {
				if (data.result == "success") {
					alert("게시글이 저장되었습니다.");
					location.href = "/timeline/timeline_view";
				} else {
					alret(data.error_message);
				}
			}
			, error: function(e) {
				alert("게시글 저장에 실패했습니다. 관리자에게 문의 해주세요.");
			}
		});
	});
	
	// 댓글 쓰기
	$('.commentBtn').on('click', function() {
		let postId = $(this).data('post-id');
		//alert(postId);
		
		//let commentContent = $('#comment' + postId).val().trim();
		let commentContent = $(this).siblings('input').val().trim();
		//alert(commentContent);
		if (commentContent == null) {
			alert("댓글 내용을 입력해주세요.");
			return;
		}
		
		// ajax
		$.ajax({
			type: "post",
			url: "/comment/create",
			data: {"postId" : postId, "content" : commentContent},
			success: function(data) {
				if (data.result == "success") {
					location.reload();
				} else {
					alert(data.error_message);
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				var errorMsg = jqXHR.responseJSON.status;
				alert(errorMsg + ":" + textStatus);
			}
			
		});
	});
	
	// 댓글 삭제
	$('.commentDeleteBtn').on('click', function(e) {
		e.preventDefault();
		
		let commentId = $(this).data('comment-id');
		//alert(commentId);
		
		$.ajax({
			type:"DELETE"
			, url:"/comment/delete"
			, data: {"commentId":commentId}
			, success:function(data) {
				if (data.result == "success") {
					//alert("댓글 삭제 성공");
					location.reload();
				} else {
					alert(data.error_message);
				}
				
			}
			, error:function(e) {
				alert("삭제하는데 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
		
	});
	
	// 좋아요 버튼 클릭
	$('.like-btn').on('click', function(e) {
		e.preventDefault();
		
		var postId = $(this).data('post-id');
		var userId = $(this).data('user-id'); // 로그인 여부 확인 용

		console.log(postId);
		console.log(userId);
		
		if (userId == '') {
			alert('로그인 후에 이용 가능합니다');
			return; 
		}
		
		$.ajax({
			type:'POST',
			url:'/like/' + postId,
			data: {"postId":postId}, // userId는 서버의 세션에서 가져올 것이다. 
			success: function(data) {
				if (data.result == 'success') {
					location.reload(); // 새로고침
				}
			},
			error: function(jqXHR, textStatus, errorThrown) {
				var errorMsg = jqXHR.responseJSON.status;
				alert(errorMsg + ":" + textStatus);
			}
		});
	});
	
	// 카드에서 더보기(...) 클릭할 때 삭제될 글 번호를 모달에 넣어준다.
	$('.more-btn').on('click', function() {
		let postId = $(this).data('post-id');
		//alert(postId);
		
		$('#moreModal').data('post-id', postId); // data-post-id="1"
	});
	
	// 모달창 안에 있는 '삭제하기' 글자 클릭
	$('#moreModal #postDeleteBtn').on('click', function(e) {
		e.preventDefault();
		
		let postId = $('#moreModal').data('post-id');
		//alert(postId);
		
		$.ajax({
			type:"DELETE"
			, url:"/post/delete"
			, data: {"postId":postId}
			, success:function(data) {
				if (data.result == "success") {
					location.reload();
				} else {
					alert(data.error_message);
				}
				
			}
			, error:function(e) {
				alert("삭제하는데 실패했습니다. 관리자에게 문의해주세요.");
			}
		});
	});
});
</script>