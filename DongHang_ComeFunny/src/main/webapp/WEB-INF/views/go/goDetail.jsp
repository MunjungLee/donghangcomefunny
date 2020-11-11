<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께가요 :: 상세보기</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/go/goDetail.css" />

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
$(document).ready(function() {
   
   $('#golist').click(function() { 
       $('.contentbox2').fadeToggle(300);
       $('html, body').animate({ scrollTop :  $(document).height()}, 100);
               return false;
   });    
   
});


function selectUrl(url){
   console.log("클릭됨됨됨됨");
   var root = '<%=request.getContextPath()%>';
   document.querySelector('#form-data').action = root + url;
}
</script>

<!-- 신청하기 동행 목록 추가 -->
<script type="text/javascript">
$(document).ready(function() {
   
   var test = "";
   
   $("#goDhApplyBtn").click(function() {
      console.log("클릭됨");
      
       $.ajax({
         url: "/go/goApply",
         type: "POST",
         data: {
            gbNo: ${goDetailInfo.goBoardUserInfo.GBNO }
         },
         success: function(result) {
            console.log("result" + result);
           
            
            if(result != ""){
                   alert("동행 신청 완료되었습니다.");
                   
                   
                   var html = '';
                   html += '<div class="mateone">';
                   html += '<div class="mtitle">';
                   
                   if(result.UFSTOREDFILENAME == null) {
                   html += '<img src="/resources/upload/default.png" class="img-circle"/>';
                   
                   } else {
                   html += '<img src="/resources/upload/' + result.UFSTOREDFILENAME + '" class="img-circle"/>';
                   }
               
                   html += '</div>';
                   html += '<div class="mtitle">';
                   html += '<h4>' + result.USERID +'</h4>';
                   html += '<h5>' + result.AGE + '·';
                   
                   if(result.UGENDER == '1') {
                      html += '남';
                   } else if(result.UGENDER == '2') {
                      html += '여';
                   }
               
                   html += '</h5>';
                   html += '</div>';
                   
                   html += '<div class="mbtn">';
                   html += '<div style="display: inline-block;" class="goDhApplyResult">';
//                    html += '<a class="btn btn-primary" id="goDhOkBtn" onclick="goDhOkBtn(' + result.GAUNO + ');">수락</a>';
//                    html += '<a class="btn btn-default" id="goDhNoBtn" onclick="goDhNoBtn(' + result.GAUNO + ');">거절</a>';
               html += '<a class="btn btn-primary">대기중</a>';
                   html += '</div>';
                   html += '</div>';
                   html += '</div>';
                   
               $(".mate-list").append(html);
               
                }else if(result == ""){
                   alert("로그인을 해주세요");
                   location.href="/user/login";

                }
            
            
         }
         
      });
      
   
   }); 
   
   
});
</script>


<script type="text/javascript">
/* 동행 수락 */
function goDhOkBtn(gaUNo) {
   
    $.ajax({
         url: "/go/goDhOk",
         type: "POST",
         data: {
            gbNo: ${goDetailInfo.goBoardUserInfo.GBNO },
            gaUNo: gaUNo
             
         },
         success: function(result) {
          if(result == "fail"){
                alert("동행 요청 수락이 실패되었습니다.");
                
             }else if(result == "fail2"){
                alert("동행 요청 수락 인원이 꽉찼습니다.");
                
             } else {
            alert("동행 요청이 수락되었습니다.");
                
                console.log(result);
                document.querySelector(result).outerHTML = '<a class="btn btn-primary">동행수락</a>';

             }
            
            
         }
         
      });
}

/* 동행 거절 */
function goDhNoBtn(gaUNo) {
   
   
    $.ajax({
         url: "/go/goDhNo",
         type: "POST",
         data: {
            gbNo: ${goDetailInfo.goBoardUserInfo.GBNO },
            gaUNo: gaUNo
             
         },
         success: function(result) {
            if(result != "fail"){
                alert("동행 요청이 거절되었습니다.");
                
                document.querySelector(result).outerHTML = '<a class="btn btn-default">동행거절</a>';

                
             }else{
                alert("동행 요청 거절이 실패되었습니다.");
             }
            
            
         }
         
      });
}

