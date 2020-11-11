<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/header.css" />

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">

<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<!-- Ionicons -->
<link rel="stylesheet" href="/resources/bower_components/Ionicons/css/ionicons.min.css">
<!-- iCheck -->
<link rel="stylesheet" href="/resources/plugins/iCheck/square/blue.css">
<%--lightbox--%>
<link rel="stylesheet" href="/resources/bower_components/lightbox/css/lightbox.css">
<!-- Theme style -->
<link rel="stylesheet" href="/resources/dist/css/AdminLTE.min.css">
<!-- AdminLTE Skins. We have chosen the skin-blue for this starter
      page. However, you can choose any other skin. Make sure you
      apply the skin class to the body tag so the changes take effect. -->
<link rel="stylesheet" href="/resources/dist/css/skins/skin-blue.min.css">
<%--fileupload--%>
<link rel="stylesheet" media="screen" href="/resources/bower_components/fileupload/css/jasny-bootstrap.min.css">

<link rel="stylesheet" href="/resources/css/admin/adminHeader.css">



<meta charset="UTF-8">
<title>동행 :: 관리자페이지</title>
</head>

<body>


<!-- 헤더 -->
<div id="header">
   <!-- 로고 -->
   <div class="logo">
      <div class="logo-img"><a href="/admin/main"><img class="logo-img" alt="로고이미지" src="<%=request.getContextPath() %>/resources/image/header/logo.png"></a></div>
      <div id="mainMessage" style="display: inline-block">관리자 모드</div>
          <c:if test="${not empty adminLoginInfo}">
			<div class="main_login">		
				<a href="javascript:void(0)" style="cursor: default;"><i class="fas fa-user-secret"></i>&nbsp; ${adminLoginInfo.aName }&nbsp;님 환영합니다.</a> &ensp;
				<a href="/admin/logout"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a>
			</div>
          </c:if>
   </div>
</div>






