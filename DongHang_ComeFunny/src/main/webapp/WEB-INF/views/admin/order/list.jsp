<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/boards/doBoard/adminDoBoardList.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">




<script type="text/javascript">
	
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
		<caption>현재 결제내역 목록</caption>
		<thead>
			<tr class="active">
				<th>결제번호</th>
				<th>주문명</th>
				<th>결제자</th>
				<th>결제날짜</th>
			</tr>
		</thead>
			<c:forEach items="${orderList.orderList}" var="orderList" >
		<tbody>
			<tr class="doBoardListRow">
				<th>${orderList.pONo}</th>
				<td><a href="view?pONo=${orderList.pONo}">${orderList.oName}</a></td>
				<td>${orderList.buyer}</td>
				<td>${orderList.oDate}</td>
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
			<option value="buyer">구매자</option>
			<option value="oName">주문명</option>
			<option value="oDate">결제날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'buyer' or searchText eq null}">
			<option value="buyer" selected="selected">구매자</option>
			<option value="oName">주문명</option>
			<option value="oDate">결제날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'oName'}">
			<option value="buyer">구매자</option>
			<option value="oName" selected="selected">주문명</option>
			<option value="oDate">결제날짜</option>
		</c:if>
		<c:if test="${searchKinds eq 'oDate'}">
			<option value="buyer">구매자</option>
			<option value="oName">주문명</option>
			<option value="oDate" selected="selected">결제날짜</option>
		</c:if>
	</select>
	<input type="text" name="searchText" id="doBoardSearchBar" placeholder="검색하기" value="${searchText}">
	<button>검색</button>
	</form>
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    