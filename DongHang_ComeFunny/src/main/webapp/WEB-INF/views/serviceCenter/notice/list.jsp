<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/serviceCenterHeader.jsp" />

<link rel="stylesheet" href="/resources/css/admin/notice/adminNoticeList.css">

    
<div class="noticeList" style="min-hegiht:500px;">
    
	<div style="text-align-last: center;">
	<table class="table table-bordered table-hover">
		<caption>공지사항 목록</caption>
		<thead>
			<tr class="active">
				<th>공지사항번호</th>
				<th>공지사항제목</th>
				<th>작성날짜</th>
				<th>조회수</th>
			</tr>
		</thead>
			<c:forEach items="${noticeData.noticeList}" var="notice" >
		<tbody>
			<tr class="noticeListRow">
				<th>${notice.nbNo}</th>
				<td><a href="view?nbNo=${notice.nbNo}">${notice.nbTitle}</a></td>
				<td>${notice.nbWrittenDate}</td>
				<td>${notice.nbHitsCnt}</td>
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
	</div>


</div>
<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    