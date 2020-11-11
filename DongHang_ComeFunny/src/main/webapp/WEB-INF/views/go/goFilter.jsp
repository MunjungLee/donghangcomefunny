<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 함께가요</title>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/go/go.css" />

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
      
      <!-- 정렬 혹은 필터처리된 리스트 -->
      <div id="gobest">
      
      <!-- 이부분 반복 -->
      <c:forEach items="${list.glist }" var="go">
      
      <div class="gobest">
         <div class="gobest-title">
            <div class="goprofile ialign">
            <span aria-hidden="true"></span>
            <a href="/go/goDetail?gbNo=${go.GBNO }"> <!-- 사진 클릭시 이동 -->
               <c:if test="${go.UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                   <img src="<%=request.getContextPath() %>/resources/upload/default.png" alt="공백" class="img-circle" />
               </c:if>
               <c:if test="${go.UFSTOREDFILENAME ne null}">
                  <img src="<%=request.getContextPath() %>/resources/upload/${go.UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
               </c:if>
            </a>
            </div>
            <div class="ialign marginleft">
               <div class="godate">
               [ 
                  <c:choose>
                        <c:when test="${go.GBRECRUITDATE eq '1' }" >1월에서 3월사이</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '2' }" >4월에서 6월사이</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '3' }" >7월에서 9월사이</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '4' }" >10월에서 12월사이</c:when>
                       </c:choose>
               ]
               </div>
               <div class="goname"> ${go.UNICK } 
               <small>
               <c:choose>
                        <c:when test="${go.GBRECRUITAREA eq 'seoul' }" >서울</c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'daegu' }" >대구 </c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${go.GBRECRUITAREA eq 'gyang' }" >광주</c:when>
                    </c:choose>
               </small></div>
               <div class="gotitle">
                  ${go.GBTITLE}
               </div>
            </div>
         </div>
         <div class="margintop">
            <div class="gothemebox"><span>
             <c:set var="keyword" value="${fn:split(go.AGECHECK,',')}"></c:set>
                   <c:forEach items="${keyword}" var="age">
                      <span>${age }</span>
               </c:forEach>
                 <span>
            <c:set var="keyword" value="${fn:split(go.THEMECHECK,',')}"></c:set>
            <c:forEach items="${keyword}" var="theme">
                <c:choose>
                     <c:when test="${theme eq 'food' }" ><span> · </span> 음식</c:when>
                     <c:when test="${theme eq 'photo' }" ><span> · </span> 사진</c:when>
                     <c:when test="${theme eq 'seeing' }" ><span> · </span> 관광</c:when>
                     <c:when test="${theme eq 'drink' }" ><span> · </span> 술</c:when>
                     <c:when test="${theme eq 'shopping' }" ><span> · </span> 쇼핑</c:when>
                     <c:when test="${theme eq 'etc' }" ><span> · </span>기타</c:when>
                   </c:choose>
            </c:forEach>
                 </span>
                 <span> · </span>
                 <c:choose>
                     <c:when test="${go.GBRECRUITGENDER eq 0 }" >성별 무관</c:when>
                     <c:when test="${go.GBRECRUITGENDER eq 1 }" >남성만</c:when>
                     <c:when test="${go.GBRECRUITGENDER eq 2 }" >여성만</c:when>
                 </c:choose>  
                 </span> 
             </div>
             
            <div class="gothemebox">${go.GBLIKECNT }명이 찜하고 있습니다</div>
            <div>
            <span>
            <c:choose>
                     <c:when test="${go.GBRECRUITSTATUS eq 0 }" ><span class="gotag">모집중</span></c:when>
                     <c:when test="${go.GBRECRUITSTATUS eq 1 }" ><span class="gotag2">모집마감</span></c:when>
                 </c:choose>  
            </span>
<%--                <span><img class="goheart" onclick="likeheart(${go.GBNO})" style="cursor:pointer" src="/resources/image/go/heart.png" /></span> --%>
            </div>  <!-- 하트 색 변경 작동 시키기 -->
         </div>
      </div>
      </c:forEach>
      
      <!-- 반복끝나고 마지막에 출력하는거 -->
      <div class="gofinish">
         <div class="gobest-title">
            <div class="ialign marginleft">
               <div class="gottile">
                  <span class="">찾으시는 동행이 없나요?</span><br>
                  <span>동행모집하기</span>
               </div>
               <div class="goarrow">
                  <a class="none" href="/go/goform"><span class="glyphicon glyphicon-arrow-right"></span></a>
               </div>
            </div>
         </div>
      </div>
      
      </div>

</div>
</body>
</html>