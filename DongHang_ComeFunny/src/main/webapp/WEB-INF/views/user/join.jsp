<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
   href="<%=request.getContextPath() %>/resources/css/join.css" />
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>  

<!-- fontawesome 아이콘 -->
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
   integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
   crossorigin="anonymous">

<!-- semantic ui -->
<link rel="stylesheet"
   href="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.css">
<script
   src="https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/dist/semantic.min.js"></script>


<!-- Standard Meta -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
   content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

<!-- Site Properties -->
<title>회원가입</title>

<style type="text/css">
body {
   background-color: #DADADA;
}

body>.grid {
   height: 100%;
}

.image {
   margin-top: -100px;
}

.column {
   max-width: 800px;
}

.join__logo {
   text-align: center;
}

.form__label {
   width: 100px;
}
</style>
<script type="text/javascript">
function popupOpen(){
	var url= "/sms_authentication";    //팝업창에 출력될 페이지 URL
	var winWidth = 535;
    var winHeight = 338;
    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
    var myWindow = window.open(url,"",popupOption);
//     myWindow.document.write("<h1>"+myWindow.name+"</h1>");
}

$(document).ready(function () {
	$('#authSms').click(function(event){  //버튼을 클릭 했을시 popupOpen 함수 출력 
	    console.log('click');
	    popupOpen();
	});
})
</script>

</head>

<script type="text/javascript">
$(function idChk(){
   $("#idChkBtn").on("click", function() {
      var userId = $("#userId").val();
      $.ajax({
         url : "${pageContext.request.contextPath}/user/idChk?userId" + userId,
         type : "POST",
         data : {
            userId : $("#userId").val()
         },
         success : function(result) {
            if (result == 1) {
               $("#id_check").html("중복된 아이디가 있습니다.");
               $("#join__signin").attr("disabled", "disabled");
            } else if (userId == "") {
               $("#id_check").html("아이디를 입력해 주세요.");
                $("#join__signin").attr("disabled", "disabled");
            } else {
               $("#id_check").html("사용가능한 아이디 입니다.");
               $("#join__signin").removeAttr("disabled");
            }
         },
      })
   });
})

