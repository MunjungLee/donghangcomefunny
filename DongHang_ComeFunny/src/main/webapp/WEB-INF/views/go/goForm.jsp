<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께가요 :: 동행모집하기</title>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- goForm.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/go/goForm.css" />
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

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<!-- <form>태그의 submit을 수행하면 editor에 작성한 내용을 <textarea>에 반영 -->
<script type="text/javascript">
	function submitContents(elClikedObj) {
		//에디터의 내용을 #content에 반영
		oEditors.getById["goContent"].exec("UPDATE_CONTENTS_FIELD", []);

		try {
			elClikedObj.form.submit();
		} catch (e) {

		}
	}

</script>

<script type="text/javascript">
$(document).ready(function () {
	//체크박스 전체
// 	$("#deleteChkAll").click(function(){
// 		if($(this).prop("checked")){
// 			$(".deleteChk").prop("checked", true);
// 		}else{
// 			$(".deleteChk").prop("checked", false);
// 		}		
// 	});
	
// 	$(".deleteChk").click(function(){
// 		if(!$(this).prop("checked")){
// 			$("#deleteChkAll").prop("checked", false);
// 		} 
// 	});
	
	//작성시 내용 연결
	$("#btnWrite").click(function() {
		//스마트에디터의 내용을 <textarea>에 적용하는 함수 호출
		submitContents($("#btnWrite"));
// 		var content = document.getElementById("smartEditor").value;

		//공백 제어
		if($("#inputdate").val() == null || $("#inputdate").val() == ''){
			alert("날짜은 필수 선택 값 입니다")
		}
		else if($("#inputarea").val() == null || $("#inputarea").val() ==''){
			alert("지역은 필수 선택 값 입니다")
		}
		else if($("#inputstatus").val() == null || $("#inputstatus").val() ==''){
			alert("상태는 필수 선택 값 입니다")
		}
		else if($("#inputtitle").val() == null || $("#inputtitle").val() ==''){
			alert("글 제목은 필수 입력 값 입니다")
		}
		else if($("#inputrenum").val() == null || $("#inputrenum").val() ==''){
			alert("인원수는 필수 선택 값 입니다.")
		}
		else if(!($("input:radio[name='gbRecruitGender']").is(':checked'))){
			alert("성별은 필수 선택 값 입니다.")
		}
		else if($("input:checkbox[name='gcAgeGroup']:checked").length < 1){
			alert("모집 연령대를 하나 이상 체크해주세요.")
		}
		else if($("input:checkbox[name='gcTheme']:checked").length < 1){
			alert("여행 타입을 하나 이상 체크해주세요.")
		}
		else{
			//submit 추가
			$(this).parents("form").submit();	
		}

	});

	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
	
	
});
	
</script>

<body>
<div class="body-container">
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
	  		<div class="dropbtn"><a href="#">커뮤니티</a></div>
	 	 	<div class="dropdown-content">
	    		<a href="/board/freelist">자유게시판</a>
	    		<a href="/board/reviewlist">후기게시판</a>
	 	 	</div>
		</div>
		<div class="dropdown">
	  		<div class="dropbtn"><a href="#">고객센터</a></div>
	  		<div class="dropdown-content">
	    		<a href="/serviceCenter/notice/list">공지사항</a>
	    		<a href="/serviceCenter/question/list">문의게시판</a>
	  		</div>
		</div>
		<div class="dropdown">
	  		<div class="dropbtn"><a href="/chat/chat">실시간채팅</a></div>
		</div>
	</div>

