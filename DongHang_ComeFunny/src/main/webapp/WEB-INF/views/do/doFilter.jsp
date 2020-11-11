<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 함께해요</title>
<!-- do.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/do/do.css" />

<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


</head>
<body>
<div>
		<div id="dobest">
		
		<!-- 이부분 반복 -->
		<c:forEach items="${list.dlist}" var="db">
		<div class="dobest">
			<div class="doprofile">
			<a href="/do/dodetail?dbNo=${db.DBNO}">
				<c:if test="${db.DISTOREDIMGNAMESTOREDIMG eq null}"> <!-- 사진이 null이면 default -->
    					<img src="<%=request.getContextPath() %>/resources/image/do/default2.jpg" alt="대표사진" />
				</c:if>
				<c:if test="${db.DISTOREDIMGNAMESTOREDIMG ne null}"> <!-- 사진이 null이면 아니면 -->
    					<img src="<%=request.getContextPath() %>/resources/upload/${db.DISTOREDIMGNAMESTOREDIMG}" alt="대표사진"  />
				</c:if>
			</a>
			</div>
			
			<div class="dobest-title">
				<div class="ialign">
					<div class="doname">
						<c:choose>
			               <c:when test="${db.DBRECRUITAREA eq 'seoul' }" >서울 </c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'jeju' }" >제주</c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'incheon' }" >인천</c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'daegu' }" >대구</c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'busan' }" >부산</c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'daejeon' }" >대전</c:when>
			               <c:when test="${db.DBRECRUITAREA eq 'gyang' }" >광주</c:when>
			            </c:choose>
						 <small>
						 <c:set var="keyword" value="${fn:split(db.THEMECHECK,',')}"></c:set>
							<c:forEach items="${keyword}" var="theme">
			    				<c:choose> 
			                     <c:when test="${theme eq 'food' }" >맛집 </c:when>
			                     <c:when test="${theme eq 'activity' }" >액티비티 </c:when>
			                     <c:when test="${theme eq 'meseum' }" >전시/박물관 </c:when>
			                     <c:when test="${theme eq 'etc' }" >기타 </c:when>
			            	 	</c:choose>
							</c:forEach>
						 </small>
					</div>
					<div class="dotitle">${db.DBTITLE}</div>
					<div class="margintop">
						<div>
						<span>
							<c:set var="keyword" value="${fn:split(db.AGECHECK,',')}"></c:set>
							<c:forEach items="${keyword}" var="age">
			    				<c:choose> 
			                     <c:when test="${age eq '20' }" >20 </c:when>
			                     <c:when test="${age eq '30' }" >30 </c:when>
			                     <c:when test="${age eq '40' }" >40 </c:when>
			            	 	</c:choose>
							</c:forEach>
						</span> 
						· 
						<span>
						<c:choose> 
			              <c:when test="${db.DBRECRUITGENDER eq 0}" >성별 무관 </c:when>
			              <c:when test="${db.DBRECRUITGENDER eq 1}" >남성만 </c:when>
			              <c:when test="${db.DBRECRUITGENDER eq 2}" >여성만 </c:when>
			            </c:choose>
						</span> 
						· 
						<span>회비 </span><span>${db.DBRECRUITCOST}원</span> </div>
						<div></div>
						<div>${db.DBLIKECNT} 명이 찜하고 있습니다</div>
						<div class="dobox">
						<c:choose>
                     		<c:when test="${db.DBRECRUITSTATUS eq 0 }" ><span class="gotag">모집중</span></c:when>
                     		<c:when test="${db.DBRECRUITSTATUS eq 1 }" ><span class="gotag2">모집마감</span></c:when>
                		</c:choose> 
<!-- 						<span class="goheart"><img src="/resources/image/do/heart.png" alt="찜하트"/></span> -->
						</div>
					</div>  
				</div>
			</div>
		</div>
		</c:forEach>
		
		
		<!-- 반복끝나고 마지막에 출력하는거 -->
		<div class="dofinish">
			<div class="dobest-title">
				<div class="ialign marginleft">
					<div class="dottile">
						<span>원하는 활동이 없나요?</span><br>
						<span>내가 인원모집하기</span>
					</div>
					<div class="doarrow">
						<a class="none" href="/do/doform"><span class="glyphicon glyphicon-arrow-right"></span></a>
					</div>
				</div>
			</div>
		</div>
		
		</div>
</div>
</body>
</html>