$(document).ready(function() {
   //시작 시 아이디에 포커스
   $('#userId').focus();
   
   //--- 비밀번호 유효성 검사 ---
   var pwReg = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //6~15자 영문, 특수문자, 숫자 조합
   
   //비밀번호가 포커스를 잃었을 때
   $('#uPw').on("blur", function() {
      if( !pwReg.test( $(this).val() ) ) {
         $("#userPwMsg")
            .css("color", "red")
            .html("비밀번호는 특수문자, 숫자, 영문자를 모두 포함하여 6~15자로 입력해주세요.")
            $("#join__signin").attr("disabled", "disabled");
      } else {
         $("#userPwMsg").html("");
         $("#join__signin").removeAttr("disabled");
      }
   });
   
   //--- 비밀번호 일치여부 확인 ---
   $('#uPwconfirm').on("blur", function() {
      var pw = $('#uPw').val();
      var pwChk = $('#uPwconfirm').val();
      
      if( pw != pwChk ) {
         $("#userPwChkMsg")
         .css("color", "red")
         .html("비밀번호가 일치하지 않습니다.")
         $("#join__signin").attr("disabled", "disabled");
         
         // 작성된 내용을 지우고 비밀번호 입력창으로 포커스 이동시키기
         $("#uPwconfirm").val("") //#uPw_chk 내용 지우기
      } else {
         $("#userPwChkMsg").html("")
         $("#join__signin").removeAttr("disabled");
      }
         
   });
   
   //--- 이름 유효성 검사 ---
   var nameReg = /^[가-힣]{2,6}$/; //한글 2~6글자만 입력 가능
   
   //이름이 포커스를 잃었을 때
   $('#uName').on("blur", function() {
      if( !nameReg.test( $(this).val() ) ) {
         $("#userNameMsg")
            .css("color", "red")
            .html("이름은 한글 2~6글자만 입력 가능합니다.")
            $("#join__signin").attr("disabled", "disabled");
      } else {
         $("#userNameMsg").html("");
         $("#join__signin").removeAttr("disabled");
      }
   });
   
   //--- 연락처 유효성 검사 ---
   var phoneReg = /^01([0|1|6|7|8|9]?)-?([0-9]{3,4})-?([0-9]{4})$/

   //연락처가 포커스를 잃었을 때
   $('#uPhone').on("blur", function() {
      if( !phoneReg.test( $(this).val() ) ) {
         $("#uPhoneMsg")
            .css("color", "red")
            .html("연락처가 올바르지 않습니다.")
            $("#join__signin").attr("disabled", "disabled");
      } else {
         $("#uPhoneMsg").html("");
         $("#join__signin").removeAttr("disabled");
      }
   });
   
   //--- 닉네임 유효성 검사 ---
   var uNickReg = /^[가-힣a-zA-Z0-9]{2,10}$/; //2~10자의 한글, 영문, 숫자만 사용
   
   //닉네임이 포커스를 잃었을 때
   $('#uNick').on("blur", function() {
      if( !uNickReg.test( $(this).val() ) ) {
         $("#uNickMsg")
            .css("color", "red")
            .html("닉네임은 2~10자의 한글, 영문, 숫자만 사용 가능합니다.")
            $("#join__signin").attr("disabled", "disabled");
      } else {
         $("#uNickMsg").html("");
         $("#join__signin").removeAttr("disabled");
      }
   });
   
   //--- 이메일 유효성 검사 ---
   var emailReg = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/;
   
   //이메일이 포커스를 잃었을 때
   $('#uMail').on("blur", function() {
      if( !emailReg.test( $(this).val() ) ) {
         $("#uMailMsg")
            .css("color", "red")
            .html("이메일 형식에 맞지 않습니다.")
            $("#join__signin").attr("disabled", "disabled");
      } else {
         $("#uMailMsg").html("");
         $("#join__signin").removeAttr("disabled");
      }
   });
   
   //--- 생년월일 유효성검사 ---
   var yearReg = /^(19[0-9][0-9]|20\d{2})$/;
   var dayReg = /^(0[1-9]|[1-2][0-9]|3[0-1])$/;
   
   //생년월일이 포커스를 잃었을 때
   $('#yy').on("blur", function() {
         if( !yearReg.test( $(this).val() ) ) {
            $("#yearMsg")
               .css("color", "red")
               .html("년도 형식이 맞지 않습니다.")
               $("#join__signin").attr("disabled", "disabled");
         } else {
            $("#yearMsg").html("");
            $("#join__signin").removeAttr("disabled");
         }
      });
   $('#dd').on("blur", function() {
         if( !dayReg.test( $(this).val() ) ) {
            $("#dayMsg")
               .css("color", "red")
               .html("일자 형식이 맞지 않습니다.")
               $("#join__signin").attr("disabled", "disabled");
         } else {
            $("#dayMsg").html("");
            $("#join__signin").removeAttr("disabled");
         }
      });
   
});

