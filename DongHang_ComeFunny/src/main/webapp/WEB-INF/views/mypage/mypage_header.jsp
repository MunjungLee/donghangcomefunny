<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>
<!-- mypage_header.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" />
<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

</head>
<body>

<div class="body-container">
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
          <div class="dropbtn"><a href="/mypage/profile">내 정보</a></div>
      </div>         
      <div class="dropdown">
           <div class="dropbtn"><a href="/mypage/mydonghang">동행 관리</a></div>
      </div>
      <div class="dropdown">
           <div class="dropbtn"><a href="/mypage/golike">찜목록</a></div>
      </div>
      <div class="dropdown">
           <div class="dropbtn"><a href="/mypage/fboardlist">내가 쓴 글</a></div>
      </div>
      <div class="dropdown">
           <div class="dropbtn"><a href="/mypage/paymentlist">결제내역</a></div>
      </div>
      
   </div>

</div>
</body>
</html>