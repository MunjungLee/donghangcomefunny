<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/community/styles.css" />
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<link rel="stylesheet" href="/resources/bower_components/bootstrap/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/bower_components/bootstrap/dist/css/bootstrap-theme.min.css">
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
</head>
<script type="text/javascript">

$(document).ready(function () {

	 $("#searchDHList").on("click", function () {
         var searchDHcategory = $("#searchDHcategory").val();
         var searchKeyword = $("#searchKeyword").val();
         console.dir(searchDHcategory);
         console.dir(searchKeyword);
         
	 });

	});
function selectTitle(e) {
	var data = document.querySelectorAll(".click");
	var gbNo = document.querySelectorAll(".gbNoClass");
	var gbCategory = document.querySelectorAll(".gbCategoryClass");
	console.dir(gbNo[e].value);
	console.dir(data[e].innerText);
	console.dir(gbCategory[e].value);
	window.opener.sendMeData(gbNo[e].value, data[e].innerText, gbCategory[e].value);
	window.close();
}


</script>
<body>
<div class = "reviewfinddh"> 
	<div class = "reviewfinddh__header">
		<div class = "reviewfinddh__header__label">
			<span>Community</span>
		</div>
		<span class = "reviewfinddh__header__title">동행찾기</span>
	
	</div>
	<div class = "reviewfinddh__table">
		<table>
		<tr>
			<th>카테고리</th>
			<th>동행 제목</th>
			<th>동행 호스트</th>
		</tr>
			<c:forEach items="${donghangData.flist }" var="donghang" varStatus="status">
			<tr onclick="selectTitle(${status.index})">
				<td>
				<input type="hidden" class="gbCategoryClass" name="gbCategory" id="gbCategory" value="${donghang.GBCATEGORY}"/>
				<input type="hidden" class="gbNoClass" name="gbNo" id="gbNo" value="${donghang.GBNO}"/>
				${donghang.GBCATEGORY}</td>
				<td><a href="#" class="click">
				<span>${donghang.GBTITLE }</span></a></td>
				<td>${donghang.UNICK }</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	
	<nav class = "text-center">
		<ul class="pagination">
			<c:choose>
				<c:when test="${searchKinds eq null || searchText eq null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewfinddh" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewfinddh?cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'uNick' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>				
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'rbTitle' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'rbContent' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewfinddh?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
			</c:choose>
		</ul>
	</nav>
	<form class="form-inline col-xs-offset-2" action="/board/reviewfinddhSearch" method="post">
		  <div class="form-group">
		      <div class="input-group">
		      		<select class="form-control" name="searchDHcategory" id="searchDHcategory" >
						<option value="gbTitle">제목</option>
						<option value="uNick">호스트</option>
					</select>
			  </div>
			  <div class="input-group reviewfinddh__input">
		      	<input type="text" class="form-control" name="searchKeyword" id="searchKeyword" aria-label="...">
		      </div>
		      <div class="input-group">
		      	<button class="btn btn-default" type="submit" id="searchDHList" onclick="">&ensp;&ensp;<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&ensp;&ensp;</button>
		      </div>
		    </div>
	</form>
</div>


</body>
</html>