function execPostCode() {
    new daum.Postcode({
        oncomplete: function(data) {
           // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

           // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
           // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
           var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
           var extraRoadAddr = ''; // 도로명 조합형 주소 변수

           // 법정동명이 있을 경우 추가한다. (법정리는 제외)
           // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
           if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
               extraRoadAddr += data.bname;
           }
           // 건물명이 있고, 공동주택일 경우 추가한다.
           if(data.buildingName !== '' && data.apartment === 'Y'){
              extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
           }
           // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
           if(extraRoadAddr !== ''){
               extraRoadAddr = ' (' + extraRoadAddr + ')';
           }
           // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
           if(fullRoadAddr !== ''){
               fullRoadAddr += extraRoadAddr;
           }

           // 우편번호와 주소 정보를 해당 필드에 넣는다.
           console.log(data.zonecode);
           console.log(fullRoadAddr);
           
           
           $("[name=addr1]").val(data.zonecode);
           $("[name=addr2]").val(fullRoadAddr);
           
           /* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
           document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
           document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
       }
    }).open();
}


</script>
<body>

   <div class="ui middle aligned grid " id="join__background__image">
      <div id="join__background"></div>
      <div class="column" id="join__column">
         <div class="join__logo">
            <h2 class="ui teal image header">
               <img
                  src="<%=request.getContextPath() %>/resources/image/header/logo.png"
                  class="image" id="join__logo__image">
            </h2>
         </div>
         <div class="ui container">
            <h2>Sign In</h2>
            <form class="ui form"
               action="<%=request.getContextPath()%>/user/joinimple" method="post">
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">아이디</label> <input type="text"
                        id="userId" name="userId" placeholder="아이디를 입력해주세요.">
                  </div>
                  <div class="five wide field">
                     <button id="idChkBtn" class="ui button" type="button"
                        onclick="idChk();">중복확인</button>
                  </div>
               </div>
               <div>
                  <p id="id_check" class="w3-text-red"
                     style="text-align: center; margin: 0 0 1em" />
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">비밀번호</label> <input type="password" id="uPw"
                        name="uPw" placeholder="비밀번호를 입력해 주세요.">
                  </div>
                  <div class="five wide field">
                     <span id="userPwMsg"></span>
                  </div>
               </div>

               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">비밀번호 확인</label> <input type="password"
                        id="uPwconfirm" name="uPwconfirm" placeholder="다시 한번 입력해주세요.">
                  </div>
                  <div class="five wide field"></div>
               </div>
               <p id="userPwChkMsg" style="text-align: center"></p>

               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">이름</label> <input type="text" id="uName"
                        name="uName" placeholder="이름을 입력해 주세요.">
                  </div>
                  <div class="five wide field">
                     <span id="userNameMsg"></span>
                  </div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">연락처</label> <input type="text"
                        id="uPhone" name="uPhone" placeholder="-를 제외하고 입력해주세요.">
                  </div>
                  <div class="five wide field">
	                	<button class="ui button" id="authSms"type="button"> 
			              	본인인증
			            </button> 
                     <span id="uPhoneMsg"></span>
                  </div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">닉네임</label> <input type="text" id="uNick"
                        name="uNick" placeholder="닉네임을 입력해 주세요.">
                  </div>
                  <div class="five wide field">
                     <span id="uNickMsg"></span>
                  </div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label__birth">생년월일</label> <input id="yy"
                        type="text" name="uBirthyy" placeholder="년(4자)" maxlength="4">
                     <select id="mm" class="ui fluid dropdown" name="uBirthmm">
                        <option value="">월</option>
                        <option value="01">1</option>
                        <option value="02">2</option>
                        <option value="03">3</option>
                        <option value="04">4</option>
                        <option value="05">5</option>
                        <option value="06">6</option>
                        <option value="07">7</option>
                        <option value="08">8</option>
                        <option value="09">9</option>
                        <option value="10">10</option>
                        <option value="11">11</option>
                        <option value="12">12</option>
                     </select> <input id="dd" type="text" name="uBirthdd" placeholder="일"
                        maxlength="2">

                  </div>
                  <div class="five wide field">
                     <span id="yearMsg"></span>
                     <span id="dayMsg"></span>
                  </div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label__gender">성별</label>
                     <div class="five wide field">
                        <div class="ui radio checkbox">
                           <input type="radio" name="uGender" value="1">
                        </div>
                        <label>남</label>
                     </div>
                     <div class="five wide field">
                        <div class="ui radio checkbox">
                           <input type="radio" name="uGender" value="2">
                        </div>
                        <label>여</label>
                     </div>
                  </div>
                  <div class="five wide field"></div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                     <label id="join__label">이메일</label> <input type="email"
                        id="uMail" name="uMail" placeholder="donghang@donghang.com">
                  </div>
                  <div class="five wide field">
                     <span id="uMailMsg"></span>
                  </div>
               </div>
               <div class="inline fields">
                  <div class="three wide field"></div>
                  <div class="nine wide field">
                    <label id="join__label">주소</label>
						<div class="addr">
							<input class="address" style="width: 40%; display: inline;"
								placeholder="우편번호" name="addr1" id="addr1" type="text"
								readonly="readonly">
							<button type="button" class="btn btn-default"
								onclick="execPostCode();" style="height: 38px; float: right">
								<i class="fa fa-search"></i> 우편번호 찾기
							</button>
							<div class="addr">
								<input class="address" style="top: 5px;"
									placeholder="도로명 주소" name="addr2" id="addr2" type="text"
									readonly="readonly" />
							</div>
							<div class="addr">
								<input class="address" placeholder="상세주소" name="uAddress"
									id="uAddress" type="text" />
							</div>
					    </div>
                  </div>
                  <div class="five wide field"></div>
               </div>
               <div class="inline fields">
                  <div class="five wide field"></div>
                  <div class="seven wide field">
                     <button id="join__signin" class="ui button" type="submit">
                   	     회원가입</button>
                  </div>
                  <div class="five wide field"></div>
               </div>
            </form>
         </div>

      </div>

   </div>
   <script>
   $('*.checkbox').checkbox();
   $('*.dropdown').dropdown();
  </script>
</body>

</html>
