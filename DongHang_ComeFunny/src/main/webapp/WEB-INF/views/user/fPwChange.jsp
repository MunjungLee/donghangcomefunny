<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
</head>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/fPwChange.css" />
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

<script src="https://code.jquery.com/jquery-2.2.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
      //시작 시 비밀번호에 포커스
      $('#uPw').focus();
      
      //--- 비밀번호 유효성 검사 ---
      var pwReg = /^.*(?=^.{6,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/; //6~15자 영문, 특수문자, 숫자 조합
      
      //비밀번호가 포커스를 잃었을 때
      $('#uPw').on("blur", function() {
         if( !pwReg.test( $(this).val() ) ) {
            $("#uPwMsg")
               .css("color", "red")
               .html("비밀번호는 특수문자, 숫자, 영문자를 모두 포함하여 6~15자로 입력해주세요.")
               $("#subBtn").attr("disabled", "disabled");
         } else {
            $("#uPwMsg").html("");
            $("#subBtn").removeAttr("disabled");
         }
      });
      
    //--- 비밀번호 일치여부 확인 ---
      $('#pwChk').on("blur", function() {
         var pw = $('#uPw').val();
         var pwChk = $('#pwChk').val();
         
         if( pw != pwChk ) {
            $("#pwChkMsg")
            .css("color", "red")
            .html("비밀번호가 일치하지 않습니다")
            $("#subBtn").attr("disabled", "disabled");
            
            // 작성된 내용을 지우고 비밀번호 입력창으로 포커스 이동시키기
            $("#pwChk").val("") //#pwChk 내용 지우기
         } else {
            $("#pwChkMsg").html("")
              $("#subBtn").removeAttr("disabled");
         }
      });
});
$(document).ready(function(){
//    $("#subBtn").on("click", function(){
//       console.dir(getQueryString("userId"));
//    })

   function getQueryString(key) {
       
       // 전체 Url을 가져온다.
       var str = location.href;
    
       // QueryString의 값을 가져오기 위해서, ? 이후 첫번째 index값을 가져온다.
       var index = str.indexOf("?") + 1;
    
       // Url에 #이 포함되어 있을 수 있으므로 경우의 수를 나눴다.
       var lastIndex = str.indexOf("#") > -1 ? str.indexOf("#") + 1 : str.length;
    
       // index 값이 0이라는 것은 QueryString이 없다는 것을 의미하기에 종료
       if (index == 0) {
           return "";
       }
    
       // str의 값은 a=1&b=first&c=true
       str = str.substring(index, lastIndex); 
    
       // key/value로 이뤄진 쌍을 배열로 나눠서 넣는다.
       str = str.split("&");
    
       // 결과값
       var rst = "";
    
       for (var i = 0; i < str.length; i++) {
    
           // key/value로 나눈다.
           // arr[0] = key
           // arr[1] = value
           var arr = str[i].split("=");
    
           // arr의 length가 2가 아니면 종료
           if (arr.length != 2) {
               break;
           }
    
           // 매개변수 key과 일치하면 결과값에 셋팅
           if (arr[0] == key) {
               rst = arr[1];
               break;
           }
       }
       return rst;
   }
   document.getElementById('userId').value=getQueryString('userId');
});
</script>

<body>

<div class="ui middle aligned center aligned grid " id="fPwChange__background__image">
  <div id="fPwChange__background"></div>
  <div class="column" id="fPwChange__column">
    <h2 class="ui teal image header">
      <img src="<%=request.getContextPath() %>/resources/image/header/logo.png" class="image" id="fPwChange__logo__image">
    </h2>
    <form class="ui large form" action="<%=request.getContextPath()%>/user/changePassword" method="post">
    
      <div class="ui stacked segment">
      
        <div class="field">
            <input type="text" id="userId" name="userId" readonly="readonly">
        </div>

        <div class="field">
            <input type="text" id="uPw" name="uPw" placeholder="Change Password">
        </div>
        
        <div class="field">
            <input type="text" id="pwChk" name="pwChk" placeholder="Change Password Check">
        </div>
      </div>
            <div class="ui error message">
               <span id="uPwMsg"></span>
               <span id="pwChkMsg"></span>
            </div>
    <div>
       <button id="subBtn" class="ui teal button">비밀번호 변경</button>
       <button id="cancelBtn" class="ui teal button" type="button" onclick='location.href="/user/login"'>돌아가기</button>
    </div>

    </form>


  </div>
</div>

</body>
</html>