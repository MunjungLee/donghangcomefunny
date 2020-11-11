<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>
<!-- mypage_profile.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_profile.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" />
<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   
<script type="text/javascript">
$(document).ready(function() {
	
	var modal = document.querySelector(".addmodal"); //비밀번호 확인 모달
	var modal2 = document.querySelector(".editmodal"); //개인정보 수정 모달
	var modal3 = document.querySelector(".addmodal2"); //프로필 수정 모달
	var mp1button = document.querySelector("#more"); //비밀번호 모달 버튼
	var mp2button = document.querySelector("#modal_pw_ok"); //개인정보수정 모달 버튼
	var mp3button = document.querySelector("#camera"); //프로필 모달 버튼

	
	//+ 기호 눌렀을 때
	$("#more").click(function() {
		modal.classList.toggle("show-modal"); 
	});
	
	/*============== 비밀번호 모달 ============== */
		
	//비밀번호 확인 눌렀을 때 "개인정보 모달"을 띄워진다
// 	$("#modal_pw_ok").click(function() {
// 		console.log("2");
		
// 		modal2.classList.toggle("show-modal");
// 		modal.classList.toggle("show-modal"); 
		
// 	});
	
	//비밀번호 모달 "닫기 버튼"을 눌렀을 때
	$("#close").click(function() {
		console.log("4");

		$("#more").attr("display", "none");
		modal.classList.toggle("show-modal"); 
	});
	
	/*============== 개인정보 수정 모달 ============== */
	
	//개인정보 수정 모달에서 "수정버튼"을 눌렀을 때 
	$("#modal_change").click(function() {
		console.log("3");
		modal2.classList.toggle("show-modal");
	});
	
	
	//개인정보수정 모달에서 "닫기 버튼" 눌렀을 때
	$("#close2").click(function() {
		console.log("5");

		modal2.classList.toggle("show-modal"); 
	});
	
	/*================= 프로필 모달 ============== */
	
	//카메라 버튼을 클릭했을 때
	$("#camera").click(function() {
		console.log("6");
		modal3.classList.toggle("show-modal"); 
	});
	
	//프로필 수정 모달에서 "닫기 버튼"을 클릭했을 때
	$("#close3").click(function() {
		console.log("7");

		modal3.classList.toggle("show-modal"); 
	});
	
	//프로필 수정 모달에서 "확인 버튼" 눌렀을 때
	$("#modal_ok2").click(function() {
		console.log("8");

		modal3.classList.toggle("show-modal"); 
	});
	
	
	$(window).click(function(e) {
		if(e.target === modal) {
			modal.classList.toggle("show-modal"); 
		}
	})
})
</script>   

<script type="text/javascript">
	var ajaxFlag = false;
	//아이디 중복 체크
	function xmlPwCheck() {
		
		var modal = document.querySelector(".addmodal"); //비밀번호 확인 모달
		var modal2 = document.querySelector(".editmodal"); //개인정보 수정 모달
		
		//사용자가 입력한 pwcheck값을 받아온다
		var uPw = document.querySelector('#uPw').value;
// 		var userId = document.querySelector('#userId').value;
		
		//XMLHttpRequest 객체 생성
		// 전체 페이지의 새로고침없이도 URL 로부터 데이터를 받아올 수 있다
		var xhr = new XMLHttpRequest();
		
		//Http Request Message의 시작줄 작성
		xhr.open('POST','<%=request.getContextPath()%>/mypage/pwcheck');
		
		//Http Request Message의 header 작성
		// open()후, send()전에 setRequestHeader()를 호출
		// F12에서 Content-Type을 지정
		xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
		
		//body에 데이터 작성하고 전송
		xhr.send('uPw='+uPw);
		
		//ajax 통신이 끝나고 (load) 실행할 콜백함수 등록
		xhr.addEventListener('load', function() {
			
			//메모장 참고
			//response body 있는 데이터를 받아옴
			var data = xhr.response;
			
			console.log(data);
			
			if(data == 1) {
				ajaxFlag = true;
				alert("비밀번호가 일치합니다.");

			 	modal2.classList.toggle("show-modal");
			 	modal.classList.toggle("show-modal"); 	
			
			} else {
				ajaxFlag = false;
				alert("비밀번호가 일치 하지 않습니다.");
				
			}
		})
		
	}