//하트 누르면 이미지 변경 
function toggleImg() {
   
   
   if($('#change').attr('src') == '/resources/image/go/heart.png'){ //찜안되어있음
      console.log("찜됨");
            
      $.ajax({
         url: "/go/goInsertLike",
         type: "POST",
         data: {
            gbNo: ${goDetailInfo.goBoardUserInfo.GBNO },
            uNo : ${logInInfo.uNo }
             
         },
         success: function(result) {
            if(result == 1){
                alert("함께가요 찜목록에 추가되었습니다.");
                
                /* 찜목록 성공했을 경우 가득찬 하트사진으로 변경 */
              $('#change').attr('src','<%=request.getContextPath()%>/resources/image/go/heart_pick.png');

                
                } else if(result == 0){
                   alert("함께가요 찜목록 추가에 실패했습니다.");
                } 
            
         }
         
      });
      
      
      
   } else { //찜되어있음
       console.log("찜취소");
         
       $.ajax({
         url: "/go/goDeleteLike",
         type: "POST",
         data: {
            gbNo: ${goDetailInfo.goBoardUserInfo.GBNO },
            uNo : ${logInInfo.uNo }
             
         },
         success: function(result) {
            if(result > 0){
                alert("함께가요 찜목록을 삭제하였습니다.");
                
                /* 찜목록 성공했을 경우 비워있는 하트사진으로 변경 */
                 $('#change').attr('src','<%=request.getContextPath()%>/resources/image/go/heart.png');

                
                }else{
                   alert("함께가요 찜목록 삭제에 실패했습니다.");
                }   
            
         }
         
      });

     }
    
}

</script>
<script type="text/javascript">
function toggleImg2() {
      alert("로그인을 해주세요");
      location.href="/user/login";
                           
}
</script>
<script>
  function share() {
    var url = encodeURI(encodeURIComponent('http://localhost:8088/go/goDetail?gbNo=${goDetailInfo.goBoardUserInfo.GBNO}'));
    var title = encodeURI('${goDetailInfo.goBoardUserInfo.GBTITLE }');
    var shareURL = "https://share.naver.com/web/shareView.nhn?url=" + url + "&title=" + title;
    document.location = shareURL;
  }
</script>
</head>
<body>
<div class="detail-container">
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
   <div class="contentbox">
      <!-- 상단타이틀부분-->
      <div class="contitle">
<!--          <div class="gotag"> -->
            <c:choose>
                     <c:when test="${goDetailInfo.goBoardUserInfo.GBRECRUITSTATUS eq 0 }" ><span class="gotag">모집중</span></c:when>
                     <c:when test="${goDetailInfo.goBoardUserInfo.GBRECRUITSTATUS eq 1 }" ><span class="gotag2">모집마감</span></c:when>
                 </c:choose>  
