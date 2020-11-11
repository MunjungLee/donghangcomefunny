<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />



<link rel="stylesheet" href="/resources/css/admin/notice/adminNoticeView.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">
<link rel="stylesheet" href="/resources/css/community/styles.css">

<script type="text/javascript">


$(document).ready(function(){
	   $("#modifyNotice").click(function(){
			var nbNo = $(this).attr('value');
			console.log(nbNo);
			$(location).attr("href","modify?nbNo="+nbNo);
			
			});
	   
	   $("#noticeList").click(function(){
		   history.go(-1);
			});
	   
	   $("#deleteNotice").click(function(){
			var nbNo = $(this).attr('value');
// 			console.log(nbNo);
			$(location).attr("href","delete?nbNo="+nbNo);
			
			});
	   
});
   
   function submitData(url){
      location.href = url;
   } 
   
   function downloadFile(ofname, rfname){
       location.href = "downloadFile?"
            +"ofname="+ofname
            +"&rfname="+rfname;
   }
 
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


	
	<div class = "freeview"> 
	<div class = "freeview__border">
	<div class = "freeview__header">
		<div class = "freeview__header__label">
			<span>공지사항</span>
		</div>
		<span class = "freeview__header__title">상세보기</span>
	</div>
	<div class = "freeview__table">
		<table>
		<tr>
			<td colspan="2"> 
				<div class= "freeview__table__title">
				제목 : &nbsp;
					<span>${viewNotice.nbTitle}</span>
				</div>
			</td>
		</tr>
		<tr >			
			<td colspan="2">
			<div class= "freeview__table__header ">
				<div>관리자 &nbsp; | &nbsp; ${viewNotice.nbWrittenDate}</div>
				<div>조회 &nbsp; : &nbsp; ${viewNotice.nbHitsCnt}</div>
			</div>
			</td>
			
		</tr>
		<tr>
			<td colspan="2">
			<div class= "freeview__table__content">
				${viewNotice.nbContent }
			</div>
			</td>
		</tr>
		
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>업로드된 파일 </span>
			</div>
			</td>
			
		</tr>
		
		<c:forEach items="${viewNoticeFile}" var="noticeFile" varStatus="status">
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>${status.count}. : &nbsp;</span>
				 <a href="javascript:downloadFile('${noticeFile.nfOriginFileName}', '${noticeFile.nfStoredFileName}')">
				 	${noticeFile.nfOriginFileName}</a>
			</div>
			</td>
			
		</tr>
		</c:forEach>

		</table>
		</div>
		
		</div>
		
	<hr>
	<div style="text-align: center;">
		<div>
			<button class="noticeViewToolbar" id="modifyNotice" value="${viewNotice.nbNo}">수정</button>
			<button class="noticeViewToolbar" id="noticeList">목록</button>
			<button class="noticeViewToolbar" id="deleteNotice" value="${viewNotice.nbNo}">삭제</button>
		</div>
	</div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    