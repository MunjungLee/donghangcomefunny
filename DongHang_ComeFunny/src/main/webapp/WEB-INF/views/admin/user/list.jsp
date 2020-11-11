<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/user/adminUserList.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

<script type="text/javascript">
$(document).ready(function(){
	// 전체선택 체크박스 클릭
	$("#selAllUsers").click(function(){
		// 전체선택 체크박스가 체크 되어 있을 경우
		if($("#selAllUsers").prop("checked")){
			$(".selUser").prop("checked", true);
		}
		// 전체선택 체크박스가 체크되어 있지 않을 경우 
		else{
			$(".selUser").prop("checked", false);
		}
	});
	
	// 체크박스 클릭
	$(".selUser").click(function(){
		// 전체선택 중, 하나의 체크박스가 체크해제될 경우
		if($("#selAllUsers").prop("checked")){
			$("#selAllUsers").prop("checked", false);
		}
	});
	
	// 체크 삭제버튼을 클릭했을 경우
	$("#deleteSelectUser").click(function(){
		// selUsers 배열선언
		var uNos = new Array();
		$(".selUser:checked").each(function(){
			uNos.push(this.value);
// 			console.log(selUnos);
		});
		
// 		해당 위치로 이동한다
		$(location).attr("href","delete?uNo="+uNos);
		
	});
	
	// 퀵 삭제버튼을 클릭했을 경우
	$(".deleteUser").click(function(){
		var uNos = $(this).attr('value');
// 		console.log(delUno);
		$(location).attr("href","delete?uNo="+uNos);
		
		});
	
	// 퀵 수정 버튼을 클릭했을 경우
	$(".modifyUser").click(function(){
		var uNo = $(this).attr('value');
// 		console.log(modiUno)
		$(location).attr("href","modify?uNo="+uNo)
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
    
    
    
    
<div class="userList">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>현재 가입중인 회원의 목록</caption>
		<thead>
			<tr class="active">
				<th><input type="checkbox" id="selAllUsers"></th>
				<th>회원번호</th>
				<th>회원아이디</th>
				<th>회원닉네임</th>
				<th>회원이름</th>
				<th>가입날짜</th>
				<th>탈퇴여부</th>
				<th>퀵 버튼</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${userData.userList}" var="user" varStatus="userStatus">
			<tr class="userListRow">
				<td><input type="checkbox" class="selUser" value="${user.uNo}" name="uNo"></td>
				<td>${user.uNo}</td>
				<td>
				<a href="view?uNo=${user.uNo}">
				${user.userId}
				</a>
				</td>
				<td>${user.uNick}</td>
				<td>${user.uName}</td>
				<td>${user.uRegDate}</td>
				<c:choose>
				<c:when test="${user.uIsLeave eq 0}">
				<td></td>
				</c:when>
				<c:when test="${user.uIsLeave eq 1}">
				<td>대기중</td>
				</c:when>
				</c:choose>
				<td><button class= "modifyUser" value="${user.uNo}">수정</button>
					<button class= "deleteUser" value="${user.uNo}">삭제</button>
				</td>
			</tr>
				</c:forEach>
		</tbody>
	
	</table>
	</div>
	<div class="userListToolbar">
	<ul class="pagination" style="text-align: center; display: inline;">
	    <li>
	      <a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=1" aria-label="Previous">
	        <span aria-hidden="true"><<</span>
	      </a>
	      <c:choose>
	      	<c:when test="${paging.currentPage >= paging.blockStart && paging.currentPage ne 1}">
			   	<a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.currentPage-1}" aria-label="Previous">
		        <span aria-hidden="true"><</span>
			   	</a>
	      	</c:when>
	      	<c:when test="${paging.currentPage eq 1 }">
		      	<a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.currentPage}" aria-label="Previous">
		        <span aria-hidden="true"><</span>
		      	</a>
	      	</c:when>
	      </c:choose>
	     </li>
	     <c:forEach var="page" begin="${paging.blockStart}" end="${paging.blockEnd}">
	    <li><a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${page}">${page}</a></li>
	     </c:forEach>
	    <li>
	    <c:choose>
	      	<c:when test="${paging.blockEnd+1 > paging.lastPage}">
			   	<a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.currentPage}" aria-label="Previous">
		        <span aria-hidden="true">></span>
			   	</a>
	      	</c:when>
	      	<c:otherwise>
		      	<a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.currentPage+1}" aria-label="Previous">
		        <span aria-hidden="true">></span>
		      	</a>
	      	</c:otherwise>
	      </c:choose>
	      <a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.lastPage}" aria-label="Next">
	        <span aria-hidden="true">>></span>
	      </a>
	    </li>
	  </ul>
	 
	<form action="list" method="get" id="userListSearch">
	 <!-- 제이쿼리 이용해서 기본값을 검색한 값으로 설정하기 -->
		 	<select id="userSearch" name="searchKinds" >
		 		<c:if test="${searchKinds eq '' and searchText eq ''}">
					<option value="userId" >아이디</option>
					<option value="userName">이름</option>
					<option value="userNick">닉네임</option> 
		 		</c:if>
		 		<c:if test="${searchKinds eq 'userId' or searchText eq null}">
					<option value="userId" selected="selected">아이디</option>
					<option value="userName">이름</option>
					<option value="userNick">닉네임</option> 
		 		</c:if>
		 		<c:if test="${searchKinds eq 'userName'}">
		 			<option value="userId" >아이디</option>
					<option value="userName" selected="selected">이름</option>
					<option value="userNick">닉네임</option> 
				</c:if>
				<c:if test="${searchKinds eq 'userNick'}">
					<option value="userId" >아이디</option>
					<option value="userName">이름</option>
					<option value="userNick" selected="selected">닉네임</option>  
				</c:if>
			</select>
				<input type="text" name="searchText" id="searchText" placeholder= "검색하기" value="${searchText }">
			<button>검색</button>
	</form>
		<button id="deleteSelectUser">삭제</button>
	</div>
	

</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    