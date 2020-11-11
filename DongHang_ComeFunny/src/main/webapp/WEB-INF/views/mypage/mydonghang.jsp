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
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mydonghang.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/footer.css" />



<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>

<!-- checkBox 전체 체크  js-->
<script type="text/javascript" src="/resources/js/mypage/mydonghang.js"></script>
<script type="text/javascript">
function visiblemodal() {
	console.log("관리 클릭");	
	$(".overlay").css({
		  visibility: "visible"
		  ,opacity: "1"
	});
	$(".chkOverlay").css({
		  visibility: "hidden"
		  ,opacity: "0"
	});
	
}
function hiddenmodal() {
	$(".overlay").css({
		  visibility: "hidden"
		  ,opacity: "0"
	});
	location.href=window.document.URL;
}

</script>
</head>
<body>

<c:import url="mypage_header.jsp" />


<!-- 본문 -->	
<div class="container" id="myDongHang">
	<div id="dongHangBtn">
		<!-- 나의 동행  -->
		<div id="switchBlock1" onclick="location.href='#'"></div>
		<!--신청한 동행  -->
		<div id="switchBlock2" onclick="location.href='/mypage/applydonghang'"></div>
		<div>
			<img id="myDongHangBtn" alt="나의 동행" src="/resources/image/mypage/myDongHangbtn.png">
		</div>
	</div>
	
	<!-- 나의 동행 관리 테이블 -->
	<div id="donghangform">
		<div id="donghangformTitle">나의 동행 관리</div>
<!-- 		<button id="goBtn" onclick="location.href='/mypage/applydonghang'" style="box-shadow: 4px 4px 4px 1px #00000060 inset;">함께 가요</button> -->
<!-- 		<button id="doBtn" onclick="location.href='/mypage/doapplydonghang'">함께 해요</button> -->
		<button id="deleteBtn" class="deleteGoMyDhBtn" type="button">삭제</button>
	
		<table id="donghangtable" class="table table-hover table-bordered">
			<tr>
				<th style="width: 5%"><input type="checkbox" id="deleteChkAll"/></th>
				<th style="width: 20%">작성일</th>
				<th style="width: 15%">게시판</th>
				<th style="width: 35">제목</th>
				<th style="width: 15%">모집인원</th>
				<th style="width: 10%">신청현황</th>
		
			</tr>
		
			<c:forEach items="${GoMyDhData}" var="mygodh" varStatus="sts">				
				<tr>
					<td style="vertical-align: inherit;"><input type="checkbox" id="mygodhgbno" class="deleteChk" value="${mygodh.gbNo},${mygodh.gbCategory}"/></td>
					<td style="vertical-align: inherit;"><a><fmt:formatDate var="date" value="${mygodh.gbWrittenDate}" pattern="YYYY-MM-dd" />${date}</a></td>
					<c:if test="${mygodh.gbCategory eq '함께가요'}">
	                  <td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/go/goDetail?gbNo=${mygodh.gbNo}">${mygodh.gbCategory}</a></td>
	                  <td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/go/goDetail?gbNo=${mygodh.gbNo}">${mygodh.gbTitle}</a></td>               
	               </c:if>
	               <c:if test="${mygodh.gbCategory eq '함께해요'}">
	                  <td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/do/dodetail?dbNo=${mygodh.gbNo}">${mygodh.gbCategory}</a></td>
	                  <td style="vertical-align: inherit;"><a href="<%= request.getContextPath()%>/do/dodetail?dbNo=${mygodh.gbNo}">${mygodh.gbTitle}</a></td>               
	               </c:if>
					<c:choose>
						<c:when test="${recruitnum[sts.index]eq mygodh.gbRecruitNumber}">
						 	<td style="vertical-align: inherit;"><a id="joinerNum"><span style="color: red;">${recruitnum[sts.index]}</span> / ${mygodh.gbRecruitNumber}</a></td>
						 	<td style="vertical-align: inherit;"></td>					
						</c:when>
						<c:otherwise>
							<td style="vertical-align: inherit;"><a id="joinerNum"><span style="color: #5D7CA6 ;">${recruitnum[sts.index]}</span> / ${mygodh.gbRecruitNumber}</a></td>					
							<td style="vertical-align: inherit;"><button  value="${mygodh.gbNo},${mygodh.gbCategory}"  class="adminBtn btn"  id=gbnobt style="color: #fff;">관리</button></td>
						</c:otherwise>
					
					</c:choose>
					
