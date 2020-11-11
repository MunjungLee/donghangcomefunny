<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/user/adminUserView.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

<script type="text/javascript">


$(document).ready(function(){
	$("#deleteUser").click(function(){
		var uNo = $(this).attr('value');
		$(location).attr("href","delete?uNo="+uNo);
		});
	
	$("#modifyUser").click(function(){
		var uNo = $(this).attr('value');
		$(location).attr("href","modify?uNo="+uNo);
		});
	
	$("#userList").click(function(){
		   history.go(-1);
		});
	
	
});	
	

$(function() {

	  var UI = {
	    init: function() {
	      this.quickMenuFn();
	      this.topBtn();
	    },

	    initialize: function() {
	      this.id = {
	        target: {
	          quick: '.rightQuickBar',
	          stickyTop: '#footer'
	        },
	        topBtnClass: 'btn_top'
	      };
	      this.init();
	    },

	    quickMenuFn: function() {
	      var quick = $(this.id.target.quick);
	      var qTop = parseInt(quick.css('top'));

	      $(window).scroll(function() {
	        var winTop = $(window).scrollTop();

	        quick.stop().animate({
	          top: winTop + qTop
	        }, 400);

	      })
	    },

	    topBtn: function() {
	      var btnLocation = $('.' + this.id.topBtnClass);
	      var timerId = 0;

	      $(window).on('scroll', function() {
	        var winTop = $(window).scrollTop();
	        if (winTop > 200) {
	          btnLocation.fadeIn();
	          clearInterval(timerId);
	          timerId = setInterval(btnEffet, 2000);
	        } else {
	          btnLocation.fadeOut();
	          clearInterval(timerId);
	        }

	      });

	      function btnEffet() {
	        btnLocation.fadeTo('300', 0.3).fadeTo('300', 1);
	      }

	      this.scrollTop(btnLocation);
	    },

	    scrollTop: function(eTarget, speed) {
	      var speed = speed || null;
	      eTarget.on('click', function() {
	        $('html, body').animate({
	          scrollTop: $("body").offset().top
	        }, speed)
	      })
	    }

	  };

	  $(function() {
	    UI.initialize();
	  })

	})
	

</script>


<div class="rightQuickBar">
    	<ul class="mainMenu">
    		<li><a href="/admin/user/list">회원관리</a></li>
    		<li><a href="/admin/boards/main">게시판 관리</a></li>
    		<li><a href="/admin/question/list">1대1문의 관리</a></li>
    		<li><a href="/admin/notice/list">공지사항 관리</a></li>
    		<li><a href="/admin/order/list">결제 관리</a></li>
    	</ul>
    </div>
    
      <p class="btn_top"><a href="#none">top</a></p>


<div class="userView">
		<table class="userInfoTable" border="1">
		<caption>회원 상세정보</caption>
		<tr>
			<td>아이디</td>
			<td><span>${viewUser.userId}</span></td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td>${viewUser.uPw}</td>
		</tr>
		<tr>
			<td>이름</td>
			<td>${viewUser.uName}</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td>${viewUser.uBirth}</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>${viewUser.uGender}</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td>${viewUser.uNick}</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td>${viewUser.uPhone}</td>
		</tr>
		<tr>
			<td>메일</td>
			<td>${viewUser.uMail}</td>
		</tr>
		<tr>
			<td>주소</td>
			<td>${viewUser.uAddress}</td>
		</tr>
		<tr>
			<td>동행복권수</td>
			<td>${viewUser.uDhtCnt}</td>
		</tr>
		<tr>
			<td>가입날짜</td>
			<td>${viewUser.uRegDate}</td>
		</tr>
		<tr>
			<td>탈퇴여부</td>
			<td>${viewUser.uIsLeave}</td>
		</tr>
	</table>
	<c:choose>
		<c:when test="${userImg ne null}">
			<img src="<%=request.getContextPath() %>/resources/upload/${userImg.ufStoredFileName}" alt="프로필사진" class="img-responsive center-block" id="userImage">
		</c:when>
		<c:when test="${userImg eq null}">
			<img class="img-responsive center-block" src="<%=request.getContextPath() %>/resources/image/admin/Kkami.jpg" alt="기본사진입니다." id="userImage">
		</c:when>
	</c:choose>
	
	<hr>
	<div style="text-align: center;">
		<div>
			<button class="userViewToolbar" id="modifyUser" value="${viewUser.uNo}" >수정</button>
			<button class="userViewToolbar" id="userList">목록</button>
			<button class="userViewToolbar" id="deleteUser" value="${viewUser.uNo}">삭제</button>
		</div>
	</div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    