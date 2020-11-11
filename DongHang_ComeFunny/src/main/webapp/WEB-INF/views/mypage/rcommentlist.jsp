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
<div class="container" style="min-height: 479px;">
	<div id="myBoardBtn">
		<!-- 자유게시판  -->
		<div id="switchBlock1" onclick="location.href='/mypage/fboardlist'"></div>
		<!-- 후기 게시판 -->
		<div id="switchBlock2" onclick="location.href='/mypage/rboardlist'"></div>
		<!-- 댓글 -->
		<div id="switchBlock3" onclick="location.href='/mypage/commentlist'"></div>
		<div>
			<img id="fboardBtn" alt="나의 동행" src="/resources/image/mypage/comment.png">
		</div>
	</div>
	
	<!-- 자유게시판 테이블 -->
	<div id="myBoardForm">
		<div id="myBoardFormTitle">내가 쓴 댓글</div>
		<button id="fcBtn" onclick="location.href='/mypage/commentlist'">자유게시판</button>
		<button id="rcBtn" onclick="location.href='/mypage/rcommentlist'" style="box-shadow: 4px 4px 4px 1px #00000060 inset;">후기게시판</button>
		<button id="deleteBtn" class="deleteRcboardBtn" type="button">삭제</button>
	
		<table id="myBoardTable" class="table table-hover table-bordered">
			<tr>
				<th style="width: 5%"><input type="checkbox" id="deleteChkAll"/></th>
				<th style="width: 30%">작성일</th>
				<th style="width: 65%">댓글내용</th>
		
			</tr>
			<c:forEach items="${rcboardData.rclist}" var="rcboard">				
				<tr>
					<td style="vertical-align: inherit;"><input type="checkbox" class="deleteChk" value="${rcboard.rcNo}"/></td>
					<td style="vertical-align: inherit;"><a><fmt:formatDate var="date" value="${rcboard.rcWrittenDate}" pattern="YYYY-MM-dd HH:mm:ss"/>${date}</a></td>
					<td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/board/reviewview?rbNo=${rcboard.rcRbNo}">${rcboard.rcContent}</a></td>
				</tr>
			
			</c:forEach>
			
		</table>
	</div>
	
	<nav aria-label="Page navigation" style="text-align: center;">
		  <ul class="pagination">
		    <li>
		      <a href="<%= request.getContextPath() %>/mypage/rcommentlist" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		      
		      <c:choose>
		      	<c:when test="${paging.blockStart > 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:when test="${paging.currentPage eq 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.blockStart}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:otherwise>
		      		<a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
          		 </c:otherwise>
		      </c:choose>
		      
		      <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
         			<li><a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${page}"><span>${page}</span></a></li>
        	  </c:forEach> 
		      
		    </li>
		    
		    <li>
		    	<c:choose>
           			<c:when test="${paging.currentPage eq paging.lastPage }">
               			<a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.blockEnd}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
          			 </c:when>
          		 <c:otherwise>
              			 <a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.currentPage+1}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
         		 </c:otherwise>
          	 	 </c:choose>
		    
		    
		      <a href="<%= request.getContextPath() %>/mypage/rcommentlist?cPage=${paging.lastPage}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
	</nav>
	

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