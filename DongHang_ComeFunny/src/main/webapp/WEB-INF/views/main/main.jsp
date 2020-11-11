<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 메인페이지</title>

<!-- main.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/main/main.css" />

<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">



<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- jQuery-backstretch -->
<script type="text/javascript" src="<%=request.getContextPath() %>/resources/js/main/jquery.backstretch.js"></script>
<script>
$(document).ready(function() {
   $.backstretch([ //body > #main-search로 js변경 
      "/resources/image/main/south-korea-3625168_1280.jpg" 
      ,"/resources/image/main/sunset-3664096_1280.jpg"
      ,"/resources/image/main/korea-2777849_1280.jpg"
      ,"/resources/image/main/busan-night-scene-1747130_1280.jpg"
      ,"/resources/image/main/han-river-3804298_1280.jpg"
      
   ], {duration: 2000, fade: 750});
});
</script>
  
</head>
<body>
<div class="main-container">

   <!-- header -->
   <!-- 로고 -->
   <div>
      <div class="logo">
         <div class="logo-img">
         <a href="/"><img class="logo-img" alt="로고이미지" src="/resources/image/header/logo.png" ></a>
         </div>
         <c:if test="${empty logInInfo}">
         <div class="main_login">      
            <a href="/user/login">로그인</a> &ensp;
            <a href="/user/join">회원가입</a>
         </div>
          </c:if>
          <c:if test="${not empty logInInfo}">
			<div class="main_login">		
				<a href="/message/receivelist"><i class="fas fa-envelope"></i> &nbsp;</a>	
				<a href="javascript:void(0)" style="cursor: default;">${logInInfo.userId }&nbsp;님 환영합니다.</a> &ensp;
				<a href="/mypage/profile"><i class="fas fa-user-circle"></i>&nbsp;마이페이지</a>  &ensp;
				<a href="/user/logout"><i class="fas fa-sign-out-alt"></i>&nbsp;로그아웃</a>
			</div>
          </c:if>  
      </div>
   </div>
   
   <!-- 메뉴바 -->
   <div class="main_menu">
      <div class="dropdown">
          <div class="dropbtn"><a href="/go">함께가요</a></div>
      </div>         
      <div class="dropdown">
           <div class="dropbtn"><a href="/do">함께해요</a></div>
      </div>
      <div class="dropdown">
           <div class="dropbtn">커뮤니티</div>
           <div class="dropdown-content">
             <a href="/board/freelist">자유게시판</a>
             <a href="/board/reviewlist">후기게시판</a>
           </div>
      </div>
      <div class="dropdown">
           <div class="dropbtn">고객센터</div>
           <div class="dropdown-content">
	    		<a href="/serviceCenter/notice/list">공지사항</a>
	    		<a href="/serviceCenter/question/list">문의게시판</a>
           </div>
      </div>
      <div class="dropdown">
           <div class="dropbtn"><a href="/chat/chat">실시간채팅</a></div>
      </div>
   </div>
   
   <!-- content1 -->
   <!-- 상단검색창 -->
   <div id="main-search">
      <div class="searchmenubox">
         <ui class="searchmenu">
         <!-- 함께가요 -->
         <li>
            <input type="radio" name="tabmenu" id="tabmenu1" checked/>
            <div class="tapbtn"><label for="tabmenu1">함께가요</label></div>
            
            <div class="searchbox">
            <p>함께 떠나볼까요?</p>
               <form action="/go/list" method="post" class="formbox">
                  <select name="gbRecruitArea" class="selectbox"> 
                     <option value="none" selected disabled>원하는 장소는?</option>
                     <option value="seoul">서울</option>
                     <option value="jeju">제주</option>
                     <option value="incheon">인천</option>
                     <option value="daegu">대구</option>
                     <option value="busan">부산</option>
                     <option value="gyang">광주</option>
                     <option value="daejeon">대전</option>
                  </select>
                  
                  <select name="gbRecruitDate" class="selectbox">
                     <option value="none" selected disabled>원하는 날짜는?</option>
                     <option value="1">1월-3월</option>
                     <option value="2">4월-6월</option>
                     <option value="3">7월-9월</option>
                     <option value="4">10월-12월</option>
                  </select>
                  
                  <select name="gcAgeGroup" class="selectbox">
                     <option value="none" selected disabled>원하는 나이대는?</option>
                     <option value="20">20대</option>
                     <option value="30">30대</option>
                     <option value="40">40대</option>
                  </select>
                  
                  <select name="gcTheme" class="selectbox">
                     <option value="none" selected disabled>당신에게 여행이란</option>
                     <option value="food">먹는거지!</option>
                     <option value="photo">사진이지!</option>
                     <option value="seeing">관광이지!</option>
                     <option value="drink">술이지!</option>
                     <option value="shopping">쇼핑이지!</option>
                  </select>
                  
                  <input type="submit" value="GO!" id="btnmargin" class="btn btn-default input-lg" />
               </form>
            </div>
         </li>
            
         <!-- 함께해요 -->
         <li>
            <input type="radio" name="tabmenu" id="tabmenu2"/>
            <div class="tapbtn bgcolor"><label for="tabmenu2">함께해요</label></div>
               
            <div class="searchbox" id="bgcolor">
            <p>함께 해볼까요?</p>
               <form action="/do/search" method="post" class="formbox input-group-btn">
                  <input type="text" name="searchText" class="textbox" placeholder="어떤 활동을 하고 싶으세요?">
                    <input id="btn2margin" class="btn btn-default input-lg" type="submit" value="GO!"/>
               </form>
            </div>
         </li>
         </ui>
      </div>
   </div>
   
   <!-- content2 -->
   <!-- 함께가요 top3-->
   <div class="content2">
      <div class="content2-title">
         <span>요즘 뜨는 함께가요</span> 
         <a href="/go">전체보기</a>
      </div>
      <div id="dobest">
      
      <!-- top1 -->
      <div class="dobest">
         <div class="dobest-title">
            <div class="doprofile ialign">
            <a href="/go/goDetail?gbNo=${list.bestgo[0].GBNO }">
               <c:if test="${list.bestgo[0].UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                   <img src="<%=request.getContextPath() %>/resources/upload/default.png" alt="공백" class="img-circle" />
                     </c:if>
                     <c:if test="${list.bestgo[0].UFSTOREDFILENAME ne null}">
                  <img src="<%=request.getContextPath() %>/resources/upload/${list.bestgo[0].UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
                     </c:if>
            </a>
            </div>
            <div class="ialign marginleft">
               <div class="doname">${list.bestgo[0].UNICK} 
               <small>
                  <c:choose>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'seoul' }" >서울</c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'daegu' }" >대구 </c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${list.bestgo[0].GBRECRUITAREA eq 'gyang' }" >광주</c:when>
                       </c:choose>
               </small>
               </div>
               <div class="dotitle">
                  ${list.bestgo[0].GBTITLE} 
               </div>
            </div>
         </div>
         <div class="margintop">
            <div><span>
            <c:set var="keyword" value="${fn:split(list.bestgo[0].AGECHECK,',')}"></c:set>
                   <c:forEach items="${keyword}" var="age">
                      <span>${age }</span>
                     </c:forEach>
               </span> · 
               <span>
                     <c:choose>
                     <c:when test="${list.bestgo[0].GBRECRUITGENDER eq 0 }" >성별 무관</c:when>
                     <c:when test="${list.bestgo[0].GBRECRUITGENDER eq 1 }" >남성만</c:when>
                     <c:when test="${list.bestgo[0].GBRECRUITGENDER eq 2 }" >여성만</c:when>
                 </c:choose>  
                 </span>
                  <span>
                  <c:set var="keyword" value="${fn:split(list.bestgo[0].THEMECHECK,',')}"></c:set>
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
                  </span></div>
            <div>${list.bestgo[0].GBLIKECNT}명이 찜하고 있습니다</div>
         </div>
      </div>
      
      <!-- top2 -->
      <div class="dobest">
         <div class="dobest-title">
            <div class="doprofile ialign">
            <a href="/go/goDetail?gbNo=${list.bestgo[1].GBNO }">
               <c:if test="${list.bestgo[1].UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                   <img src="<%=request.getContextPath() %>/resources/upload/default.png" alt="공백" class="img-circle" />
                     </c:if>
                     <c:if test="${list.bestgo[1].UFSTOREDFILENAME ne null}">
                  <img src="<%=request.getContextPath() %>/resources/upload/${list.bestgo[1].UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
                     </c:if>
                  </a>
            </div>
            <div class="ialign marginleft">
               <div class="doname">${list.bestgo[1].UNICK} 
               <small>
                  <c:choose>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'seoul' }" >서울</c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'daegu' }" >대구 </c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${list.bestgo[1].GBRECRUITAREA eq 'gyang' }" >광주</c:when>
                       </c:choose>
               </small>
               </div>
               <div class="dotitle">
                  ${list.bestgo[1].GBTITLE} 
               </div>
            </div>
         </div>
         <div class="margintop">
            <div><span>
            <c:set var="keyword" value="${fn:split(list.bestgo[1].AGECHECK,',')}"></c:set>
                   <c:forEach items="${keyword}" var="age">
                      <span>${age }</span>
                     </c:forEach>
               </span> · 
               <span>
                     <c:choose>
                     <c:when test="${list.bestgo[1].GBRECRUITGENDER eq 0 }" >성별 무관</c:when>
                     <c:when test="${list.bestgo[1].GBRECRUITGENDER eq 1 }" >남성만</c:when>
                     <c:when test="${list.bestgo[1].GBRECRUITGENDER eq 2 }" >여성만</c:when>
                 </c:choose>  
                 </span>
                  <span>
                  <c:set var="keyword" value="${fn:split(list.bestgo[1].THEMECHECK,',')}"></c:set>
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
                  </span></div>
            <div>${list.bestgo[1].GBLIKECNT}명이 찜하고 있습니다</div>
         </div>
      </div>
      
      <!-- top3 -->
      <div class="dobest">
         <div class="dobest-title">
            <div class="doprofile ialign">
            <a href="/go/goDetail?gbNo=${list.bestgo[2].GBNO }">
               <c:if test="${list.bestgo[2].UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                   <img src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="공백" class="img-circle" />
                     </c:if>
                     <c:if test="${list.bestgo[2].UFSTOREDFILENAME ne null}">
                  <img src="<%=request.getContextPath() %>/resources/upload/${list.bestgo[2].UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
                     </c:if>
                  </a>
            </div>
            <div class="ialign marginleft">
               <div class="doname">${list.bestgo[2].UNICK} 
               <small>
                  <c:choose>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'seoul' }" >서울</c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'daegu' }" >대구 </c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${list.bestgo[2].GBRECRUITAREA eq 'gyang' }" >광주</c:when>
                       </c:choose>
               </small>
               </div>
               <div class="dotitle">
                  ${list.bestgo[2].GBTITLE} 
               </div>
            </div>
         </div>
         <div class="margintop">
            <div><span>
            <c:set var="keyword" value="${fn:split(list.bestgo[2].AGECHECK,',')}"></c:set>
                   <c:forEach items="${keyword}" var="age">
                      <span>${age }</span>
                     </c:forEach>
               </span> · 
               <span>
                     <c:choose>
                     <c:when test="${list.bestgo[2].GBRECRUITGENDER eq 0 }" >성별 무관</c:when>
                     <c:when test="${list.bestgo[2].GBRECRUITGENDER eq 1 }" >남성만</c:when>
                     <c:when test="${list.bestgo[2].GBRECRUITGENDER eq 2 }" >여성만</c:when>
                 </c:choose>  
                 </span>
                  <span>
                  <c:set var="keyword" value="${fn:split(list.bestgo[2].THEMECHECK,',')}"></c:set>
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
                  </span></div>
            <div>${list.bestgo[2].GBLIKECNT}명이 찜하고 있습니다</div>
         </div>
      </div>
   </div>   
   </div>
   
   <!-- 함께해요 top3-->
   <div class="content2">
      <div class="content2-title">
         <span>요즘 뜨는 함께해요</span> 
         <a href="/do">전체보기</a>
      </div>
      <div id="gobest">
      
      <c:forEach items="${list.bestdo}" var="db">
      <!-- top1 -->
      <div class="gobest">
         <div class="gobest-title">
            <div class="goprofile">
            <a href="/do/dodetail?dbNo=${db.DBNO }">
               <c:if test="${db.DISTOREDIMGNAMESTOREDIMG eq null}"> <!-- 사진이 null이면 default -->
                      <img src="<%=request.getContextPath() %>/resources/image/do/default2.jpg" alt="대표사진" />
               </c:if>
               <c:if test="${db.DISTOREDIMGNAMESTOREDIMG ne null}"> <!-- 사진이 null이면 아니면 -->
                      <img src="<%=request.getContextPath() %>/resources/upload/${db.DISTOREDIMGNAMESTOREDIMG}" alt="대표사진"  />
               </c:if>
            </a>
            </div>
            <div class="ialign">
               <div class="goname">
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
                </small></div>
               <div class="gotitle">
                  ${db.DBTITLE}
               </div>
            </div>
         </div>
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
            </span> · 
            <span>
                  <c:choose> 
                       <c:when test="${db.DBRECRUITGENDER eq 0}" >성별 무관 </c:when>
                       <c:when test="${db.DBRECRUITGENDER eq 1}" >남성만 </c:when>
                       <c:when test="${db.DBRECRUITGENDER eq 2}" >여성만 </c:when>
                     </c:choose>
            </span> · 
            <span>회비 </span>
            <span>${db.DBRECRUITCOST}원</span> </div>
            <div></div>
            <div>${db.DBLIKECNT}명이 찜하고 있습니다</div>
         </div>
      </div>
      </c:forEach>
      
      </div>
   </div>
   
   <!-- content3 -->
   <!-- best 구분선 -->   
   <div class="bestbar">
      <div class="hr ialign"></div>
      <div class="bartext ialign"> BEST </div>
      <div class="hr ialign"></div>
   </div>
   
   <!-- best mate -->
   <div class="content3">
      <div class="content3-title">
         <span>BEST : TREVEL MATE</span> 
      </div>
      
      <div id="bestmate">
      <c:forEach items="${list.besthost}" var="bh">
      <!-- top1 -->
      <div class="matebest">
         <div class="matebest-title">
            <figure class="mateprofile">
               <c:if test="${bh.UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                         <img src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="공백" class="img-circle" />
                     </c:if>
                     <c:if test="${bh.UFSTOREDFILENAME ne null}">
                        <img src="<%=request.getContextPath() %>/resources/upload/${bh.UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
                     </c:if>
              <figcaption>
                <p>
                   <c:choose> 
                       <c:when test="${bh.UGENDER eq 1}" >여자 </c:when>
                       <c:when test="${bh.UGENDER eq 2}" >남자 </c:when>
                     </c:choose>
                </p>
                <p>
                     <c:choose> 
                       <c:when test="${bh.AGE ge 20 and bh.AGE lt 30}" >20대 </c:when>
                       <c:when test="${bh.AGE ge 30 and bh.AGE lt 40}" >30대 </c:when>
                       <c:when test="${bh.AGE ge 40 and bh.AGE lt 50}" >40대 </c:when>
                       <c:otherwise>SECRET!</c:otherwise>
                     </c:choose>
                </p>
                <p>
                      <c:choose> 
                       <c:when test="${bh.GBHOSTSTARAVG ge 1 and bh.GBHOSTSTARAVG lt 2}" >★ </c:when>
                       <c:when test="${bh.GBHOSTSTARAVG ge 2 and bh.GBHOSTSTARAVG lt 3}" >★★ </c:when>
                       <c:when test="${bh.GBHOSTSTARAVG ge 3 and bh.GBHOSTSTARAVG lt 4}" >★★★ </c:when>
                       <c:when test="${bh.GBHOSTSTARAVG ge 4 and bh.GBHOSTSTARAVG lt 5}" >★★★★ </c:when>
                       <c:when test="${bh.GBHOSTSTARAVG ge 5}" >★★★★★ </c:when>
                     </c:choose>
                </p>
              </figcaption>
            </figure>
            <div class="ialign">
               <div class="matename">${bh.UNICK}</div>
            </div>
         </div>
      </div>
      </c:forEach>
      </div>
   </div>
   
   <!-- best review -->
   <div class="content3">
      <div class="content3-title">
         <div class="t1">
            <span>BEST : 함께가요</span>
            <a href="/board/reviewlist"><span class="glyphicon glyphicon-plus-sign"></span></a>
         </div>
         <div class="t2">
            <span>BEST : 함께해요</span>
            <a href="/board/reviewlist"><span class="glyphicon glyphicon-plus-sign"></span></a>
         </div>
      </div>
      <div id="reviewbest">
      
         <!-- gotop1-->
         <div class="reviewbest">
            <div class="rv-titlebox ialign">
               <div class="rv-image ialign"><img src="/resources/image/main/quotes_icon.png" alt="아이콘"/></div>
               <div class="rv-title ialign"> ${list.goreview[0].RBTITLE} </div>
            </div>
            <div class="rv-contentbox">
               <div>
               <div class="ialign">
               <span>
                  <c:choose>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'seoul' }" >서울 </c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'daegu' }" >대구</c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${list.goreview[0].GBRECRUITAREA eq 'gyang' }" >광주</c:when>
                     </c:choose>
               </span>
                · 
                <span> ${list.goreview[0].GBTITLE}</span></div>
               <div class="rfloat ialign">by <span>${list.goreview[0].UNICK}</span></div>
               </div>
               <div>
               <div class="ialign"><span>${list.goreview[0].RBLIKECNT}</span>명이 공감했어요</div>
               <div class="rfloat ialign"><fmt:formatDate var="date" value="${list.goreview[0].GBWRITTENDATE}" pattern="YYYY-MM-dd" />${date}</div>
               </div>
            </div>
         </div>
         
         <!-- dotop1 -->
         <div class="reviewbest">
            <div class="rv-titlebox ialign">
               <div class="rv-image ialign"><img src="/resources/image/main/quotes_icon.png" alt="아이콘"/></div>
               <div class="rv-title ialign">${list.doreview[0].RBTITLE} </div>
            </div>
            <div class="rv-contentbox">
               <div >
               <div class="ialign">
               <span>
                  <c:choose>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'seoul' }" >서울 </c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'jeju' }" >제주</c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'incheon' }" >인천</c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'daegu' }" >대구</c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'busan' }" >부산</c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'daejeon' }" >대전</c:when>
                        <c:when test="${list.doreview[0].DBRECRUITAREA eq 'gyang' }" >광주</c:when>
                     </c:choose>
               </span> · 
               <span>${list.doreview[0].DBTITLE}</span>
               </div>
               <div class="rfloat ialign">by <span>${list.doreview[0].UNICK}</span></div>
               </div>
               <div>
               <div class="ialign"><span>${list.doreview[0].RBLIKECNT}</span>명이 공감했어요</div>
               <div class="rfloat ialign"><fmt:formatDate var="date" value="${list.doreview[0].DBWRITTENDATE}" pattern="YYYY-MM-dd" />${date}</div>
               </div>
            </div>
         </div>
      </div>
   </div>
   
   <!-- footer -->
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

</div>
</body>
</html>