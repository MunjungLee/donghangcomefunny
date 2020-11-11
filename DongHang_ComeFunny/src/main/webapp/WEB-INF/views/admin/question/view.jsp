<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />


<link rel="stylesheet" href="/resources/css/community/styles.css">
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
   
   function submitData(url){
      location.href = url;
   } 
   
   function downloadFile(ofname, rfname){
       location.href = "downloadFile?"
            +"ofname="+ofname
            +"&rfname="+rfname;
   }
   
   $(document).ready(function(){
   $("#adminAnswerModify").click(function(){
		var qbNo = ${viewQuestion.QBNO};
		console.log(qbNo);
		$(location).attr("href","modifyAnswer?qbNo="+qbNo);
		
		});
   
   
   $("#adminAnswerWrite").click(function(){
		var qbNo = ${viewQuestion.QBNO};
		console.log(qbNo);
		$(location).attr("href","writeAnswer?qbNo="+qbNo);
		
		});
	
   if(${viewQuestion.QBSTATUS} == 1){
   $("#adminAnswerDelete").click(function(){
		var abNo = ${viewQuestion.ABNO}+"";
		console.log(abNo);
		$(location).attr("href","deleteAnswer?abNo="+abNo);
		
		});
   }
});
   

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
			<span>문의글</span>
		</div>
		<span class = "freeview__header__title">상세보기</span>
	</div>
	<div class = "freeview__table">
		<table>
		<tr>
			<td colspan="2"> 
				<div class= "freeview__table__title">
				제목 : &nbsp;
					<span>${viewQuestion.QBTITLE}</span>
				</div>
			</td>
		</tr>
		<tr >			
			<td colspan="2">
			<div class= "freeview__table__header ">
				<div>${viewQuestion.UNICK} &nbsp; | &nbsp; ${viewQuestion.QBWRITTENDATE}</div>
			</div>
			</td>
			
		</tr>
		<tr>
			<td colspan="2">
			<div class= "freeview__table__content">
				${viewQuestion.QBCONTENT }
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
		
		<c:forEach items="${viewQuestionFile}" var="questionFile" varStatus="status">
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>${status.count}. : &nbsp;</span>
				 <a href="javascript:downloadFile('${questionFile.qfOriginFileName}', '${questionFile.qfStoredFileName}')">
				 	${questionFile.qfOriginFileName}</a>
			</div>
			</td>
			
		</tr>
		</c:forEach>

		</table>
		</div>
		</div>
		</div>

	<hr>
	<c:choose>
		<c:when test="${viewQuestion.QBSTATUS ne 1 }">
			<h2>답변 대기중입니다.</h2>
		</c:when>
			
		<c:when test="${viewQuestion.QBSTATUS eq 1 }">
			<div class = "freeview"> 
	<div class = "freeview__border">
	<div class = "freeview__header">
		<div class = "freeview__header__label">
			<span>답장</span>
		</div>
		<span class = "freeview__header__title">상세보기</span>
	</div>
	<div class = "freeview__table">
		<table>
		<tr>
			<td colspan="2"> 
				<div class= "freeview__table__title">
				제목 : &nbsp;
					<span>${viewQuestion.ABTITLE}</span>
				</div>
			</td>
		</tr>
		<tr >			
			<td colspan="2">
			<div class= "freeview__table__header ">
				<div>관리자  &nbsp; | &nbsp; ${viewQuestion.ABWRITTENDATE}</div>
			</div>
			</td>
			
		</tr>
		<tr>
			<td colspan="2">
			<div class= "freeview__table__content">
				${viewQuestion.ABCONTENT }
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
		
		<c:forEach items="${viewAnswerFile}" var="answerFile" varStatus="status">
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>${status.count}. : &nbsp;</span>
				 <a href="javascript:downloadFile('${answerFile.afOriginFileName}', '${answerFile.afStoredFileName}')">
				 	${answerFile.afOriginFileName}</a>
			</div>
			</td>
			
		</tr>
		</c:forEach>

		</table>
		</div>
		
		</div>
		</div>
		</c:when>
	</c:choose>
	
	
	
	
	
	<hr>
	<div style="text-align: center;">
		<div>
			<c:choose>
				<c:when test="${viewQuestion.QBSTATUS eq 0}">
			<button class="adminQuestionViewToolbar" id="adminAnswerWrite">작성</button>
			<button class="adminQuestionViewToolbar" id="adminQuestionList">목록</button>
				</c:when>
				
				<c:when test="${viewQuestion.QBSTATUS eq 1}">
			<button class="adminQuestionViewToolbar" id="adminAnswerModify">수정</button>
			<button class="adminQuestionViewToolbar" id="adminQuestionList">목록</button>
			<button class="adminQuestionViewToolbar" id="adminAnswerDelete">삭제</button>
				</c:when>
			</c:choose>
		</div>
	</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    