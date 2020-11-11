<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>본인인증</title>
<link rel="stylesheet"
	href="<%=request.getContextPath() %>/resources/css/fPw.css" />
<!-- JQuery -->
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

<script type="text/javascript">
$(document).ready(function() {
	$('#phoneNum').focus();
	}
)
function sendMsg() {
	var reg = /^01([0|1|6|7|8|9]?)?([0-9]{3,4})?([0-9]{4})$/;
	
	if(!reg.test($('#phoneNum').val())){
		alert("전화번호 형식이 올바르지 않습니다.");
		$('#phoneNum').focus();
		
	}else if($('#phoneNum').val()== null|| $('#phoneNum').val() ==""){
		alert("휴대전화 번호를 입력해 주십시오.");
	}else{
		alert("인증번호 발송 완료! 3분동안 메세지응답이 없을 경우 재시도 해주세요!");
		let phoneNumber = $('#phoneNum').val();
		console.log('전화 번호  : ' + phoneNumber);
		
		
		$.ajax({
            type: "POST",
            url: "/sms_authentication/sendmsg",
            data: { "phoneNumber" : phoneNumber },
            success: function(result){
				console.log(result);
				$('#chkAthentct').click(function() {
// 					console.log("인증번호 확인");
					if($('#authenticate').val() == result){
						alert('인증성공!');
						self.close();
					}else{
						alert('인증번호가 일치 하지 않습니다.');
					}
				})
                    


            }
        });//ajax
		
		
		
		
		
		
	}
	
}
</script>

</head>
<body>
<div class="ui middle aligned center aligned grid" id="fPw__background__image">
	<div id="fPw__background"></div>
	<div class="column" id="fPw__column">
		<h2 class="ui teal image header">
			<img
				src="<%=request.getContextPath() %>/resources/image/header/logo.png" class="image" id="fPw__logo__image">
		</h2>
		<form class="ui large form">
			<div class="ui stacked segment">
				<div class="field">
				  <div class="ui left icon input">
				    <i class="phone volume icon"></i>
					<input type="text" id="phoneNum" name="phoneNum" placeholder="휴대폰번호"/>
				  </div>
				</div>
				<div class="field">
				  <div class="ui left icon input">
				  <i class="key icon"></i>
					<input type="text" id="authenticate" name="authenticate" placeholder="인증번호6자리">
				  </div>
				</div>
				<div class="field">
				</div>
			</div>
			<div class="ui error message"></div>
		</form>
		<div>
			<button id="chkPnum" class="ui teal button chkPnum" type="button" onclick="sendMsg();">인증번호 발송</button>
			<button id="chkAthentct" class="ui teal button chkAthentct" type="button">인증번호 확인</button> 
		</div>
	</div>
</div>

</body>
</html>