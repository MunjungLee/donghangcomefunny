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

<!-- go.css -->
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

<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<script type="text/javascript">
jQuery( document ).ready(function( $ ) {

      $(window).on('popstate', function() {
         location.reload(true);
      });

});
</script>

<script type="text/javascript">

   //검색 필터 관련 속성
   //클릭하면 클릭한 속성이 추가됨
   var ageValue ="", genderValue="", themeValue="", areaValue="", stateValue ="";
   
   function addKeyFilterObj(data) {
      var textNode = $(data).parent();
      var dataName = $(data).attr('name');
      var dataValue = $(data).attr('value');
      
//       console.log(dataName);
      
      var text = $(data).next().html();
      var btn = $('<span class="tag"><span class="delete" name="' + dataName + '" value="' + dataValue + '">'
            + text
            + '</span>'
            + '<a href="#this" class="delete" onclick="removeKeyFilter($(this).parent()); return false;"><span class="glyphicon glyphicon-remove"></span></a></span>');

      if ($(data).prop('checked')) {
         $('.group').prepend(btn);
            
         if( dataName == "gcAgeGroup"){
            ageValue += $(data).attr('value')+"-";
         }
         
         else if( dataName == "gbRecruitGender"){
            genderValue += $(data).attr('value')+"-";
         }
         
         else if( dataName == "gcTheme"){
            themeValue += $(data).attr('value')+"-";
         }
         
         else if( dataName == "gbRecruitArea"){
            areaValue += $(data).attr('value')+"-";
         }
         
         else if( dataName == "gbRecruitStatus"){
            stateValue += $(data).attr('value')+"-";
         }

         $.ajax({
            type : 'GET'
            , url : "/go/filter?age="+ageValue + "&gender=" + genderValue + "&theme=" + themeValue +"&area=" + areaValue + "&state=" + stateValue
            , dataType: "html"
            , success : function(data){
               console.log("AJAX 성공");
//                console.log(data.area); //데이터안의   area?
                $("#gobest").html(data);
            }
            , error: function(request,status,error) {
               console.log("/go/filter?age="+ageValue + "&gender=" + genderValue 
                     + "&theme=" + themeValue +"&area=" + areaValue + "&state=" + stateValue)
               console.log('AJAX fail');
               alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
            }
         });
         
      } else {
         removeKeyFilter(textNode); 
         
         if( dataName == "gcAgeGroup"){
            ageValue = ageValue.replace($(data).attr('value')+"-","");
         }
         
         else if( dataName == "gbRecruitGender"){
            genderValue = genderValue.replace($(data).attr('value')+"-","");
         }
         
         else if( dataName == "gcTheme"){
            themeValue = themeValue.replace($(data).attr('value')+"-","");
         }
         
         else if( dataName == "gbRecruitArea"){
            areaValue = areaValue.replace($(data).attr('value')+"-","");;
         }
         
         else if( dataName == "gbRecruitStatus"){
            stateValue = stateValue.replace($(data).attr('value')+"-","");
         }
         
      }
   }

   //삭제하면 제거됨
   function removeKeyFilter(data) { //$(data).parent()
      var text = $(data).find('span').text();
      
      $('.searchtb label span:contains(' + text + ')').prev().prop('checked',false); //상단필터
      $('.group .tag span:contains(' + text + ')').parent().remove();
      
      var filtertest = $('.searchtb label span:contains(' + text + ')').prev();
      
      if( filtertest.attr('name') == "gcAgeGroup"){
         ageValue = ageValue.replace(filtertest.val()+"-","");
      }
      
      else if( filtertest.attr('name') == "gbRecruitGender"){
         genderValue = genderValue.replace(filtertest.val()+"-","");
      }
      
      else if( filtertest.attr('name') == "gcTheme"){
         themeValue = themeValue.replace(filtertest.val()+"-","");
      }
      
      else if( filtertest.attr('name') == "gbRecruitArea"){
         areaValue = areaValue.replace(filtertest.val()+"-","");
      }
      
      else if( filtertest.attr('name') == "gbRecruitStatus"){
         stateValue = stateValue.replace(filtertest.val()+"-","");
      }
      
      $.ajax({
         type : 'GET'
         , url : "/go/filter?age="+ageValue + "&gender=" + genderValue 
               + "&theme=" + themeValue +"&area=" + areaValue + "&state=" + stateValue
         , dataType: "html"
         , success : function(data){
            console.log("AJAX 성공 - 버튼 해제");
            $("#gobest").html(data);
         }
         , error: function(request,status,error) {
            console.log('AJAX fail');
            alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
         }
      });

   }

   //초기화
   function resetKeyFilter() {
      $('.searchtb input').prop('checked', false);
      $('.group .tag').remove();
      location.reload(true);
      
   }
   
</script>
<script type="text/javascript">
//이미지변경
$(document).ready(function() {
   
   $('.goheart').on('click', function() {
      if($(this).attr('src') == '/resources/image/go/heart.png'){ //찜안되어있음
         $(this).attr('src','<%=request.getContextPath()%>/resources/image/go/heart_pick.png');
      } else { //찜되어있음
         $(this).attr('src','<%=request.getContextPath()%>/resources/image/go/heart.png');
      }
   });
});

</script>