</script>
<!-- <script type="text/javascript">
$(document).ready(function() {
	
	$(".deleteProfileImgBtn").click(function(){
	    console.log("삭제버튼클릭");

	    var confirm_val = confirm("프로필 이미지를 삭제하시겠습니까?");
	 
	    if(confirm_val){
	       
	       var checkArr = new Array();
	       
	       $("input[class='deleteChk']:checked").each(function() {
	          console.log($(this).val());
	          checkArr.push($(this).val());
	       });
	       
	       if(checkArr==null || checkArr ==""){
	          confirm_val = confirm("삭제할 대상을 선택해 주세요.");
	       }else{
	          
	          $.ajax({
	             url : "/mypage/deletegolike"
	             ,type : "post"
	             ,data : { deleteChk : checkArr }
	          	,traditional : true
	          	,success : function(result){
	             	if(result == 1){
	                	alert("함께가요 찜목록이 삭제되었습니다.");
	                	location.href=window.document.URL;
	             	}else{
	                	alert("삭제 실패");
	             }
	          }
	          
	          });
	       }
	       
	 
	    }
	 })
	
})
</script>
 -->
<script type="text/javascript">
	function selectUrl(url){
		var root = '<%=request.getContextPath()%>';
		document.querySelector('#form-data').action = root + url;
	}
</script>

</head>
<body>
<c:import url="mypage_header.jsp" />

<div id="mypage" style="min-height: 451px;">
<!-- 개인정보 수정 -->
<div id="my_info">
	<div class="profile_title">프로필</div>
	<p class="info_Agree">*일부정보가 ComeFunny 서비스를 사용하는 다른 사람에게 표시 될 수 있습니다.</p>
	<div class="my_Profile">
		<div>
			<div style="width: 140px; height: 140px; border-radius: 100%;">
			
			<!-- 프로필 기본 이미지 -->
			<c:if test="${empty loginInfo.userImg.ufStoredFileName }">
				<img class="my_Profile_img" alt="프로필 사진" src="<%=request.getContextPath() %>/resources/upload/default.png">					
			</c:if>
			
			<!-- 사용자가 변경한 이미지 -->
			<c:if test="${not empty loginInfo.userImg.ufStoredFileName }">
				<img class="my_Profile_img" alt="프로필 사진" src="<%=request.getContextPath() %>/resources/upload/${loginInfo.userImg.ufStoredFileName }">					
			</c:if>
			</div>
			
			<img class="crown" alt="왕관이아이콘" src="<%=request.getContextPath() %>/resources/image/mypage/crown.png">
			<img class="camera" id="camera" alt="카메라이아이콘" src="<%=request.getContextPath() %>/resources/image/mypage/camera.png">
		</div>
		<div id="my_info3">
				<p class="uid" id="userId" name="userId">${loginInfo.user.userId }</p>
				<p class="unick">${loginInfo.user.uNick }</p>
		</div>
	</div>
	<div id="my_info2">
		<div class="my_info2_list">
			<div class="my_info2_item">이름</div>
			<div class="my_info2_data" style="margin-left: 120px;">${loginInfo.user.uName }</div>
		</div>
		<div class="my_info2_list">
			<div class="my_info2_item">생년월일</div>
			<div class="my_info2_data" style="margin-left: 80px;">${loginInfo.user.uBirth }</div>
		</div>
		<div class="my_info2_list">
			<div class="my_info2_item">성별</div>
			<div class="my_info2_data" style="margin-left: 128px;">
				<c:choose>
					<c:when test="${loginInfo.user.uGender eq '1'}">
						남자
					</c:when>
					<c:when test="${loginInfo.user.uGender eq '2'}">
						여자
					</c:when> 
				</c:choose>
			</div>
		</div>
		<div class="my_info2_list">
			<div class="my_info2_item">전화번호</div>
			<div class="my_info2_data" style="margin-left: 77px;">${loginInfo.user.uPhone }</div>
		</div>
		<div class="my_info2_list">
			<div class="my_info2_item">이메일</div>
			<div class="my_info2_data" style="margin-left: 80px;">${loginInfo.user.uMail }</div>
		</div>
		<div class="my_info2_list">
			<div class="my_info2_item">비밀번호</div>
			<input type="password" class="my_info2_data upw" readonly="readonly"
				value="${logInInfo.uPw }">
		</div>
	</div>
	<div style="">
		<img id="more" class="more" alt="플러스아이콘" src="<%=request.getContextPath() %>/resources/image/mypage/more.png">
	</div>
