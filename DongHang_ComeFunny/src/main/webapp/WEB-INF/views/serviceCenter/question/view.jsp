<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/serviceCenterHeader.jsp" />

<link rel="stylesheet" href="/resources/css/serviceCenter/questionView.css">
<script type="text/javascript">

$(document).ready(function() {
	  $("#modifyQuestion").click(function(){
			var qbNo = $(this).attr('value');
			$(location).attr("href","modify?qbNo="+qbNo);
			
			});
	   
	   $("#questionList").click(function(){
		   history.go(-1);
			});
	   
	   $("#deleteQuestion").click(function(){
			var qbNo = $(this).attr('value');
			$(location).attr("href","delete?qbNo="+qbNo);
			
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
			<button class="questionViewToolbar" id="modifyQuestion" value="${viewQuestion.QBNO}">수정</button>
			<button class="questionViewToolbar" id="questionList">목록</button>
			<button class="questionViewToolbar" id="deleteQuestion" value="${viewQuestion.QBNO}">삭제</button>
				</c:when>
				
				<c:when test="${viewQuestion.QBSTATUS eq 1}">
			<button class="questionViewToolbar" id="deleteQuestion" value="${viewQuestion.QBNO}">삭제</button>
			<button class="questionViewToolbar" id="questionList">목록</button>
				</c:when>
			</c:choose>
		</div>
	</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    