<!-- content -->
<form action="<%=request.getContextPath() %>/go/gowrite" method="post" enctype="multipart/form-data" id="formid">
	<div class = "gowrite"> 
		<div class = "gowritebox">
			<!-- title -->
			<div class = "gowrite-title">
				<div class = "gowrite-label"><span>함께가요</span></div>
				<span class="gowrite-text">동행 모집하기</span> <span>(*수정 항목이 제한적이니 신중하게 작성해주세요)</span>
			</div>
			
			<!-- table -->
			<table class="gowrite-table">
			<tr>
				<td>카테고리</td>
				<td colspan="3">
				<div class="tdleft">
					<select name="gbRecruitDate" class="selectbox" id="inputdate">
	                     <option value="none" selected="selected" disabled="disabled">날짜</option>
	                     <option value="1">1월-3월</option>
	                     <option value="2">4월-6월</option>
	                     <option value="3">7월-9월</option>
	                     <option value="4">10월-12월</option>
	                </select>
	                
	                <select name="gbRecruitArea" class="selectbox" id="inputarea">
	                     <option value="none" selected="selected" disabled="disabled">지역</option>
	                     <option value="seoul">서울</option>
	                     <option value="jeju">제주</option>
	                     <option value="incheon">인천</option>
	                     <option value="daegu">대구</option>
	                     <option value="busan">부산</option>
	                     <option value="daejeon">대전</option>
	                     <option value="gyang">광주</option>
	                </select>
	                
	                <select name="gbRecruitStatus" class="selectbox" id="inputstatus">
	                     <option value="none" selected="selected" disabled="disabled">상태</option>
	                     <option value="0" >모집중</option>
	                     <option value="1">모집마감</option>
	                </select>
	            </div>
				</td>
			</tr>
			<tr>
				<td>글 제목</td>
				<td>
					<input type="text" name="gbTitle" class="form-control" placeholder="제목을 입력하세요." id="inputtitle">
				</td>
				<td>모집 인원수</td>
				<td>
					<select name="gbRecruitNumber" class="selectbox" id="inputrenum">
	                     <option value="1" selected>1</option>
	                     <option value="2">2</option>
	                     <option value="3">3</option>
	                     <option value="4">4</option>
	                     <option value="5">5</option>
	                     <option value="6">6</option>
	                     <option value="7">7</option>
	                     <option value="8">8</option>
	                     <option value="9">9</option>
	                     <option value="10">10</option>
	                </select>
				</td>
			</tr>
			<tr>
				<td>모집 성별</td>
				<td colspan="3">
					<div class="tdleft" id="inputgender"> 
						<span><input type="radio" name="gbRecruitGender" value="0"><span>무관</span></span>
						<span><input type="radio" name="gbRecruitGender" value="1"><span>남성만</span></span>
						<span><input type="radio" name="gbRecruitGender" value="2"><span>여성만</span></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>모집 연령대</td>
				<td colspan="3">
					<div class="tdleft" id="inputage">
						<span><label><input type="checkbox" name="gcAgeGroup" value="20" class="deleteChk"><span>20대</span></label></span>
		            	<span><label><input type="checkbox" name="gcAgeGroup" value="30" class="deleteChk"><span>30대</span></label></span>
		            	<span><label><input type="checkbox" name="gcAgeGroup" value="40" class="deleteChk"><span>40대</span></label></span>
					</div>
				</td>
			</tr>
			<tr>
				<td>여행 타입</td>
				<td colspan="3">
					<div class="tdleft" id="inputtype">
						<span><label><input type="checkbox" name="gcTheme" value="food"><span>음식</span></label></span>
				    	<span><label><input type="checkbox" name="gcTheme" value="photo"><span>사진</span></label></span>
				    	<span><label><input type="checkbox" name="gcTheme" value="seeing"><span>관광</span></label></span>
				    	<span><label><input type="checkbox" name="gcTheme" value="drink"><span>술</span></label></span>
				    	<span><label><input type="checkbox" name="gcTheme" value="shopping"><span>쇼핑</span></label></span>
				    	<span><label><input type="checkbox" name="gcTheme" value="etc"><span>기타</span></label></span>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="4">
					<textarea id="goContent" name="gbContent" class="gotextarea"></textarea>
				</td>
			</tr>
			<tr>		
				<td colspan="4">
				<div class="tdright">
					<span><input type="button" class ="btn btn-primary btnsize" value="등록" id="btnWrite"></span>
					<span><input type="button" value="취소" class="btn btn-default btnsize" id="btnCancel"/></span>
				</div>
				</td>
			</tr>
			</table>
		</div>
	</div>
</form>
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
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "goContent", // 에디터가 적용되는 <textarea>의 id
	sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
	fCreator: "createSEditor2",
	htParams: {
		bUseToolbar: true, //툴바 사용여부
		bUseVerticalResizer: false, //입력창 크기 조절 바
		bUseModeChanger: true //글쓰기 모드 탭
	}
	
});
</script>



</body>
</html>