</div>
</div>

<!-- 비밀번호 확인 모달 -->
<div class="addmodal">
	<div class="cmodal-content">
     	<span class="modal_close" id="close">&times;</span>
		<div class="modal_title">프로필 관리</div>
		<p id="modal_pwcheck">본인확인 비밀번호</p>
		<div class="modal_content">
			<div class="modal_item">비밀번호</div>
			<div class="modal_pw">
				<input type="password" id="uPw" name="uPw" required="required"/>
			</div>
		</div>
		<button type="button" id="modal_pw_ok" class="modal_pw_ok" onclick="xmlPwCheck()">확인</button>
	</div>
</div>

<!-- 개인정보 수정 모달 -->		
<div class="editmodal" id="editmodal">
	<form action="<%= request.getContextPath() %>/mypage/profile" method="post">
	<div class="cmodal-content">
		<span class="modal_close" id="close2">&times;</span>
		<div class="modal_title">프로필 관리</div>
		<table class="modal_content2">
  			<tr class="modal_element2">
          		<td class="modal_name">이름</td>
   				<td><input id="uName" name="uName" class="modal_readonly" type="text" value="${loginInfo.user.uName }" readonly /></td>
   				<td class="modal_name">생년월일</td>
    			<td><input id="uBirth" name="uBirth" class="modal_readonly" type="text" value="${loginInfo.user.uBirth }" readonly /></td>
  			</tr>
  			<tr>
  				<td class="modal_name">아이디</td>
    			<td><input id="userId" name="userId" class="modal_readonly" type="text" value="${loginInfo.user.userId }" readonly /></td>
    			<td class="modal_name">성별</td>
    			<td>
    				<c:if test="${loginInfo.user.uGender eq '1'}">
    					<input id="uGender" name="uGender" class="modal_readonly" type="text" value="남성" readonly disabled="disabled"/>
    				</c:if>
    				<c:if test="${loginInfo.user.uGender eq '2'}">
    					<input id="uGender" name="uGender" class="modal_readonly" type="text" value="여성" readonly disabled="disabled"/>
    				</c:if>
    			</td>
    			
			</tr>
	      	<tr>
          		<td class="modal_name">닉네임</td>
    			<td><input id="uNick" name="uNick" class="modal_write" type="text" value="${loginInfo.user.uNick }"/></td>
          		<td class="modal_name">이메일</td>
          		<td><input id="uMail" name="uMail" class="modal_write" type="text" value="${loginInfo.user.uMail }"></td>
        	</tr>
  			<tr>
          		<td class="modal_name">비밀번호</td>
    			<td><input id="uPw" name="uPw" class="modal_write" type="text" value="${logInInfo.uPw }"  /></td>
    			<td class="modal_name">전화번호</td>
    			<td><input id="uPhone" name="uPhone" class="modal_write" type="text" value="${loginInfo.user.uPhone }" /></td>
        	</tr>
		</table>
		
		<button id="modal_change" class="modal_ok"">수정</button>
	</div>
	</form>
</div>

<!-- 프로필 수정 모달 -->
<div class="addmodal2">
	<div class="cmodal-content">
     	<span class="modal_close" id="close3">&times;</span>
		<div class="modal_title">프로필 관리</div>
		<p id="modal_pwcheck">프로필 사진 선택</p>
		<form id="form-data" action="" method="post" enctype="multipart/form-data">
			<div class="modal_content">
				<div class="modal_filetext">파일</div>
				<div class="modal_pw">
					<input  type="file" id="file" name="files" />
				</div>
			</div>
			<c:if test="${not empty loginInfo.userImg.ufStoredFileName }">
				<button id="modal_defaultImg" onclick="selectUrl('/mypage/changeDeafultImg')">원본으로 변경</button>
				<button id="modal_ok2" class="modal_pw_ok" onclick="selectUrl('/mypage/changeProfile')">프로필 수정</button>
			</c:if>
			<c:if test="${empty loginInfo.userImg.ufStoredFileName }">
				<button id="modal_insertImg" onclick="selectUrl('/mypage/insertProfile')">프로필 등록</button>
			</c:if>
		</form>
	</div>
</div>




<c:import url="footer.jsp" />

</body>
</html>