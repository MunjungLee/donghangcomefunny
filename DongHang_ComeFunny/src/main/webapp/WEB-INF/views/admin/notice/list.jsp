<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/notice/adminNoticeList.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">


<script type="text/javascript">
$(document).ready(function(){
	// 전체선택 체크박스 클릭
	$("#selAllNotices").click(function(){
		// 전체선택 체크박스가 체크 되어 있을 경우
		if($("#selAllNotices").prop("checked")){
			$(".selNotice").prop("checked", true);
		}
		// 전체선택 체크박스가 체크되어 있지 않을 경우 
		else{
			$(".selNotice").prop("checked", false);
		}
	});
	
	// 체크박스 클릭
	$(".selNotice").click(function(){
		// 전체선택 중, 하나의 체크박스가 체크해제될 경우
		if($("#selAllNotices").prop("checked")){
			$("#selAllNotices").prop("checked", false);
		}
	});
	
	// 체크 삭제버튼을 클릭했을 경우
	$("#deleteSelectNotice").click(function(){
		//  배열선언
		var nbNo = new Array();
		$(".selNotice:checked").each(function(){
			nbNo.push(this.value);
// 			console.log(nbNos);
		});
		
// 		해당 위치로 이동한다
		$(location).attr("href","delete?nbNo="+nbNo);
		
	});
	
	// 퀵 삭제버튼을 클릭했을 경우
	$(".deleteNotice").click(function(){
		var nbNo = $(this).attr('value');
// 		console.log(nbNo);
		$(location).attr("href","delete?nbNo="+nbNo);
		
		});
	
	// 퀵 수정 버튼을 클릭했을 경우
	$(".modifyNotice").click(function(){
		var nbNo = $(this).attr('value');
// 		console.log(nbNo)
		$(location).attr("href","modify?nbNo="+nbNo)
	});
	
	// 작성 버튼을 클릭했을 경우
	$("#writeNotice").click(function(){
		$(location).attr("href","write")
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


    
<div class="noticeList">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>현재 공지사항 목록</caption>
		<thead>
			<tr class="active">
				<th><input type="checkbox" id="selAllNotices"></th>
				<th>공지사항번호</th>
				<th>공지사항제목</th>
				<th>작성날짜</th>
				<th>조회수</th>
				<th>삭제여부</th>
				<th>퀵 버튼</th>
			</tr>
		</thead>
			<c:forEach items="${NoticeData.noticeList}" var="notice" >
		<tbody>
			<tr class="noticeListRow">
				<th><input type="checkbox" class="selNotice" value="${notice.nbNo}"></th>
				<th>${notice.nbNo}</th>
				<td><a href="view?nbNo=${notice.nbNo}">${notice.nbTitle}</a></td>
				<td>${notice.nbWrittenDate}</td>
				<td>${notice.nbHitsCnt}</td>
				<td>${notice.nbIsDel}</td>
				<td><button class= "modifyNotice" value="${notice.nbNo}">수정</button>
					<button class= "deleteNotice" value="${notice.nbNo}">삭제</button>
				</td>
			</tr>
		</tbody>
			</c:forEach>
	
	</table>
	</div>
	<div class="noticeListToolbar">
	<ul class="pagination" style="text-align: center; display: inline;">
	    <li>
	      <a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=1" aria-label="Previous">
	        <span aria-hidden="true"><<</span>
	      </a>
	      <c:choose>
	      	<c:when test="${paging.currentPage > paging.blockStart }">
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
	    <li><a href="list?searchKinds=${searchKinds}&searchText=${searchText}&cPage=${paging.currentPage}">${page}</a></li>
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
	<form action="list" method="get" id="noticeListSearch">
	
	<select id="noticeSearch" name="searchKinds">
		<c:if test="${searchKinds eq '' and searchText eq ''}">
			<option value="nbTitle">제목</option>
			<option value="nbWrittenDate">작성날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'nbTitle' or searchText eq null}">
			<option value="nbTitle" selected="selected">제목</option>
			<option value="nbWrittenDate">작성날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'nbWrittenDate'}">
			<option value="nbTitle">제목</option>
			<option value="nbWrittenDate" selected="selected">작성날짜</option>
		</c:if>
	</select>
	<input type="text" name="searchText" id="noticeSearchBar" placeholder="검색하기" value="${searchText}">
	<button>검색</button>
	</form>
		<button id="writeNotice">작성</button>
		<button id="deleteSelectNotice">삭제</button>
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    