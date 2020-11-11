<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/boards/reviewBoard/adminReviewBoardList.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

<script type="text/javascript">
$(document).ready(function(){
	// 전체선택 체크박스 클릭
	$("#selAllReviewBoards").click(function(){
		// 전체선택 체크박스가 체크 되어 있을 경우
		if($("#selAllReviewBoards").prop("checked")){
			$(".selReviewBoard").prop("checked", true);
		}
		// 전체선택 체크박스가 체크되어 있지 않을 경우 
		else{
			$(".selReviewBoard").prop("checked", false);
		}
	});
	
	// 체크박스 클릭
	$(".selReviewBoard").click(function(){
		// 전체선택 중, 하나의 체크박스가 체크해제될 경우
		if($("#selAllReviewBoards").prop("checked")){
			$("#selAllReviewBoards").prop("checked", false);
		}
	});
	
	// 체크 삭제버튼을 클릭했을 경우
	$("#deleteSelectReviewBoard").click(function(){
		//  배열선언
		var rbNo = new Array();
		$(".selReviewBoard:checked").each(function(){
			rbNo.push(this.value);
// 			console.log(rbNo);
		});
		
// 		해당 위치로 이동한다
		$(location).attr("href","delete?rbNo="+rbNo);
		
	});
	
	// 퀵 삭제버튼을 클릭했을 경우
	$(".deleteReviewBoard").click(function(){
		var rbNo = $(this).attr('value');
// 		console.log(rbNo);
		$(location).attr("href","delete?rbNo="+rbNo);
		
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

    
<div class="reviewBoardList">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>현재 후기 게시글 목록</caption>
		<thead>
			<tr class="active">
				<th><input type="checkbox" id="selAllReviewBoards"></th>
				<th>게시글번호</th>
				<th>게시글제목</th>
				<th>글쓴이</th>
				<th>작성날짜</th>
				<th>추천수</th>
				<th>찜수</th>
				<th>조회수</th>
				<th>삭제여부</th>
				<th>퀵 버튼</th>
			</tr>
		</thead>
			<c:forEach items="${reviewBoardData.reviewBoardList}" var="reviewBoard" >
		<tbody>
			<tr class="reviewBoardListRow">
				<th><input type="checkbox" class="selReviewBoard" value="${reviewBoard.rbNo}"></th>
				<th>${reviewBoard.rbNo}</th>
				<td><a href="view?rbNo=${reviewBoard.rbNo}">${reviewBoard.rbTitle}</a></td>
				<td>${reviewBoard.rbWriter }</td>
				<td>${reviewBoard.rbWrittenDate}</td>
				<td>${reviewBoard.rbRecommendCnt}</td>
				<td>${reviewBoard.rbLikeCnt}</td>
				<td>${reviewBoard.rbHitsCnt}</td>
				<td>${reviewBoard.rbIsDel}</td>
				<td>
					<button class= "deletereviewBoard" value="${reviewBoard.rbNo}">삭제</button>
				</td>
			</tr>
		</tbody>
			</c:forEach>
	
	</table>
	</div>
	<div class="reviewBoardListToolbar">
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
	<form action="list" method="get" id="reviewBoardListSearch">
	
	<select id="reviewBoardSearch" name="searchKinds">
		<c:if test="${searchKinds eq '' and searchText eq ''}">
			<option value="rbTitle">제목</option>
			<option value="rbWriter">글쓴이</option>
			<option value="rbWrittenDate">작성날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'rbTitle' or searchText eq null}">
			<option value="rbTitle" selected="selected">제목</option>
			<option value="rbWriter">글쓴이</option>
			<option value="rbWrittenDate">작성날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'rbWrittenDate'}">
			<option value="rbTitle">제목</option>
			<option value="rbWriter">글쓴이</option>
			<option value="rbWrittenDate" selected="selected">작성날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'rbWriter'}">
			<option value="rbTitle">제목</option>
			<option value="rbWriter" selected="selected">글쓴이</option>
			<option value="rbWrittenDate">작성날짜</option>
		</c:if>
	</select>
	<input type="text" name="searchText" id="reviewBoardSearchBar" placeholder="검색하기" value="${searchText}">
	<button>검색</button>
	</form>
		<button id="deleteSelectReviewBoard">삭제</button>
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    