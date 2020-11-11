<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/user/adminUserModify.css">
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
		$(location).attr("href","list");
		});
	
	$("#userSubmit").click(function(){
		$("#userModifyForm").submit();
	})
	
	$("#userCencle").click(function(){
		history.go(-1);
	})
	
	$("#userChangeImg").click(function(){
		$("#imgUpload").click();
	})
	
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
    

<div class="userModify">
	<c:set value="${viewUser}" var="viewUser"/>
	<form action="modifyImpl" method="post" enctype="multipart/form-data" id="userModifyForm">
	<input type="text" name="uNo" value="${viewUser.uNo}" hidden="">
	<table class="userInfoTable" border="1">
		<caption>회원 상세정보</caption>
		<tr>
			<th>정보</th>
			<th>수정해주세요</th>
		<tr>
			<td>아이디</td>
			<td><input type="text" name="userId" value="${viewUser.userId}">
			</td>
		</tr>
		<tr>
			<td>비밀번호</td>
			<td><input type="text" name="uPw" value="${viewUser.uPw}">
			</td>
		</tr>
		<tr>
			<td>이름</td>
			<td><input type="text" name="uName" value="${viewUser.uName}">
			</td>
		</tr>
		<tr>
			<td>생년월일</td>
			<td><input type="text" name="uBirth" value="${viewUser.uBirth}">
			</td>
		</tr>
		<tr>
			<td>성별</td>
			<td>
			<c:choose>
			<c:when test="${viewUser.uGender eq 0}">
				<input type="radio" id="man"  name="uGender" value="0" checked="checked">
				<label for="man">남자</label>
				<input type="radio" id="woman" name="uGender" value="1">
				<label for="woman" >여자</label>
			</c:when>
			<c:when test="${viewUser.uGender eq 1}">
				<input type="radio" id="man"  name="uGender" value="0">
				<label for="man">남자</label>
				<input type="radio" id="woman" name="uGender" value="1" checked="checked">
				<label for="woman" >여자</label>
			</c:when>
			</c:choose>
			</td>
		</tr>
		<tr>
			<td>닉네임</td>
			<td><input type="text" name="uNick" value="${viewUser.uNick}">
			</td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="uPhone" value="${viewUser.uPhone}">
			</td>
		</tr>
		<tr>
			<td>메일</td>
			<td><input type="text" name="uMail" value="${viewUser.uMail}">
			</td>
		</tr>
		<tr>
			<td>주소</td>
			<td><input type="text" name="uAddress" value="${viewUser.uAddress}">
			</td>
		</tr>
		<tr>
			<td>동행복권수</td>
			<td><input type="text" name="uDhtCnt" value="${viewUser.uDhtCnt}">
			</td>
		</tr>
		<tr>
			<td>탈퇴여부</td>
			<td>
			<c:choose>
			<c:when test="${viewUser.uIsLeave eq 0}">
				<input type="radio" id="nout" name="uIsLeave" value="0" checked="checked">
				<label for="nout">활동중</label>
				<input type="radio" id="out" name="uIsLeave" value="1" >
				<label for="out">탈퇴</label>
			</c:when>
			<c:when test="${viewUser.uIsLeave eq 1}">
				<input type="radio" id="nout" name="uIsLeave" value="0" >
				<label for="nout">활동중</label>
				<input type="radio" id="out" name="uIsLeave" value="1" checked="checked">
				<label for="out">탈퇴</label>
			</c:when>
			</c:choose>
			</td>
		</tr>
	</table>
	</form>
	<div style ="
		    float: right;
		    position: absolute;
		    left: 1200px;
		    top: 120px;
		    text-align: center;">
	<c:choose>
		<c:when test="${userImg ne null}">
			<img src="<%=request.getContextPath() %>/resources/upload/${userImg.ufStoredFileName}" alt="프로필사진" class="img-responsive center-block" id="userImage">
		</c:when>
		<c:when test="${userImg eq null}">
			<img class="img-responsive center-block" src="<%=request.getContextPath() %>/resources/image/admin/Kkami2.jpg" alt="기본사진입니다." id="userImage">
		</c:when>
	</c:choose>
		<br>
		<button class="userViewToolbar" id="userChangeImg">사진 변경</button>
				<input id ="imgUpload" type="file" name="userImg" form="userModifyForm">
	</div>
	<hr><br><br>
	<div style="text-align: center;">
		<div>
			<button class="userModifyToolbar" id="userSubmit">수정</button>
			<button class="userModifyToolbar" id="userCencle">삭제</button>
		</div>
	</div>
</div>








<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    