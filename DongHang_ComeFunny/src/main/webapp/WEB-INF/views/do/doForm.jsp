<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께해요 :: 인원모집하기</title>
<!-- doForm.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/do/doForm.css" />

<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<!-- 네이버 스마트 에디터2 라이브러리  -->
<script type="text/javascript"
   src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<!-- <form>태그의 submit을 수행하면 editor에 작성한 내용을 <textarea>에 반영 -->
<script type="text/javascript">
function submitContents(elClikedObj) {
   //에디터의 내용을 #content에 반영
   oEditors.getById["doContent"].exec("UPDATE_CONTENTS_FIELD", []);
   
   try {
      elClikedObj.form.submit();
   } catch(e) {
      
   }
}
</script> 

<script type="text/javascript">
$(document).ready(function () {

	$("#btnWrite").click(function() {
		
		//스마트에디터의 내용을 <textarea>에 적용하는 함수 호출
		submitContents($("#btnWrite"));
// 		var content = document.getElementById("smartEditor").value;
		var chk = /^[0-9]/g;
		
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
// 		else if($("#inputcost").val() == null || $("#inputcost").val() ==''){
// 			alert("회비는 필수 입력 값 입니다.")
// 		}
		else if( !chk.test( $("#inputcost").val() ) || $("#inputcost").val() == null ){
			alert("회비는 숫자만 입력가능합니다.")
			$("#inputcost").focus();
		}
		else if($("#inputrenum").val() == null || $("#inputrenum").val() ==''){
			alert("인원수는 필수 선택 값 입니다.")
		}
		else if(!($("input:radio[name='dbRecruitGender']").is(':checked'))){
			alert("성별은 필수 선택 값 입니다.")
		}
		else if($("input:checkbox[name='dcAgeGroup']:checked").length < 1){
			alert("모집 연령대를 하나 이상 체크해주세요.")
		}
		else if($("input:checkbox[name='dcTheme']:checked").length < 1){
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
	
	
})

</script>
</head>

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
<form action="<%=request.getContextPath() %>/do/dowrite" method="POST" enctype="multipart/form-data">
   <div class = "dowrite"> 
   <div class = "dowritebox">
   <!-- title -->
   <div class = "dowrite-title">
      <div class = "dowrite-label"><span>함께해요</span></div>
      <span class = "dowrite-text">인원 모집하기</span> <span>(*수정 항목이 제한적이니 신중하게 작성해주세요)</span>
   </div>
   	<!-- 테이블 설정 -->
      <table class = "dowrite-table">
      <tr>
         <td>카테고리</td>
         <td colspan="4">
         <div class="row_left" >
  			<select name="dbRecruitDate" class="selectbox" id="inputdate">
                     <option value="none" selected="selected" disabled="disabled">날짜</option>
                     <option value="1">1월-3월</option>
                     <option value="2">4월-6월</option>
                     <option value="3">7월-9월</option>
                     <option value="4">10월-12월</option>
            </select>
            
            <select name="dbRecruitArea" class="selectbox" id="inputarea">
                     <option value="none" selected="selected" disabled="disabled">지역</option>
	                 <option value="seoul">서울</option>
	                 <option value="jeju">제주</option>
	                 <option value="incheon">인천</option>
	               	 <option value="daegu">대구</option>
	                 <option value="busan">부산</option>
	                 <option value="daejeon">대전</option>
	                 <option value="gyang">광주</option>
            </select>
            
            <select name="dbRecruitStatus" class="selectbox" id="inputstatus">
                     <option value="none" selected="selected" disabled="disabled">상태</option>
                     <option value="0">모집중</option>
                     <option value="1">모집마감</option>
            </select>
          </div> 
         </td>
      </tr>
      <tr>
         <td>글 제목</td>
         <td colspan="3">
            <input type="text" name="dbTitle" class="form-control" placeholder="제목을 입력하세요." id="inputtitle">
         </td>
      </tr>
      <tr>
          <td>회비</td>
         <td>
            <input type="text" name="dbRecruitCost" class="form-control" id="inputcost">
         </td>
         <td>인원</td>
         <td>
            		<select name="dbRecruitNumber" class="selectbox" id="inputrenum">
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
      	<td>연령대</td>
           <td>
           <div class="row_left" id="inputgender">
           		<span><label><input type="checkbox" name="dcAgeGroup" value="20" class="deleteChk"><span>20대</span></label></span>
           		<span><label><input type="checkbox" name="dcAgeGroup" value="30" class="deleteChk"><span>30대</span></label></span>
           		<span><label><input type="checkbox" name="dcAgeGroup" value="40" class="deleteChk"><span>40대</span></label></span>           	
           	</div>
           	</td>
         <td>성별</td>
         <td>
         <div class="row_left" id="inputage">
			<span><label><input type="radio" name="dbRecruitGender" value="0"><span>무관</span></label></span>
			<span><label><input type="radio" name="dbRecruitGender" value="1"><span>여성만</span></label></span>
         	<span><label><input type="radio" name="dbRecruitGender" value="2"><span>남성만</span></label></span>
         </div>
         </td>   	
      </tr>
      <tr>
      	 <td>여행타입</td>
          	<td colspan="3" class="textleft" id="inputtype">
          	<div class="row_left">
				<span><label><input type="checkbox"  name="dcTheme" value="food"><span>맛집</span></label></span>
             	<span><label><input type="checkbox"  name="dcTheme" value="activity"><span>액티비티</span></label></span>
             	<span><label><input type="checkbox"  name="dcTheme" value="meseum"><span>전시/박물관</span></label></span>
             	<span><label><input type="checkbox"  name="dcTheme" value="etc"><span>기타</span></label></span>
           	</div>
           	</td>
      </tr>
      <tr>
         <td colspan="4">
            <textarea id="doContent" name="dbContent" class="dotextarea"></textarea>
         </td>
      </tr>
      <tr>         
      	<td>이미지첨부</td>
         <td colspan="3">
         	<input type="file" accept="image/*" name="files" id="contract_file" multiple/>
         	<p id="fspan">*참고용 이미지 1개이상 넣어주세요.</p>
         </td>
      </tr>
      <tr> 
      	<td colspan="4">   
      	<div class="row_right">     
        	<span><input id="btnWrite" type="button" value="등록" class="btn btn-primary btnsize" /></span>
        	<span><input id="btnCancel" type="button" value="이전으로" class="btn btn-default btnsize"/></span>
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


<!-- 스마트 에디터 적용하는 코드 -->
<!-- <textarea>에 스마트 에디터의 스킨을 입히는 코드  -->
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
   oAppRef: oEditors,
   elPlaceHolder: "doContent", //에디터가 적용되는 <textarea>의 id를 입력
   sSkinURI: "/resources/se2/SmartEditor2Skin.html",
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