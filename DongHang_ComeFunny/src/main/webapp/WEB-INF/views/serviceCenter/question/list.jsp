<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:import url="/WEB-INF/views/admin/layout/serviceCenterHeader.jsp" />

<link rel="stylesheet" href="/resources/css/serviceCenter/questionList.css">

<script type="text/javascript">

$(document).ready(function(){
	   $("#writeQuestion").click(function(){
		   $(location).attr("href","write");
			});
	   
});
	
	

</script>

    
<div class="qeustionBoardList" style="min-height: 500px;">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>문의글 목록</caption>
		<thead>
			<tr class="active">
				<th>비밀글</th>
				<th>문의글번호</th>
				<th>문의글제목</th>
				<th>글쓴이</th>
				<th>작성날짜</th>
				<th>답장여부</th>
			</tr>
		</thead>
			<c:forEach items="${questionData.questionList}" var="questionList" >
		<tbody>
			<tr class="qeustionBoardListRow">
				<c:choose>
					<c:when test="${loginInfo.uNo ne questionList.qbUNo}">
						<th>비밀글</th>
					</c:when>
					<c:otherwise>
						<th></th>
					</c:otherwise>
				</c:choose>
				<th>${questionList.qbNo}</th>
				<td><a href="view?qbNo=${questionList.qbNo}">${questionList.qbTitle}</a></td>
				<td>${questionList.qbWriter}</td>
				<td>${questionList.qbWrittenDate}</td>
				<c:choose>
					<c:when test="${questionList.qbStatus eq 0}">
						<td>답변대기중</td>
					</c:when>
					<c:when test="${questionList.qbStatus eq 1}">
						<td>답변완료</td>
					</c:when>
				</c:choose>
			</tr>
		</tbody>
			</c:forEach>
	
	</table>
	</div>
	<div class="qeustionBoardListToolbar">
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
	<form action="list" method="get" id="qeustionBoardListSearch">
	
	<select id="qeustionBoardSearch" name="searchKinds">
		<c:if test="${searchKinds eq '' and searchText eq ''}">
			<option value="qbTitle">제목</option>
			<option value="qbWriter">글쓴이</option>
			<option value="qbWrittenDate">작성날짜</option>
			<option value="qbStatus">답장여부</option>
		</c:if>
		<c:if test="${searchKinds eq 'qbTitle' or searchText eq null}">
			<option value="qbTitle" selected="selected">제목</option>
			<option value="qbWriter">글쓴이</option>
			<option value="qbWrittenDate">작성날짜</option>
			<option value="qbStatus">답장여부</option>
		</c:if>
		<c:if test="${searchKinds eq 'qbWrittenDate'}">
			<option value="qbTitle">제목</option>
			<option value="qbWriter">글쓴이</option>
			<option value="qbWrittenDate" selected="selected">작성날짜</option>
			<option value="qbStatus">답장여부</option>
		</c:if>
		<c:if test="${searchKinds eq 'qbWriter'}">
			<option value="qbTitle">제목</option>
			<option value="qbWriter" selected="selected">글쓴이</option>
			<option value="qbWrittenDate">작성날짜</option>
			<option value="qbStatus">답장여부</option>
		</c:if>
		<c:if test="${searchKinds eq 'dbRecruitStatus'}">
			<option value="dbTitle">제목</option>
			<option value="dbWriter">글쓴이</option>
			<option value="dbWrittenDate">작성날짜</option>
			<option value="qbStatus" selected="selected">답장여부</option>
		</c:if>
	</select>
	<input type="text" name="searchText" id="qeustionBoardSearchBar" placeholder="검색하기" value="${searchText}">
	<button>검색</button>
	</form>
		<button id="writeQuestion">작성</button>
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    