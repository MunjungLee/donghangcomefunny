<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/boards/main.css">
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



<div class="boardsMain">
	<div class="boardsBar" id="doBoard">
		<a href="/admin/boards/doBoard/list">
		<img src="<%=request.getContextPath() %>/resources/image/admin/doBoard.png" class="boardsImg">
		<br>
		함께해요 게시판
		</a>
	</div>
	<div class="boardsBar" id="goBoard">
		<a href="/admin/boards/goBoard/list">
		<img src="<%=request.getContextPath() %>/resources/image/admin/goBoard.png" class="boardsImg">
		<br>
		함께가요 게시판
		</a>
	</div>
	
<div class="boardsMain">
	<div class="boardsBar" id="freeBoard">
		<a href="/admin/boards/freeBoard/list">
		<img src="<%=request.getContextPath() %>/resources/image/admin/freeBoard.png" class="boardsImg">
		<br>
		자유 게시판
		</a>
	</div>
	<div class="boardsBar" id="reviewBoard">
		<a href="/admin/boards/freeBoard/list">
		<img src="<%=request.getContextPath() %>/resources/image/admin/reviewBoard.png" class="boardsImg">
		<br>
		후기 게시판
		</a>
	</div>	
</div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />  