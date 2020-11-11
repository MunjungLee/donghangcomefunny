<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
</head>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/fId.css" />
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script> 
<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">

<!-- semantic ui -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css" integrity="sha512-8bHTC73gkZ7rZ7vpqUQThUDhqcNFyYi2xgDgPDHc+GXVGHXq+xPjynxIopALmOPqzo9JZj0k6OqqewdGO3EsrQ==" crossorigin="anonymous" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js" integrity="sha512-dqw6X88iGgZlTsONxZK9ePmJEFrmHwpuMrsUChjAw1mRUhUITE5QU9pkcSox+ynfLhL15Sv2al5A0LVyDCmtUw==" crossorigin="anonymous"></script>

  <!-- Standard Meta -->
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<script
  src="https://code.jquery.com/jquery-2.2.4.min.js"></script>

<script type="text/javascript">

// $(document).ready(function() {
// 	// 팝업 히든 불러오기
// 	$('#subBtn').click(function() {
// 		$('#background_modal').show();
// 	});
// });

//아이디  값 저장하기 위한 변수
// var idV = "";
// // 아이디 값 받고 출력하는 ajax
// var idSearch_click = function(){
// 	$.ajax({
// 		type:"POST"
// 		,url:"/user/fId"
// 		,data : ""
// // 		url:"${pageContext.request.contextPath}/user/userSearch?uname="
// // 				+$('#uname').val()+"&umail="+$('#email').val(),
// 		success:function(data){
// 			if(data == 0){
// 				$('#id_value').text("회원 정보를 확인해주세요!");	
// 			} else {
// 				$('#id_value').text(data);
// 				// 아이디값 별도로 저장
// 				idV = data;
// 			}
// 		}
// 	});
// }
$(document).ready(function() {
	$('#subBtn').click(function() {
		var uName = document.getElementById('uName').value;
		var uMail = document.getElementById('uMail').value;
		console.dir(uName);
		var result = {}
		result.uName = uName;
		result.uMail = uMail;
		$.ajax({
			type:"POST"
			,url:"/user/fId"
			,data : result
			,datatype : "JSON"
			,success:function(result){
				console.dir(result.uName);	

				if(result == ""){
					alert("회원 정보를 확인해주세요!");
// 					$('#id_value').text("회원 정보를 확인해주세요!");	
				} else {
					alert("회원님의 아이디는 : " + result + " 입니다.");
					location.href="/user/login";
// 					$('#id_value').text(result);
					// 아이디값 별도로 저장
					idV = result;
				}
			}
		});
		
		$('#background_modal').show();
	});
});

// $("#btnRecommend").click(function() {
// 	 var rrcUNo = ${logInInfo.uNo};
// 	 var rrcRbNo = ${rview.detail.RBNO};
// 	 var rec =	$("#rec").val();
// 	 var result = {};
// 	 result.rrcUNo = rrcUNo;
// 	 result.rrcRbNo = rrcRbNo;
// 	 result.rec = rec;
// 	 $.ajax({
// 		 type: "POST"
// 		 ,url: "/board/reviewrecommend"
// 		 ,data: result
// 		 ,datatype: "JSON"
// 		 ,success : function(result) {
// 			 console.dir(result);
// 			if( result == 1) {
// 				$("#btnRecommend").html('<i class="fas fa-thumbs-up"></i>&emsp;<span>추천</span>');
// 				alert("추천 되었습니다.");
// 				$("#rec").val('1');
// 			} else {
// 				$("#btnRecommend").html('<i class="far fa-thumbs-up"></i>&emsp;<span>추천</span>');
// 				alert("추천이 취소되었습니다.");
// 				$("#rec").val('0');
// 			}
// 		 }
			 
// 	 })


</script>

<body>

<!--   <div id="background_modal" class="background_modal" style="display: none;"> -->
<!-- 	<div class="modal_contents"> -->
<!-- 		<h4> -->
<!-- 			<b>회원님의 아이디는</b><span class="close">&times;</span> -->
<!-- 		</h4><br> -->
<!-- 			<h2 id="id_value"></h2> -->
<!-- 		<br> -->
<!-- 		<button type="button" id="loginBtn" onclick="location.htef='login.jsp'">로그인 하기</button> -->
<!-- 	</div> -->
<!-- </div> -->

<div class="ui middle aligned center aligned grid " id="fId__background__image">
  <div id="fId__background"></div>
  <div class="column" id="fId__column">
    <h2 class="ui teal image header">
      <img src="<%=request.getContextPath() %>/resources/image/header/logo.png" class="image" id="fId__logo__image">
    </h2>
    <form class="ui large form" action="<%=request.getContextPath()%>/user/fId" method="post">
    
      <div class="ui stacked segment">
      
        <div class="field">
            <input type="text" id="uName" name="uName" placeholder="User Name">
        </div>
        
        <div class="field">
            <input type="text" id="uMail" name="uMail" placeholder="E-mail address">
        </div>
		</div>
      <div class="ui error message"></div>

    </form>

    <div>
    	<button id="subBtn" class="ui teal button">아이디 찾기</button>
    	<button id="cancelBtn" class="ui teal button" type="button" onclick='history.back()'>돌아가기</button>
    </div>
  </div>
</div>
</html>