<!--          </div> -->
         <div class="float-right"><a href="/go" class="goatag"><span class="glyphicon glyphicon-remove"></span></a></div>
      </div>
      
      <!-- 프로필 부분 -->
      <div class="profile">
         <div class="profile-img">
            <!-- 프로필 기본 이미지 -->
            <c:if test="${empty goDetailInfo.goBoardUserInfo.UFSTOREDFILENAME }">
               <img src="<%=request.getContextPath() %>/resources/image/go/default.png" class="img-circle profile-img" />
            </c:if>
            <!-- 사용자가 등록한 프로필 이미지 -->
            <c:if test="${not empty goDetailInfo.goBoardUserInfo.UFSTOREDFILENAME }">
               <img src="<%=request.getContextPath() %>/resources/upload/${goDetailInfo.goBoardUserInfo.UFSTOREDFILENAME }" class="img-circle profile-img" />
            </c:if>
            <div class="goheart">
               <c:if test="${not empty logInInfo.uNo }">
                     <c:choose>
                        <c:when test="${goLikeStatus  eq '0'}">
                           <img id="change" src="/resources/image/go/heart.png" alt="찜하트1" onclick="toggleImg();"/>
                        </c:when>
                        <c:when test="${goLikeStatus  eq '1'}">
                           <img id="change" src="/resources/image/go/heart_pick.png" alt="찜하트2" onclick="toggleImg();"/>
                        </c:when>
                     </c:choose>
                  </c:if>   
                <c:if test="${empty logInInfo.uNo }">
                     <img id="change" src="/resources/image/go/heart.png" alt="찜하트3"  onclick="toggleImg2();"/>   
                  </c:if>
            </div>
         </div>
         <div class="profile-name">
            <h3>${goDetailInfo.goBoardUserInfo.UNICK }
               <small>
                  ${goDetailInfo.goBoardUserInfo.AGE} ·
                  <c:choose>
                     <c:when test="${goDetailInfo.goBoardUserInfo.UGENDER eq '1'}">
                           남
                     </c:when>
                     <c:when test="${goDetailInfo.goBoardUserInfo.UGENDER eq '2'}">
                           여
                     </c:when> 
                  </c:choose>
               </small>
            </h3>
         </div>
         <div class="profile-type">
            <!-- 반복으로 체크박스 내용 뿌려주기 -->
            <!-- 성별 -->
            <span class="typelist">
               <c:choose>
                      <c:when test="${goDetailInfo.goBoardUserInfo.GBRECRUITGENDER eq '0'}">
                              성별무관
                     </c:when>
                     <c:when test="${goDetailInfo.goBoardUserInfo.GBRECRUITGENDER eq '1'}">
                              남자만
                     </c:when>
                     <c:when test="${goDetailInfo.goBoardUserInfo.GBRECRUITGENDER eq '2'}">
                           여자만
                     </c:when> 
               </c:choose>
            </span>
            <c:forEach items="${goDetailInfo.goCheck }" var="goCheck">
               <span class="typelist">
               
                  <c:choose>
                     <c:when test="${goCheck.gcValue eq '20'}">
                        20대
                     </c:when>
                     <c:when test="${goCheck.gcValue eq '30'}">
                        30대
                     </c:when>
                     <c:when test="${goCheck.gcValue eq '40'}">
                        40대
                     </c:when>
                     
                     <c:when test="${goCheck.gcValue eq 'food'}">
                        음식
                     </c:when>
                     <c:when test="${goCheck.gcValue eq 'photo'}">
                        사진
                     </c:when>
                     <c:when test="${goCheck.gcValue eq 'seeing'}">
                        관광
                     </c:when>
                     <c:when test="${goCheck.gcValue eq 'drink'}">
                        술
                     </c:when>
                     <c:when test="${goCheck.gcValue eq 'shopping'}">
                        쇼핑
                     </c:when>
                     <c:when test="${goCheck.gcValue eq 'etc'}">
                        기타
                     </c:when>
                  </c:choose>
                  </span>
               </c:forEach>   
            
         </div>
      </div>
      
      <!-- 본문 -->
      <div class="article">
         <!-- 본문제목 -->
         <div class="article-title">
            <span><img src="/resources/image/go/quotes_icon.png" alt="아이콘"/></span>
            <span>${goDetailInfo.goBoardUserInfo.GBTITLE }</span>
         </div>
         <!-- 본문 내용 -->
         <div class="article-text">
            ${goDetailInfo.goBoardUserInfo.GBCONTENT }
         </div>
      </div>
      
      <!-- 후기 부분 최대 3개 -->
      <div class="rvtop3">
         <!-- 타이틀-->
         <div class="rvtop3-title"> 
            호스트 후기 <span>★</span> <span>( ${goDetailInfo.hostReviewCnt } )</span>
           <div class="ialign float-right"><a href="<%=request.getContextPath() %>/board/reviewlist">더보기</a></div>
         </div>
      
         <div class="rvmargin">
         <!-- 이부분 반복 -->
         <c:forEach items="${goDetailInfo.hostReview }" var="host">
         <div class="rvtop3-mate">
            <div class="rvtitle">
            <div class="rvttitle">
               <!-- 프로필 기본 이미지 -->
               <c:if test="${empty host.UFSTOREDFILENAME }">
                  <img src="<%=request.getContextPath() %>/resources/upload/default.png" class="img-circle" />
               </c:if>
               
               <!-- 사용자가 등록한 프로필 이미지 -->
               <c:if test="${not empty host.UFSTOREDFILENAME }">
                  <img src="<%=request.getContextPath() %>/resources/upload/${host.UFSTOREDFILENAME }" class="img-circle" />
               </c:if>      
            </div>
            <div class="rvttitle">
               <h4>${host.USERID }</h4>
               <h6><fmt:formatDate var="date" value="${host.RBWRITTENDATE}" pattern="YYYY-MM-dd"/>${date}</h6>
            </div>
            </div>
            <div class="rvtext">
               ${host.RBCONTENT }
            </div>
         </div>
         </c:forEach>
         </div>
      </div>
      
      <!-- 마지막 버튼 부분 -->   
      
      <!-- 글쓴이한테만 보임 -->
      <div class="dobtn" style="margin: auto; margin-top: 5%; height: 35px;">
         <c:if test="${goDetailInfo.goBoardUserInfo.GBUNO == logInInfo.uNo}">
            <a class="btn btn-warning " href="/go/modify?gbNo=${goDetailInfo.goBoardUserInfo.GBNO}">수정</a> 
            <a class="btn btn-danger " href="/go/goDelete?gbNo=${goDetailInfo.goBoardUserInfo.GBNO}">삭제</a>
       </c:if>      
      </div>
         
      <div class="dobtn" style="display: inline-block; margin: auto; margin-top: 1%; text-align: center; height: 35px;">
           <div class="ialign float-left">  
               <!-- 신청목록 내용 보여짐 -->
               <a id="golist" class="btn btn-primary ">신청목록</a>
               
               
               
               <!-- 모집중일때만 신청하기 버튼 보여주기 -->
               <c:if test="${goDetailInfo.goBoardUserInfo.GBRECRUITSTATUS eq '0' }">
                     <c:if test="${goDetailInfo.goBoardUserInfo.GBUNO != logInInfo.uNo}">
                        <div class="ialign btncen">
                          <c:if test="${empty logInInfo.uNo }">
                            <a class="btn btn-default " onclick="toggleImg2();">쪽지보내기</a>
                            <button class="btn btn-primary" onclick="toggleImg2();">신청하기</button>
                          </c:if>
                         <c:if test="${not empty logInInfo.uNo }">
                           <a class="btn btn-default " href="<%=request.getContextPath() %>/message/send">쪽지보내기</a>
                            <button class="btn btn-primary" id="goDhApplyBtn">신청하기</button>
                         </c:if>
                         </div>   
                     </c:if>
               </c:if>
               </div>
         </div>
         
           <!-- 공유하기 -->
          <div class="ialign float-right btn3">
                     <h5 style="display: inline-block; margin: 0 20px; color:#03588C; ">공유하기 : </h5>
                        <a title="페이스북" class="btn btn-default" href="#" id="vIconFb" onclick="return false;"><h3 style="margin: 0;">f</h3></a>
                        <a title="트위터" class="btn btn-default" href="#" id="vIconTw" onclick="return false;"><h3 style="margin: 0;">t</h3></a> 
                        <span title="네이버 카페">
                        
                        <script type="text/javascript" src="https://ssl.pstatic.net/share/js/naver_sharebutton.js"></script>
                        <script type="text/javascript">
                           new ShareNaver.makeButton({"type": "e" , "title":"DongHangComeFunny_함께가요_${goDetailInfo.goBoardUserInfo.GBTITLE }"});
                     </script>
            </span>
            <span title="네이버 블로그">
               <script type="text/javascript" src="//static.naver.net/blog/share/blog_sharebutton.js?v={0}"></script>
               <script type="text/javascript">
               new ShareBlog.makeButton({"type": "d" , "title":"DongHangComeFunny_함께가요_${goDetailInfo.goBoardUserInfo.GBTITLE }"});
               </script>
            </span>
         </div>
         
         
         
         <script type="text/javascript">
            $(window).ready(function(){               
                 $(".btn3 a").click(function(){
                     shareAct(this);
                     console.log("aa : " + this);
                     
                 });
              
            });
              
            function shareAct(a){
                    var snsCode = $(a).attr('id'); 
                    var cUrl = "window.document.URL";
                 
                    console.log("snsCode : " + snsCode);
                    
                    switch(snsCode){
              
                        case"vIconTw":
                            //트위터
                            cUrl = 'https://twitter.com/intent/tweet?text=페이지제목:&url='+cUrl;
                        break;
                                            
                        case"vIconFb":
                            //페이스북
                            cUrl = 'http://www.facebook.com/sharer/sharer.php?u='+cUrl+'&title=${goDetailInfo.goBoardUserInfo.GBTITLE }';
                        break;
              
                    }
              
                    window.open(cUrl,'','width=600,height=300,top=100,left=100,scrollbars=yes');
              
                }
         
         </script>            
      </div>   
  
   

