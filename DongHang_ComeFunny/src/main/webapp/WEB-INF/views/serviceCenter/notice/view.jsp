<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/serviceCenterHeader.jsp" />



<link rel="stylesheet" href="/resources/css/admin/notice/adminNoticeView.css">

<script type="text/javascript">


$(document).ready(function(){
	   $("#noticeList").click(function(){
		   history.go(-1);
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
 
 
    	</script>
	
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
			<button class="noticeViewToolbar" id="noticeList">목록</button>
		</div>
	</div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    