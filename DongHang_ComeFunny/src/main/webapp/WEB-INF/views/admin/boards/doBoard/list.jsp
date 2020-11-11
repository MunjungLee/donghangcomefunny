<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/boards/doBoard/adminDoBoardList.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">




<script type="text/javascript">
$(document).ready(function(){
	// 전체선택 체크박스 클릭
	$("#selAllDoBoards").click(function(){
		// 전체선택 체크박스가 체크 되어 있을 경우
		if($("#selAllDoBoards").prop("checked")){
			$(".selDoBoard").prop("checked", true);
		}
		// 전체선택 체크박스가 체크되어 있지 않을 경우 
		else{
			$(".selDoBoard").prop("checked", false);
		}
	});
	
	// 체크박스 클릭
	$(".selDoBoard").click(function(){
		// 전체선택 중, 하나의 체크박스가 체크해제될 경우
		if($("#selAllDoBoards").prop("checked")){
			$("#selAllDoBoards").prop("checked", false);
		}
	});
	
	// 체크 삭제버튼을 클릭했을 경우
	$("#deleteSelectDoBoard").click(function(){
		//  배열선언
		var dbNo = new Array();
		$(".selDoBoard:checked").each(function(){
			dbNo.push(this.value);
// 			console.log(dbNos);
		});
		
// 		해당 위치로 이동한다
		$(location).attr("href","delete?dbNo="+dbNo);
		
	});
	
	// 퀵 삭제버튼을 클릭했을 경우
	$(".deleteDoBoard").click(function(){
		var dbNo = $(this).attr('value');
// 		console.log(dbNos);
		$(location).attr("href","delete?dbNo="+dbNo);
		
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




    
<div class="doBoardList">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>현재 함께해요 게시글 목록</caption>
		<thead>
			<tr class="active">
				<th><input type="checkbox" id="selAllDoBoards"></th>
				<th>게시글번호</th>
				<th>게시글제목</th>
				<th>글쓴이</th>
				<th>작성날짜</th>
				<th>모집여부</th>
				<th>삭제여부</th>
				<th>퀵 버튼</th>
			</tr>
		</thead>
			<c:forEach items="${doBoardData.doBoardList}" var="doBoard" >
		<tbody>
			<tr class="doBoardListRow">
				<th><input type="checkbox" class="selDoBoard" value="${doBoard.dbNo}"></th>
				<th>${doBoard.dbNo}</th>
				<td><a href="view?dbNo=${doBoard.dbNo}">${doBoard.dbTitle}</a></td>
				<td>${doBoard.dbWriter }</td>
				<td>${doBoard.dbWrittenDate}</td>
				<td>${doBoard.dbRecruitStatus}</td>
				<td>${doBoard.dbIsDel}</td>
				<td>
					<button class= "deleteDoBoard" value="${doBoard.dbNo}">삭제</button>
				</td>
			</tr>
		</tbody>
			</c:forEach>
	
	</table>
	</div>
	<div class="doBoardListToolbar">
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
	<form action="list" method="get" id="doBoardListSearch">
	
	<select id="doBoardSearch" name="searchKinds">
		<c:if test="${searchKinds eq '' and searchText eq ''}">
			<option value="dbTitle">제목</option>
			<option value="dbWriter">글쓴이</option>
			<option value="dbWrittenDate">작성날짜</option>
			<option value="dbRecruitStatus">모집상태</option>
		</c:if>
		<c:if test="${searchKinds eq 'dbTitle' or searchText eq null}">
			<option value="dbTitle" selected="selected">제목</option>
			<option value="dbWriter">글쓴이</option>
			<option value="dbWrittenDate">작성날짜</option>
			<option value="dbRecruitStatus">모집상태</option>
		</c:if>
		<c:if test="${searchKinds eq 'dbWrittenDate'}">
			<option value="dbTitle">제목</option>
			<option value="dbWriter">글쓴이</option>
			<option value="dbWrittenDate" selected="selected">작성날짜</option>
			<option value="dbRecruitStatus">모집상태</option>
		</c:if>
		<c:if test="${searchKinds eq 'dbWriter'}">
			<option value="dbTitle">제목</option>
			<option value="dbWriter" selected="selected">글쓴이</option>
			<option value="dbWrittenDate">작성날짜</option>
			<option value="dbRecruitStatus">모집상태</option>
		</c:if>
		<c:if test="${searchKinds eq 'dbRecruitStatus'}">
			<option value="dbTitle">제목</option>
			<option value="dbWriter">글쓴이</option>
			<option value="dbWrittenDate">작성날짜</option>
			<option value="dbRecruitStatus" selected="selected">모집상태</option>
		</c:if>
	</select>
	<input type="text" name="searchText" id="doBoardSearchBar" placeholder="검색하기" value="${searchText}">
	<button>검색</button>
	</form>
		<button id="deleteSelectDoBoard">삭제</button>
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    