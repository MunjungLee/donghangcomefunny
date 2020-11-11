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

<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<script type="text/javascript">

	//검색 필터 관련 속성
	//클릭하면 클릭한 속성이 추가됨
	
	var ageValue ="", genderValue="", themeValue="", areaValue="", stateValue ="";
	
	function addKeyFilterObj(data) {
		var textNode = $(data).parent();
		var dataName = $(data).attr('name');
		var dataValue = $(data).attr('value');
		var text = $(data).next().html();
		var btn = $('<span class="tag"><span class="delete" name="' + dataName + '" value="' + dataValue + '">'
				+ text
				+ '</span>'
				+ '<a href="#this" class="delete" onclick="removeKeyFilter($(this).parent()); return false;"><span class="glyphicon glyphicon-remove"></span></a></span>');

		if ($(data).prop('checked')) { //속성이 check로 바뀌면
			$('.group').prepend(btn); //아래 group박스에 목록 추가
			
			if( dataName == "dcAgeGroup"){
				ageValue += $(data).attr('value')+"-";
			}
			
			else if( dataName == "dbRecruitGender"){
				genderValue += $(data).attr('value')+"-";
			}
			
			else if( dataName == "dcTheme"){
				themeValue += $(data).attr('value')+"-";
			}
			
			else if( dataName == "dbRecruitArea"){
				areaValue += $(data).attr('value')+"-";
			}
			
			else if( dataName == "dbRecruitStatus"){
				stateValue += $(data).attr('value')+"-";
			}
			
			$.ajax({
				type : 'GET'
				, url : "/do/filter?age="+ageValue + "&gender=" + genderValue + "&theme=" + themeValue +"&area=" + areaValue + "&state=" + stateValue
				, dataType: "html"
				, success : function(data){
					console.log("AJAX 성공");
 					$("#dobest").html(data);
				}
				, error: function(request,status,error) {
					console.log('AJAX fail');
					alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error)
				}
			});
			
		} else {
			removeKeyFilter(textNode); //클릭해제되면 필터적용 함수도 사라짐
			
			if( dataName == "dcAgeGroup"){
				ageValue = ageValue.replace($(data).attr('value')+"-","");
			}
			
			else if( dataName == "dbRecruitGender"){
				genderValue = genderValue.replace($(data).attr('value')+"-","");
			}
			
			else if( dataName == "dcTheme"){
				themeValue = themeValue.replace($(data).attr('value')+"-","");
			}
			
			else if( dataName == "dbRecruitArea"){
				areaValue = areaValue.replace($(data).attr('value')+"-","");;
			}
			
			else if( dataName == "dbRecruitStatus"){
				stateValue = stateValue.replace($(data).attr('value')+"-","");
			}
			
		}
	}

	//삭제하면 제거됨
	function removeKeyFilter(data) { //$(data).parent()
		var text = $(data).find('span').text();

		$('.searchtb label span:contains(' + text + ')').prev().prop('checked', false); //상단필터
		$('.group .tag span:contains(' + text + ')').parent().remove();
	
		var filtertest = $('.searchtb label span:contains(' + text + ')').prev();
	
		if( filtertest.attr('name') == "dcAgeGroup"){
			ageValue = ageValue.replace(filtertest.val()+"-","");
		}
		
		else if( filtertest.attr('name') == "dbRecruitGender"){
			genderValue = genderValue.replace(filtertest.val()+"-","");
		}
		
		else if( filtertest.attr('name') == "dcTheme"){
			themeValue = themeValue.replace(filtertest.val()+"-","");
		}
		
		else if( filtertest.attr('name') == "dbRecruitArea"){
			areaValue = areaValue.replace(filtertest.val()+"-","");
		}
		
		else if( filtertest.attr('name') == "dbRecruitStatus"){
			stateValue = stateValue.replace(filtertest.val()+"-","");
		}
		
		$.ajax({
			type : 'GET'
			, url : "/do/filter?age="+ageValue + "&gender=" + genderValue 
					+ "&theme=" + themeValue +"&area=" + areaValue + "&state=" + stateValue
			, dataType: "html"
			, success : function(data){
				console.log("AJAX 성공 - 버튼 해제");
				$("#dobest").html(data);
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
//드롭다운
$(document).ready(function() {
	
	$('#dropdownMenu1').click(function() { 
	 	$('.dropdown-menu').toggle(200, function(){
	 		$('.dropdown-menu a').click(function(){
	 			$('.dropdown-menu').hide()
	 			return false; //현재 페이지 고정
	 		});
	 	});
	});	 
	
});
</script>


</head>
<body>
<div class="do-container">
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
	<div id="do-content">
		<div class="do-title">
			<h1>함께해요!</h1>
			<h1>특별한 활동을 같이 해요</h1>
			<h4>
			새로운 사람들과 특별한 것을 해보고 싶지 않으신가요? <br>
			현재 모집중인 취향 맞춤 활동을 찾아보세요!
			</h4>
		</div>	
	</div>
	
	<!-- 상단검색필터 -->
	<div id="do-search">
		<!-- 검색타이틀 -->
		<div>
			<p class="ialign">어떤 활동을 찾으시나요?</p>
			<form action="/do/search" method="post" id="formid" class="ialign pull-right formbox input-group-btn">
				<input type="text" name="searchText" class="textbox" placeholder="내용 검색"/>
				<button type="submit" id="gobtn" class="btn btn-default input-lg"><span class="glyphicon glyphicon-search"></span></button>
			</form>
		</div>
	
		<!--검색 필터 그룹-->
		<div id="do-filter">
			<table class="searchtb">
			  <tr>
			    <td>연령대</td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcAgeGroup" value="20"><span>20대</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcAgeGroup" value="30"><span>30대</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcAgeGroup" value="40"><span>40대</span></label></td>
			  </tr>
			  <tr>
			    <td>성별</td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitGender" value="1"><span>남성</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitGender" value="2"><span>여성</span></label></td>
			  </tr>
			  <tr>
			    <td>여행타입</td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcTheme" value="food"><span>맛집</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcTheme" value="activity"><span>액티비티</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dcTheme" value="meseum"><span>전시/박물관</span></label></td>
			  </tr>
			  <tr>
			    <td>지역</td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="seoul"><span>서울</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="jeju"><span>제주</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="incheon"><span>인천</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="daegu"><span>대구</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="busan"><span>부산</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="daejeon"><span>대전</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitArea" value="gyang"><span>광주</span></label></td>
			  </tr>
			  <tr>
			    <td>상태</td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitStatus" value="0"><span>모집중</span></label></td>
			    <td><label><input type="checkbox" onclick="addKeyFilterObj(this);" name="dbRecruitStatus" value="1"><span>모집마감</span></label></td>
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
	<div class="do-list">
		<div class="listup">
			<div class="pull-left">
			<a href="/do" class="btn btn-default">전체보기</a>      
      		</div>
<!-- 		<!-- 정렬 드롭다운 --> 
<!-- 		<div class="dropdown" > -->
<!-- 		  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true"> -->
<!-- 		    	<span>정렬방식 </span><span class="caret"></span> -->
<!-- 		  </button> -->
<!-- 		  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1"> -->
<!-- 		    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">최신순</a></li> -->
<!-- 		    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">찜순</a></li> -->
<!-- 		    <li role="presentation"><a role="menuitem" tabindex="-1" href="#">인원순</a></li> -->
<!-- 		  </ul> -->
<!-- 		</div> -->
		<!-- 모집버튼 --> 
		<div class="float-right">
			<a class="btn btn-default" href="/do/doform" role="button">인원 모집하기</a>
		</div> 
		</div>
		
		<!-- 정렬 혹은 필터된 리스트 -->
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
<!-- 							<span class="goheart"><img src="/resources/image/do/heart.png" alt="찜하트"/></span> -->
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