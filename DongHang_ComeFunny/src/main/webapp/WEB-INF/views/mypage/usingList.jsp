<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/payment.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/footer.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" >

<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>

<!-- checkBox 전체 체크  js-->
<script type="text/javascript" src="/resources/js/mypage/mydonghang.js"></script>
<script type="text/javascript">
function showPopup(){
	var popupWidth = 900;
	var popupHeight = 600;
	var popupX = (window.screen.width / 2) - (popupWidth / 2);
	var popupY= (window.screen.height / 2) - (popupHeight / 2);
	window.open("/payment/paypage", "userSearch", "width=900, height=600, left="+popupX+", top="+popupY); }

</script>
</head>
<body>

<c:import url="mypage_header.jsp" />


<!-- 본문 -->	
<div class="container">

	
	<!-- 결제리스트 테이블 -->
	<div id="myPaymentList">
		<div id="paymentBtn">
			<!-- 나의 동행 복권  -->
			<div id="switchBlock1" onclick="location.href='/mypage/paymentlist'"></div>
			<!-- 복권 구매 내역  -->
			<div id="switchBlock2" onclick="location.href='/mypage/usingList'"></div>
			<div>
				<img id="myDongHangBtn" alt="나의 동행" src="/resources/image/mypage/ticketUsingList.png">
			</div>
		</div>
	
	
		<div id="myPaymentTitle">나의 동행복권</div>
		<div id="ticketBox">
			<img id="ticket" alt="나의 동행" src="/resources/image/mypage/coupon.png"/>
			<div id="reserveTicket">보유중인 동행복권 <p id="reserveTicketNum">${usingData.tkCnt}</p> 장</div>
			<button id="chargeBtn" type="button" onclick="showPopup()">충전</button>
		</div>		
		
		<div id="myPaymentTitle">복권사용 내역</div>
		
		<table id="mypaymentTable" class="table">
		
			<tr>
				<th style="width: 5%"><input type="checkbox" id="deleteChkAll"/></th>
				<th style="width: 20%">구매 일자</th>
				<th style="width: 25%">구분</th>
				<th style="width: 25%">사용 갯수</th>
				<th style="width: 25%">잔여 수량</th>
		
			</tr>
			<c:forEach items="${usingData.ulist}" var="ticket">				
				<tr>
					<td style="vertical-align: inherit;"><input type="checkbox" class="deleteChk" value="${ticket.dhtNo}"/></td>
					<td style="vertical-align: inherit;"><a>${ticket.dhtUsedDate}</a></td>
					<td style="vertical-align: inherit;"><a>후기 보기</a></td>
					<td style="vertical-align: inherit;"><a>1 장</a></td>
					<td style="vertical-align: inherit;"><a>${usingData.tkCnt} 장</a></td>
				</tr>
			</c:forEach>
		</table>
	</div>
		<nav aria-label="Page navigation" style="text-align: center;">
		  <ul class="pagination">
		    <li>
		      <a href="<%= request.getContextPath() %>/mypage/usingList" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		      
		      <c:choose>
		      	<c:when test="${paging.blockStart > 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:when test="${paging.currentPage eq 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.blockStart}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:otherwise>
		      		<a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
          		 </c:otherwise>
		      </c:choose>
		      
		      <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
         			<li><a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${page}"><span>${page}</span></a></li>
        	  </c:forEach> 
		      
		    </li>
		    
		    <li>
		    	<c:choose>
           			<c:when test="${paging.currentPage eq paging.lastPage }">
               			<a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.blockEnd}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
          			 </c:when>
          		 <c:otherwise>
              			 <a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.currentPage+1}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
         		 </c:otherwise>
          	 	 </c:choose>
		    
		    
		      <a href="<%= request.getContextPath() %>/mypage/usingList?cPage=${paging.lastPage}" aria-label="Next">
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