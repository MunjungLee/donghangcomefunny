<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/community/styles.css" />
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

 

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"> </script>
 
<script type="text/javascript">
//<form>이 submit되면
//스마트 에디터 내용을 <textarea>반영해주는 함수
function submitContents(elClickedObj) {
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["abContent"].exec("UPDATE_CONTENTS_FIELD", []);

	try {
		elClickedObj.form.submit(); // <form> submit 수행
	} catch(e) {}
}

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


<script type="text/javascript">
$(document).ready(function() {
	
	//작성버튼 동작
	$("#btnWrite").click(function() {

		// 스마트에디터의 내용을 <textarea>에 적용
		submitContents( $("#btnWrite") );
		
		// form submit
		$("form").submit();
	});
	
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
<div class = "freewrite"> 
	<div class = "freewrite__border">
	<div class = "freewrite__header">
		<div class = "freewrite__header__label">
			<span>답변</span>
		</div>
		<span class = "freewrite__header__title">글쓰기</span>
	</div>
	<div class = "freewrite__table">
		<form action="writeAnswerImpl" method="post" enctype="multipart/form-data">
		<input type="hidden" value="${viewQuestion.QBNO}" name= "abQbNo">
		<table>
		<tr>
			<td>제목</td>
			<td>
			
				<input type="text" class="form-control" name = "abTitle" placeholder="제목을 입력하세요.">
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<div><span>${adminLoginInfo.aName}</span></div>
			</td>
		</tr>
		<tr>			
			<td colspan="2">본문</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea id="abContent" name="abContent" style="width: 100%;"></textarea>
			</td>
		</tr>
		<tr>			
			<td>파일업로드</td>
			<td><input type="file" name="answerFiles" multiple/></td>
		</tr>
		<tr>			
			<td colspan="2" class="freewrite__button">
				<button class ="freewrite__button__write" type="submit" id="btnWrite">작성하기</button>
			</td>
		</tr>
		</table>
		</form>
	</div>
	
	
</div>	
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "abContent", // 에디터가 적용되는 <textarea>의 id
	sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
	fCreator: "createSEditor2",
	htParams: {
		bUseToolbar: true, //툴바 사용여부
		bUseVerticalResizer: false, //입력창 크기 조절 바
		bUseModeChanger: true //글쓰기 모드 탭
	}
	
});
</script>




<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />  