<%-- 					<td style="vertical-align: inherit;"><button onclick="visiblemodal()" value="${mygodh.gbNo}" class="adminBtn btn" style="color: #fff;">관리</button></td> --%>
<%-- location.href='?cPage=${paging.currentPage}&gbno=${mygodh.gbNo}&#applyAdminPopup' --%>
<%-- 					<td style="vertical-align: inherit; visibility: hidden;"><button value="${mygodh.gbcategory}" id="catebt" class="adminBtn btn" style="color: #fff;">관리</button></td> --%>
<%-- 					onclick="location.href='?cPage=${paging.currentPage}&gbno=${mygodh.gbNo}&#applyAdminPopup'"<!--  --> --%>
				</tr>
			
			</c:forEach>
			
			
		</table>
	</div>
	
	<nav aria-label="Page navigation" style="text-align: center;">
		  <ul class="pagination">
		    <li>
		      <a href="<%= request.getContextPath() %>/mypage/mydonghang" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
		      
		      <c:choose>
		      	<c:when test="${paging.blockStart > 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:when test="${paging.currentPage eq 1 }">
		      		<a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.blockStart}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
		      	</c:when>
		      	
		      	<c:otherwise>
		      		<a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.currentPage-1}" aria-label="Previous">
		        		<span aria-hidden="true">&lt;</span>
		      		</a>
          		 </c:otherwise>
		      </c:choose>
		      
		      <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
         			<li><a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${page}"><span id="pagenum">${page}</span></a></li>
        	  </c:forEach> 
		      
		    </li>
		    
		    <li>
		    	<c:choose>
           			<c:when test="${paging.currentPage eq paging.lastPage }">
               			<a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.blockEnd}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
          			 </c:when>
          		 <c:otherwise>
              			 <a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.currentPage+1}" aria-label="Next">
		       	 			<span aria-hidden="true">&gt;</span>
		      			</a>
         		 </c:otherwise>
          	 	 </c:choose>
		    
		    
		      <a href="<%= request.getContextPath() %>/mypage/mydonghang?cPage=${paging.lastPage}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
		  </ul>
	</nav>
	<div>
	</div>
</div><!-- containerEND  -->

<!-- 동행관리 팝업 -->

<div id="applyAdminPopup" class="overlay">
	<div class="popup">
		<p>신청현황 관리 <small style="color: #ff5858;"> *해당창을 벗어나면 변경사항은 더 이상 수정이 불가능 합니다.</small></p>
		<a class="close" onclick="location.href='/mypage/mydonghang?cPage=${paging.currentPage}'">&times;</a>
<!-- 		<a class="close" onclick="history.go(-1)">&times;</a> -->
		
		
		
		<div class="content">
			<table id="modalTb" class="table table-bordered">
				<tr>
					<th style="width: 30%;">닉네임</th>
					<th style="width: 20%;">나이</th>
					<th style="width: 20%;">성별</th>
					<th style="width: 30%;">신청 관리</th>
				</tr>
				
				<tbody id="tableval">
<%-- 					<c:forEach items="${recruit}" var="recr" varStatus="sts"> --%>
<%-- 						<c:forEach items="${recr}" var="recruits" varStatus="stss"> --%>
					
<!-- 							<tr> -->
<%-- 								<td id="gotoUserInfo">${recruits.UNICK }</td> --%>
<%-- 								<td id="patiAge">${recruits.AGE }</td> --%>
<%-- 								<c:if test="${recruits.UGENDER eq 1}"> --%>
<!-- 									<td id="patiGender">남성</td> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${recruits.UGENDER eq 2}"> --%>
<!-- 									<td id="patiGender">여성</td> -->
<%-- 								</c:if> --%>
								
<%-- 								<c:if test="${recruits.GASTATUS eq 1}"> --%>
<!-- 									<td>수락완료</td> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${recruits.GASTATUS eq 2}"> --%>
<!-- 									<td>거절완료</td> -->
<%-- 								</c:if> --%>
<%-- 								<c:if test="${recruits.GASTATUS eq 0}"> --%>
<!-- 									<td> -->
<!-- 										<button class="agreeBtn" onclick="agree();" style="color: #fff;">수락</button> -->
<!-- 										<button class="refuseBtn" onclick="disagree();" style="color: #fff;">거절</button> -->
<!-- 									</td> -->
<%-- 								</c:if>	 --%>
								
<!-- 							 </tr> -->
<%-- 						 </c:forEach> --%>
<%-- 					 </c:forEach>	 --%>
				</tbody>

			</table>
		</div>

	</div>
</div><!-- applyAdminPopupEND -->

<!-- agreement Modal -->
<div id="agreementPop" class="chkOverlay">
	<div class="chkPopup">
		<h4 style="margin-top: 35px;">정말로 수락하시겠습니까?</h4>
		<a id ="agreebtn" onclick="" class="btn">수락</a>
		<a id="cancelbtn" onclick="visiblemodal();" class="btn">취소</a>
	</div>
</div>
<!-- agreement Modal -->
<div id="agreementPop2" class="chkOverlay">
	<div class="chkPopup">
		<h4 style="margin-top: 35px;">수락이 완료되었습니다.</h4>
		<a id ="agreebtn" onclick="visiblemodal();" class="btn">확인</a>
		
	</div>
</div>



<!-- refuesed Modal -->
<div id="refusedPop" class="chkOverlay">
	<div class="chkPopup">
		<h4 style="margin-top: 35px;">정말로 거절 하시겠습니까?</h4>
		<a id ="agreebtn" onclick="" class="btn refusedbt">거절</a>
		<a id="cancelbtn" onclick="visiblemodal();" class="btn">취소</a>
	</div>
</div>
<div id="refusedPop2" class="chkOverlay">
	<div class="chkPopup">
		<h4 style="margin-top: 35px;">거절 되었습니다.</h4>
		<a id ="agreebtn" onclick="visiblemodal();" class="btn">확인</a>	
	</div>
</div>

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