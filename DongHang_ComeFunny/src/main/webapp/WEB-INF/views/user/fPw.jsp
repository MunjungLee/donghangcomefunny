<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<link rel="stylesheet"
   href="<%=request.getContextPath() %>/resources/css/fPw.css" />
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script> 
<!-- fontawesome 아이콘 -->
<link rel="stylesheet"
   href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
   integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
   crossorigin="anonymous">

<!-- semantic ui -->
<link rel="stylesheet"
   href="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.css"
   integrity="sha512-8bHTC73gkZ7rZ7vpqUQThUDhqcNFyYi2xgDgPDHc+GXVGHXq+xPjynxIopALmOPqzo9JZj0k6OqqewdGO3EsrQ=="
   crossorigin="anonymous" />
<script
   src="https://cdnjs.cloudflare.com/ajax/libs/semantic-ui/2.4.1/semantic.min.js"
   integrity="sha512-dqw6X88iGgZlTsONxZK9ePmJEFrmHwpuMrsUChjAw1mRUhUITE5QU9pkcSox+ynfLhL15Sv2al5A0LVyDCmtUw=="
   crossorigin="anonymous"></script>

<!-- Standard Meta -->
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta name="viewport"
   content="width=device-width, initial-scale=1.0, maximum-scale=1.0">


<script type="text/javascript">


$(function(){
//    /* 이메일 인증 버튼 클릭시 발생하는 이벤트 */
//    $(document).on("click", "#emailBtn", function(){
      
//       var data = "";
//       var url = "${pageContext.request.contextPath}/user/createEmailCheck";
// //       var uid = '"uEmail=" + $("#uEmail").val() + "&random=" + $("#dice").val()';
//       var uEmail = encodeURIComponent(document.getElementById("uEmail"));
//       var dice = encodeURIComponent(document.getElementById("dice"));
      
//       data = "uEmail="+uEmail+"&dice="+dice;
//       //data: "uEmail="+encodeURIComponent($('#uEmail').val()),
//       console.dir(data);
//       console.dir($("#uEmail").val());
// //       console.dir($("dice").val());
//    /* 이메일 중복 체크 후 메일 발송 비동기 처리 */
//    $.ajax({
//    beforeSend: function(){
//    },
//    type:"get",
//    url : url,
//    data : data,
//    success : function(data){
//       console.dir(data);
//       alert("인증번호를 발송하였습니다.");
//    },
//    error : function(data){
//       alert("인증번호 발송에 실패하였습니다.");
//       return false;
//             }
//       })
//    })
//    /*
//    이메일 인증번호 입력 후 인증 버튼 클릭 이벤트
//    */
//    $(document).on("click", "#emailAuthBtn", function(){
      
//       var url = "${pageContext.request.contextPath}/user/fPw";
//       var data = '"authCode=" + $("#emailAuth").val() + "&random=" + $("#random").val()';
//       console.dir(url);
//    $.ajax({
//    beforeSend: function(){
//    },
//    type : "get",
//    url : url,
//    data : data,
//    success:function(data){
//       if(data=="complete"){
//          alert("인증이 완료되었습니다.");
//       }else if(data == "false"){
//          alert("인증번호를 잘못 입력하셨습니다.")
//       }
//    },
//    complete: function(){
//    },
//    error:function(data){
//       alert("에러가 발생했습니다.");
//             }
//          });
//       });
//    });

   /* 이메일 인증 버튼 클릭시 발생하는 이벤트 */
   $(document).ready(function() {
      $(document).on("click", "#emailBtn", function(){
      var uName = document.getElementById('uName').value;
      console.log(uName)
      var userId = document.getElementById('userId').value;
      console.log(userId)
      var uMail = document.getElementById('uEmail').value;
      console.log(uMail)
      var url = "/user/userChk";
      var data ="uName="+ uName+"&userId="+userId+ "&uEmail=" + uMail;      
      $.ajax({
         beforeSend: function(){
//             loadingBarStart();
         },
         type:"get",
         url : url,
         data: data,
         async: false,
         success : function(data){
            console.log(data);
            if(data =="1"){
             sendMailChk();
            }
            else{
               alert("존재하지 않은 회원입니다")
            }
         },
         error : function(data){
            alert("오류가 발생했습니다.");
            return;
                  }
            });
      });
   function sendMailChk(){
      
      var url = "/user/createEmailCheck";
      var uEmail = $("#uEmail").val();
      var random = $("#random").val();
      var data = "uEmail=" + uEmail + "&random=" + random;
      console.dir(data);
      console.dir($("#uEmail").val());
   /* 이메일 중복 체크 후 메일 발송 비동기 처리 */
   $.ajax({
   beforeSend: function(){
//       loadingBarStart();
   },
   type:"get",
   url : url,
   data : data,
   success : function(data){
      console.dir(data);
      alert("인증번호를 발송하였습니다.");
      $('#emailAuthBtn').removeAttr("disabled");
   },
   error : function(data){
      alert("인증번호 발송에 실패하였습니다.");
      return false;
            }
      })
   
   /*
   이메일 인증번호 입력 후 인증 버튼 클릭 이벤트
   */
   $(document).on("click", "#emailAuthBtn", function(){
      var url = "/user/emailAuth";
      var random = $("#random").val();
      var data = "authCode=" + ${authCode} + "&random=" + random;
      console.dir(data);
   $.ajax({
   beforeSend: function(){
//       loadingBarStart();
   },
   type : "get",
   url : url,
   data : data,
   success:function(data){
      if(data=="complete"){
         alert("인증이 완료되었습니다.");
         $('#subBtn').removeAttr("disabled");
      }else if(data == "false"){
         alert("인증번호를 잘못 입력하셨습니다.")
      }
   },
   complete: function(){
//       loadingBarEnd();
   },
   error:function(data){
      alert("에러가 발생했습니다.");
            }
         });
      });
   
   
   
      $("#subBtn").on("click", function(){
         var userId = document.getElementById('userId').value
         console.dir(userId);
         location.href="/user/fPwChange?userId="+userId;
      });
   }
});
   })
</script>


<div class="ui middle aligned center aligned grid "
   id="fPw__background__image">
   <div id="fPw__background"></div>
   <div class="column" id="fPw__column">
      <h2 class="ui teal image header">
         <img
            src="<%=request.getContextPath() %>/resources/image/header/logo.png"
            class="image" id="fPw__logo__image">
      </h2>
      <form class="ui large form" action="<%=request.getContextPath()%>/user/fPwEmailCheck" method="post">

         <div class="ui stacked segment">

            <div class="field">
               <input type="text" id = "uName" name="uName" placeholder="User Name">
            </div>

            <div class="field">
               <input type="text" id="userId" name="userId" placeholder="User ID">
            </div>

            <div class="field">
               <input type="text" id="uEmail" name="uEMail" placeholder="E-mail address">
            </div>
            <div class="field">
               <input type="text" id="email" name="email"
                  placeholder="Certification Number">
               <button type="button" class="btn btn-info" id="emailBtn">인증번호
                  발송</button>
               <button type="button" class="btn btn-info" id="emailAuthBtn" disabled>인증번호
                  확인</button>
            </div>
            <input type="hidden" path="random" id="random" value="${random}" />
            <input type="hidden" path="authCode" id="authCode" value="${authCode}" />
         </div>
         <div class="ui error message"></div>

      </form>

      <div>
         <button id=subBtn type="button" class="ui teal button" disabled>비밀번호 변경</button>
         <button id=cancelBtn class="ui teal button" onclick='history.back()'>돌아가기</button>
      </div>
   </div>
</div>
</html>