<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>

<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_profile.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_likelist.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mydonghang.css" >

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

      $(document).on("click", "#likebtndelete", function() {
      
         if( $("#likebtndelete").text() == "목록" ) {
             $(".like_cancel").css("display", "none");
            $("#likebtndelete").html("삭제")
         } else {
             $(".like_cancel").css("display", "inline-block");
            $("#likebtndelete").html("목록")
         }
      
   });

});
</script>
<script type="text/javascript">
function like_cancel(dbNo) {
   
   //삭제하고 싶은 찜의 번호
   console.log(dbNo);   
   
   //XMLHttpRequest 객체 생성
   // 전체 페이지의 새로고침없이도 URL 로부터 데이터를 받아올 수 있다
   var xhr = new XMLHttpRequest();
   
   //Http Request Message의 시작줄 작성
   xhr.open('POST','<%=request.getContextPath()%>/mypage/deleteLike');
   
   //Http Request Message의 header 작성
   // open()후, send()전에 setRequestHeader()를 호출
   // F12에서 Content-Type을 지정
   xhr.setRequestHeader('Content-Type','application/x-www-form-urlencoded');
   
   //body에 데이터 작성하고 전송
   xhr.send('dbNo='+dbNo);
   
   //ajax 통신이 끝나고 (load) 실행할 콜백함수 등록
   xhr.addEventListener('load', function() {
      
      //메모장 참고
      //response body 있는 데이터를 받아옴
      var data = xhr.response;
      
      console.log(data);
      
      if(data != 'fail') {
         alert("찜목록이 삭제 되었습니다.");
         
         console.dir(document.querySelector(data));
         document.querySelector(data).outerHTML = '';
      
      } else {
         alert("삭제에 실패했습니다.");
         
      }
   })
   
   
}
</script>   

</head>
<body>
<c:import url="mypage_header.jsp" />

<div class="container" id="mypage">
   <div id="likeBtn">
      <!-- 함께가요  -->
      <div id="switchBlock1" onclick="location.href='/mypage/golike'"></div>
      <!-- 함께해요  -->
      <div id="switchBlock2" onclick="location.href='#'"></div>
      <div>
         <img id="myDongHangBtn" alt="나의 동행" src="/resources/image/mypage/dolike.png">
      </div>
   </div>
   
   <div id="my_info">
   <div class="profile_title">함께해요</div>
   <button id="likebtndelete">삭제</button>
      <div class="likecontainer">
         <c:forEach items="${likeList }" var="list" varStatus="i">
         <div class="likebox" id="likeboxdelete${list.DBNO }"> 
            <figure class="like_img_box">
            <c:if test="${empty list.DISTOREDIMGNAME }">
               <img class="like_img" alt="찜이미지" src="<%=request.getContextPath() %>/resources/upload/default.png">
            </c:if>   
            <c:if test="${not empty list.DISTOREDIMGNAME }">
               <img class="like_img" alt="찜이미지" src="<%=request.getContextPath() %>/resources/upload/${list.DISTOREDIMGNAME }">
            </c:if>   
               <figcaption>
                   <p><a style="color: white;" href="<%=request.getContextPath() %>/do/dodetail?dbNo=${list.DBNO }">${list.DBTITLE }</a></p>
               </figcaption>            
            </figure>
            <button id="like_cancel${i.count }" class="like_cancel" style="display: none;" onclick="like_cancel(${list.DBNO})" value="${list.DBNO }">X</button>
         </div>
         </c:forEach>   
      </div>   
   </div>
</div>



<c:import url="footer.jsp" />

</body>
</html>