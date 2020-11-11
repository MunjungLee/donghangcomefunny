<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<!-- styles.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/community/styles.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/community/mail.css" />
 
<!-- jQuery -->
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script> -->

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="/resources/bower_components/bootstrap/dist/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<!-- <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script> -->

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


<!-- semantic ui -->
<%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/semantic/semantic.min.css"> --%>
<%-- <script src="<%=request.getContextPath() %>/resources/css/semantic/semantic.min.js"></script> --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta charset="UTF-8">
<title>동행 :: 커뮤니티</title>
</head>
<body>
<div class="body-container">
	<!-- logo -->
	<div>
	   <div class="logo">
	      <div class="logo-img">
	      <a href="/"><img class="logo-img" alt="로고이미지" src="/resources/image/header/logo.png" ></a>
	      </div>
	      <c:if test="${empty logInInfo}">
	      
			<div class="main_login">		
				<a href="/user/login">로그인</a> &ensp;
				<a href="/user/join">회원가입</a>
			</div>
          </c:if>
          <c:if test="${not empty logInInfo}">
			<div class="main_login">		
				<a href="/message/receivelist"><i class="fas fa-envelope"></i> &nbsp;</a>	
				<a href="javascript:void(0)" style="cursor: default;">${logInInfo.userId }&nbsp;님 환영합니다.</a> &ensp;
				<a href="/mypage/profile"><i class="fas fa-user-circle"></i>&nbsp;마이페이지</a>  &ensp;
				<a href="/user/logout"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a>
			</div>
          </c:if>
          
		</div>
	</div>
		
  	<!-- 메뉴바 -->
	<div class="main_menu">
		<div class="dropdown">
	 		<div class="dropbtn"><a href="/go">함께가요</a></div>
		</div>			
		<div class="dropdown">
	  		<div class="dropbtn"><a href="/do">함께해요</a></div>
		</div>
		<div class="dropdown">
	  		<div class="dropbtn"><a href="#">커뮤니티</a></div>
	 	 	<div class="dropdown-content">
	    		<a href="/board/freelist">자유게시판</a>
	    		<a href="/board/reviewlist">후기게시판</a>
	 	 	</div>
		</div>
		<div class="dropdown">
	  		<div class="dropbtn"><a href="#">고객센터</a></div>
	  		<div class="dropdown-content">
	    		<a href="/serviceCenter/notice/list">공지사항</a>
	    		<a href="/serviceCenter/question/list">문의게시판</a>
	  		</div>
		</div>
		<div class="dropdown">
	  		<div class="dropbtn"><a href="/chat/chat">실시간채팅</a></div>
		</div>
	</div>
</div>




