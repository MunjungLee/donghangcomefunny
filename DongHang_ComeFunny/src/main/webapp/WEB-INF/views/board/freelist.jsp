<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />   
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>  
<script src="/resources/bower_components/bootstrap/dist/js/bootstrap.min.js"></script>
<!-- <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous"> -->
<!-- <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script> -->
<!-- <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script> -->
<!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script> -->
<div class = "freelist"> 


	<div class = "freelist__header">
		<div class = "freelist__header__label">
			<span>Community</span>
		</div>
		<span class = "freelist__header__title">자유게시판</span>
	
	</div>
		<div class = "freelist__table">
			<table>
			<tr>
				<th>글번호</th>
				<th>글제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
				
			</tr>
			<c:forEach items="${freeData.flist }" var="free">
			<tr>
				<td>${free.FBNO}</td>
				<td><a href="<%=request.getContextPath() %>/board/freeview?fbNo=${free.FBNO }">${free.FBTITLE }</a></td>
				<td>${free.UNICK }</td>
				<td><fmt:formatDate var="dateMMDD" value="${free.FBWRITTENDATE }" pattern="MM-dd"/>
					${dateMMDD }</td>
				<td>${free.FBHITSCNT }</td>
			</tr>
			</c:forEach>
			</table>
		</div>
	<div class="freelist__button">
		<button class ="freelist__button__write" type="button" onclick="location.href='/board/freewrite'">글쓰기</button>
	</div>
	<nav class = "text-center">
		<ul class="pagination">

			<c:choose>
				<c:when test="${searchKinds eq null || searchText eq null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/freelist" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/freelist?cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/freelist?cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/freelist?cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/freelist?cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/freelist?cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/freelist?cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/freelist?cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'uNick' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>				
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'fbTitle' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
				<c:when test="${searchKinds eq 'fbContent' && searchText ne null}">
					<li>
						<a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }" aria-label="Previous">
							<span aria-hidden="true"><i class="fas fa-angle-double-left"></i></span>
						</a>
					</li>					
					<c:choose>	
						<c:when test="${paging.currentPage > 1 }">
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage-1}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"> <i class="fas fa-angle-left"></i> </a></li>
						</c:otherwise>
					</c:choose>
						
					<c:forEach begin="${paging.blockStart }" end="${paging.blockEnd }" var="page">
						<c:choose>
							<c:when test="${paging.currentPage eq page}">
								<li class="active"><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:when>
							<c:otherwise>
								<li><a href="<%=request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${page}"><span>${page}</span></a></li>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:choose>
						<c:when test="${paging.currentPage eq paging.lastPage }">
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage}"><i class="fas fa-angle-right"></i></a></li>
						</c:when>
						<c:otherwise>
							<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.currentPage+1}"><i class="fas fa-angle-right"></i></a></li>
						</c:otherwise>
					</c:choose>
					<li><a href="<%= request.getContextPath() %>/board/freelist?searchKinds=${searchKinds }&searchText=${searchText }&cPage=${paging.lastPage }" aria-label="Next"><i class="fas fa-angle-double-right"></i></a></li>
				</c:when>
			</c:choose>
		</ul>
	</nav>
	
	<form class="form-inline col-lg-offset-4 col-lg-6" action="/board/freelistSearch" method="post">
	  <div class="form-group">
	      <div class="input-group">
	      		<select class="form-control" id="searchKinds" name="searchKinds">
					<option value="fbTitle">제목</option>
					<option value="fbContent">내용</option>
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