<script type="text/javascript">
$(document).ready(function() {
   
   //드롭다운 토글
   $('#dropdownMenu1').click(function() { 
       $('.dropdown-menu').toggle(200);
   });    
   
   //클릭시 숨기기
   $('.dropdown-menu > li > a').click(function() { 
       $('.dropdown-menu').hide();
   });    
   
});

</script>
</head>
<body>
<div class="go-container">
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
      
   <!-- content-top -->
   <!-- 상단안내이미지 -->
   <div id="go-content">
      <div class="go-title">
         <h1>함께가요!</h1>
         <h1>여행을 함께할 친구를 구해보세요!</h1>
         <h4>즐거운 여행 길, 내 취향에 꼭 맞는 동행을 쉽게 구해보세요!</h4>
      </div>   
   </div>
   
   <!-- 상단검색필터 -->
   <div id="go-search">
      <!-- 검색타이틀 -->
      <div>
         <p class="ialign">어떤 동행을 찾으시나요?</p>
         <form action="/go/search" method="post" id="formid" class="ialign pull-right formbox input-group-btn">
            <input type="text" name="searchText" class="textbox" placeholder="내용 검색"/>
            <button type="submit" id="gobtn" class="btn btn-default input-lg"><span class="glyphicon glyphicon-search"></span></button>
         </form>
      </div>
   
      <!--검색 필터 그룹-->
      <div id="go-filter">
         <table class="searchtb">
           <tr>
             <td>연령대</td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcAgeGroup" value="20"><span>20대</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcAgeGroup" value="30"><span>30대</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcAgeGroup" value="40"><span>40대</span></label></td>
           </tr>
           <tr>
             <td>성별</td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitGender" value="1"><span>남성</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitGender" value="2"><span>여성</span></label></td>
           </tr>
           <tr>
             <td>여행타입</td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcTheme" value="food"><span>음식</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcTheme" value="photo"><span>사진</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcTheme" value="seeing"><span>관광</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcTheme" value="drink"><span>술</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gcTheme" value="shopping"><span>쇼핑</span></label></td>
           </tr>
           <tr>
             <td>지역</td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="seoul"><span>서울</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="jeju"><span>제주</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="incheon"><span>인천</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="daegu"><span>대구</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="busan"><span>부산</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="daejeon"><span>대전</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitArea" value="gyang"><span>광주</span></label></td>
           </tr>
           <tr>
             <td>상태</td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitStatus" value="0"><span>모집중</span></label></td>
             <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="gbRecruitStatus" value="1"><span>모집마감</span></label></td>
           </tr>
         </table>
         
         <!-- 선택필터 추가 -->
         <div>
         <div class="group"></div>
         <div class="filter-reset">
               <a href="#this" onclick="resetKeyFilter(); return false;"><span class="glyphicon glyphicon-refresh"></span></a>
         </div>
      </div>
   </div>
   </div>
   
   <!-- content list -->
   <!-- 하단 리스트 -->
   <div id="go-list">
   
      <div class="listup">
      <div class="pull-left">
		<a href="/go" class="btn btn-default">전체보기</a>      
      </div>
      <!-- 정렬 드롭다운 -->
<!--       <div class="dropdown" > -->
<!--         <button class="btn btn-default" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true"> -->
<!--              <span>정렬방식</span><span class="caret"></span> -->
<!--         </button> -->
<!--         <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> -->
<!--            <li role="presentation"><a role="menuitem" tabindex="-1" href="#">최신순</a></li> -->
<!--           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">찜순</a></li> -->
<!--           <li role="presentation"><a role="menuitem" tabindex="-1" href="#">인원순</a></li> -->
<!--         </ul> -->
<!--       </div>    -->
      
      <!-- 모집버튼 --> 
      <div class="pull-right">
         <a class="btn btn-default" href="/go/goform" role="button">동행 모집하기</a>
      </div>
      </div>
      
      <!-- 정렬 혹은 필터처리된 리스트 -->
      <div id="gobest">
      
      <!-- 이부분 반복 -->
      <c:forEach items="${list.glist }" var="go">
      <div class="gobest">
         <div class="gobest-title">
            <div class="goprofile ialign">
            <a href="/go/goDetail?gbNo=${go.GBNO }"> <!-- 사진 클릭시 이동 -->
               <span aria-hidden="true"></span>
               <c:if test="${go.UFSTOREDFILENAME eq null}"> <!-- 사진이 null이면 default -->
                   <img src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="공백" class="img-circle" />
               </c:if>
               <c:if test="${go.UFSTOREDFILENAME ne null}">
                  <img src="<%=request.getContextPath() %>/resources/upload/${go.UFSTOREDFILENAME}" alt="프로필사진" class="img-circle" />
               </c:if>
            </a>
            </div>
            <div class="ialign marginleft">
               <div class="godate"> <!-- date추가 -->
                  <c:choose>
                        <c:when test="${go.GBRECRUITDATE eq '1' }" >1월-3월</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '2' }" >4월-6월</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '3' }" >7월-9월</c:when>
                        <c:when test="${go.GBRECRUITDATE eq '4' }" >10-12월</c:when>
                  </c:choose>
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
<!--                <span><img class="goheart" src="/resources/image/go/heart.png" /></span> -->
            </div>  
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