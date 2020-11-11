<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<!-- CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/fboardlist.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/footer.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" >

<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>

<!-- checkBox 전체 체크  js-->
<script type="text/javascript" src="/resources/js/mypage/mydonghang.js"></script>

</head>
<body>

<c:import url="mypage_header.jsp" />


<!-- 본문 -->	
<div class="container" style="min-height:479px;">
	<div id="myBoardBtn">
		<!-- 자유게시판  -->
		<div id="switchBlock1" onclick="location.href='/mypage/fboardlist'"></div>
		<!-- 후기 게시판 -->
		<div id="switchBlock2" onclick="location.href='/mypage/rboardlist'"></div>
		<!-- 댓글 -->
		<div id="switchBlock3" onclick="location.href='/mypage/commentlist'"></div>
		<div>
			<img id="fboardBtn" alt="나의 동행" src="/resources/image/mypage/rboard.png">
		</div>
	</div>
	
	<!-- 자유게시판 테이블 -->
	<div id="myBoardForm">
		<div id="myBoardFormTitle">후기게시판</div>
		<button id="deleteBtn" class="deleteRboardBtn" type="button">삭제</button>
	
		<table id="myBoardTable" class="table table-hover table-bordered">
			<tr>
				<th style="width: 5%"><input type="checkbox" id="deleteChkAll"/></th>
				<th style="width: 20%">작성일</th>
				<th style="width: 45%">제목</th>
				<th style="width: 10%">추천수</th>
				<th style="width: 10%">조회수</th>
				<th style="width: 10%">댓글수</th>
		
			</tr>			
			<c:forEach items="${rboardData.rlist}" var="rboard">				
				<tr>
					<td style="vertical-align: inherit;"><input type="checkbox" class="deleteChk" value="${rboard.rbNo}"/></td>
					<td style="vertical-align: inherit;"><a><fmt:formatDate var="date" value="${rboard.rbWrittenDate}" pattern="YYYY-MM-dd"/>${date}</a></td>
					<td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/board/reviewview?rbNo=${rboard.rbNo}">${rboard.rbTitle}</a></td>
					<td style="vertical-align: inherit;"><a>${rboard.rbRecommendCnt}</a></td>
					<td style="vertical-align: inherit;"><a>${rboard.rbHitsCnt}</a></td>
					<td style="vertical-align: inherit;"><a>${rboardData.rclist}</a></td>
				</tr>
			
			</c:forEach>
		</table>
	</div>
	
	
	<nav aria-label="Page navigation" style="text-align: center;">
		  <ul class="pagination">
		    <li>
		      <a href="<%= request.getContextPath() %>/mypage/rboardlist" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		      
		      <c:choose>
		      	<c:when test="${paging.blockStart > 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:when test="${paging.currentPage eq 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.blockStart}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:otherwise>
		      		<a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
          		 </c:otherwise>
		      </c:choose>
		      
		      <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
         			<li><a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${page}"><span>${page}</span></a></li>
        	  </c:forEach> 
		      
		    </li>
		    
		    <li>
		    	<c:choose>
           			<c:when test="${paging.currentPage eq paging.lastPage }">
               			<a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.blockEnd}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
          			 </c:when>
          		 <c:otherwise>
              			 <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage+1}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
         		 </c:otherwise>
          	 	 </c:choose>
		    
		    
		      <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.lastPage}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
	</nav>
	
	
<!-- 	<div class="paging" style="text-align: center;">section pagination -->
<%--          <a href="<%= request.getContextPath() %>/mypage/rboardlist" class="nav first" style="display: inline-block; margin: 5px"><i class="fas fa-angle-double-left"><<</i></a> --%>
<%--         <c:choose> --%>
<%--            <c:when test="${paging.blockStart > 1 }"> --%>
<%--                <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage-1}" class="nav prev" style="display: inline-block; margin: 5px"><i class="fas fa-angle-left"><</i></a> --%>
<%--            </c:when> --%>
<%--            <c:when test="${paging.currentPage eq 1 }"> --%>
<%--                <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.blockStart}" class="nav prev" style="display: inline-block; margin: 5px"><i class="fas fa-angle-left"><</i></a> --%>
<%--            </c:when> --%>
<%--            <c:otherwise> --%>
<%--               <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage-1}" class="nav prev" style="display: inline-block; margin: 5px"><i class="fas fa-angle-left"><</i></a> --%>
<%--            </c:otherwise> --%>
<%--         </c:choose> --%>
 
<%--         <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page"> --%>
<%--          <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${page}" class="num active" style="margin: 5px"><span>${page}</span></a> --%>
<%--         </c:forEach>  --%>
        
<%--         <c:choose> --%>
<%--            <c:when test="${paging.currentPage eq paging.lastPage }"> --%>
<%--                <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.blockEnd}" class="nav prev" style="display: inline-block; margin: 5px"><i class="fas fa-angle-right">></i></a> --%>
<%--            </c:when> --%>
<%--            <c:otherwise> --%>
<%--                <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.currentPage+1}" class="nav next" style="display: inline-block; margin: 5px"><i class="fas fa-angle-right">></i></a> --%>
<%--            </c:otherwise> --%>
<%--             </c:choose> --%>
           
<%--            <a href="<%= request.getContextPath() %>/mypage/rboardlist?cPage=${paging.lastPage}" class="nav last" style="display: inline-block; margin: 5px"><i class="fas fa-angle-double-right">>></i></a> --%>
         
<!--          </div>// section pagination -->

</div><!-- containerEND  -->





<!-- 푸터 -->
<div id="footer">
   <ul class="links">
         <li><a href="">서비스소개</a></li>
         <li class="footer_menu"><a href="">이용약관</a></li>
         <li class="footer_menu"><a href=""><strong>개인정보처리방침</strong></a></li>
         <li class="footer_menu"><a href="">채용</a></li>
         <li class="footer_menu"><a href="">고객센터</a></li>
         <li class="footer_menu"><a href="">개발자센터</a></li>
         <li class="footer_menu"><a href=""><strong>ⓒ ComeFunny internet Corp.</strong></a></li>
   </ul>
</div>


</body>

</html>