<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>

<div class="gnb d-flex justify-content-between">
	<div class="logo d-flex align-items-center">
		<a href="/timeline/timeline_view" class="text-dark" style="text-decoration:none">
			<h1>Jasongram</h1>
		</a>
	</div>
	<div class="login-info">
		<c:if test="${not empty userName}">
		<div class="mt-5 mr-4">
			<span>
			<a href="/profile/profile_view?userId=${userId}" class="text-dark">${userName}</a>님 안녕하세요</span>
			<a href="/user/sign_out" class="font-weight-bold">로그아웃</a>
		</div>
		</c:if>
		<c:if test="${empty userName}">
		<div class="mt-5 mr-4">
			<a href="/user/sign_in_view" class="font-weight-bold">로그인</a>
		</div>
		</c:if>
	</div>
</div>