<!-- content2 -->
   <!-- 신청 목록 박스 -->
   <div class="contentbox2"> 
      <!-- 타이틀 -->
      <div class="contitle"> 신청 목록 </div>
      <!-- 신청 목록 -->
      <div class="mate-list">
      
         <!-- 이부분 반복 -->
         <c:forEach items="${goDetailInfo.goDhApplylist }" var="goApplylist">
         <div class="mateone">
            <div class="mtitle">
               <!-- 프로필 기본 이미지 -->
               <c:if test="${empty goApplylist.UFSTOREDFILENAME }">
                  <img src="<%=request.getContextPath() %>/resources/upload/default.png" class="img-circle"/>
               </c:if>
               <!-- 사용자가 등록한 프로필 이미지 -->
               <c:if test="${not empty goApplylist.UFSTOREDFILENAME }">
                  <img src="<%=request.getContextPath() %>/resources/upload/${goApplylist.UFSTOREDFILENAME }" class="img-circle"/>
               </c:if>
            </div>
            <div class="mtitle">
               <h4>${goApplylist.USERID }</h4>
               <h5>${goApplylist.AGE } ·
                  <c:choose>
                     <c:when test="${goApplylist.UGENDER eq '1'}">
                        남
                     </c:when>
                     <c:when test="${goApplylist.UGENDER eq '2'}">
                        여
                     </c:when> 
                  </c:choose>
               </h5>
            </div>
            <div class="mbtn"> <!-- 작성자만 볼수 있음 -->
               <c:choose>
                     
                  <c:when test="${goApplylist.GASTATUS eq '0'}">
                  
                     <c:if test="${goDetailInfo.goBoardUserInfo.GBUNO == logInInfo.uNo}">
                        <div style="display: inline-block;" class="goDhApplyResult">
                           <a class="btn btn-primary" id="goDhOkBtn" onclick="goDhOkBtn(${goApplylist.GAUNO });">수락</a>
                           <a class="btn btn-default" id="goDhNoBtn" onclick="goDhNoBtn(${goApplylist.GAUNO });">거절</a>
                        </div>
                     </c:if>
                     
                     <c:if test="${goDetailInfo.goBoardUserInfo.GBUNO != logInInfo.uNo}">
                        <div style="display: inline-block;" class="goDhApplyResult">
                           <a class="btn btn-primary">대기중</a>
                        </div>
                     </c:if>
                </c:when>
                  
                  <c:when test="${goApplylist.GASTATUS eq '1'}">
                     <div style="display: inline-block;" class="goDhApplyResult">
                        <a class="btn btn-primary">동행수락</a>
                     </div>
                  </c:when>
                  <c:when test="${goApplylist.GASTATUS eq '2'}">
                     <div style="display: inline-block;" class="goDhApplyResult">
                        <a class="btn btn-default">동행거절</a>
                     </div>   
                  </c:when>
                  
               </c:choose>
                        
            </div>
         </div>
         </c:forEach>
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