<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />    
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>  
<script src="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

<script type="text/javascript">

// 	    function callFunction(){
// 		console.dir('clicekd');
		

// 		var confirm_val = confirm("해당 후기게시글 조회 시 동행복권 1장이 소모됩니다.");
// 		console.dir(confirm_val);
// 		if(confirm_val){
			// 여기에 세션회원인지 아닌지 글쓴이가 조회쿼리 필요
// 		} else {
// 			location.href='javascript:history.go(0)';
// 		}
		
	}

</script>
<div class = "reviewlist"> 
	<div class = "reviewlist__header">
		<div class = "reviewlist__header__label">
			<span>Community</span>
		</div>
		<span class = "reviewlist__header__title">후기게시판</span>
	
	</div>
	<div class = "reviewlist__table">
		<table>
		<tr>
			<th>글번호</th>
			<th>글제목</th>
			<th>작성자</th>
			<th>작성일</th>
			<th>추천수</th>
			<th>조회수</th>
		</tr>
			<c:forEach items="${reviewData.flist }" var="review">
			<tr>
				<td>${review.RBNO}</td>
				<td><a href="javascript:void(0)"onclick="location.href = '<%=request.getContextPath() %>/board/reviewview?rbNo=${review.RBNO}'; return false;" class="reveiwView"> ${review.RBTITLE }</a></td>
				<td>${review.UNICK }</td>
				<td><fmt:formatDate var="dateMMDD" value="${review.RBWRITTENDATE }" pattern="MM-dd"/>
					${dateMMDD }</td>
				<td>${review.RBRECOMMENDCNT }</td>
				<td>${review.RBHITSCNT }</td>
			</tr>
			</c:forEach>
		</table>
	</div>
	<div class="reviewlist__button">
		<button class ="reviewlist__button__write" type="button" onclick="location.href='/board/reviewwrite'">글쓰기</button>
	</div>
	
	<nav class = "text-center">
		<ul class="pagination">
			<c:choose>
				<c:when test="${searchKinds eq null || searchText eq null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewlist" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewlist?cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewlist?cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewlist?cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'uNick' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>				
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'rbTitle' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'rbContent' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/reviewlist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
			</c:choose>
		</ul>
	</nav>
	
	<form class="form-inline col-lg-offset-4 col-lg-6" action="/board/reviewlistSearch" method="post">
	  <div class="form-group">
	      <div class="input-group">
	      		<select class="form-control" id="searchKinds" name="searchKinds">
					<option value="rbTitle">제목</option>
					<option value="rbContent">내용</option>
					<option value="uNick">글쓴이</option>
				</select>
		  </div>
		  <div class="input-group">
	      	<input type="text" class="form-control" name="searchText" id="searchText" aria-label="...">
	      </div>
	      <div class="input-group">
	      	<button class="btn btn-default" type="submit" id="searchList">&ensp;&ensp;<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&ensp;&ensp;</button>
	      </div>
	    </div>
	</form>

	
	
</div>
<script type="text/javascript">

// $(document).ready(function () {

// 	 $("#searchList").on("click", function () {
//          var searchKinds = $("#searchKinds").val();
//          var searchText = $("#searchText").val();
//          console.dir(searchKinds);
//          console.dir(searchText);
         
// 	 });

// 	});


</script>
	
	
	


<c:import url="/WEB-INF/views/board/boardfooter.jsp" />
