<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께해요 :: 상세보기</title>

<!-- doDetail.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/do/doDetail.css" />

<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- bxslider  -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<!-- fontawesome 아이콘 -->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
<script type="text/javascript">
$(document).ready(function() {
      
   $('#dolist').click(function() {
//       console.log("신청목록");
       $('.contentbox2').fadeToggle(300);
       $('html, body').animate({ scrollTop :  $(document).height()}, 100);
       return false;
   });    
   
});

//하트 누르면 이미지 변경 
function toggleImg(dbno) {
   if($('#change').attr('src') == '/resources/image/go/heart.png'){ //찜안되어있음
      $.ajax({
             url: "/do/picked",
             type: "POST",
             data: { dbno : dbno},
             success: function(result) {
               if(result == 1){
                   $('#change').attr('src','<%=request.getContextPath()%>/resources/image/go/heart_pick.png');
                   
               }else{
                  var confirm_val = confirm("로그인이 필요한 서비스 입니다.");
                  if(confirm_val){
                     location.href='<%=request.getContextPath()%>/user/login';               
                  }
               }
               
             }
             
          });
   }else {
      $.ajax({
             url: "/do/deletepick",
             type: "POST",
             data: { dbno : dbno},
             success: function(result) {
               if(result == 1){
                  $('#change').attr('src','<%=request.getContextPath()%>/resources/image/go/heart.png');
               }else{
                  alert("문제가 발생했습니다. 다시 시도해 주세요.");
               }
               
             }
             
          });
   }

}

</script>
<script type="text/javascript">
//로그인 안했을때 찜
function toggleImg2() {
      alert("로그인이 필요한 서비스입니다");
      location.href="/user/login";
                           
}

//메시지보내기
function send(){
   location.href="/message/send";
}
</script>

<script>
$(document).ready(function(){
   $(".slider").bxSlider({
       speed: 300,        // 이동 속도를 설정
       auto: true,        // 자동 실행 여부
       autoHover: true,   // 마우스 호버시 정지 여부
       controls: true,    // 이전 다음 버튼 노출 여부
       mode: 'fade',
       captions: true,
       slideWidth: 450,
       slideHeight: 750,
   });
});
</script>

<style type="text/css">
.bx-wrapper{
   min-height: 520px;
}
.bx-viewport{
    width: 100%;
    overflow: hidden;
    position: relative;
    height: 520px;
}   
</style>


<script>
  function share() {
    var url = encodeURI(encodeURIComponent('http://localhost:8088/do/dodetail?dbNo=${doDetail.doDetailList[0].DBNO}'));
    var title = encodeURI('${doDetail.doDetailList[0].DBTITLE}');
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
      <div class="tour">
             <div class = "tourinfo">
           <div id= "sliderBox">
              <div class="slider" class="tour-img" >
                  <!-- 장소사진 -->
                  <c:forEach items="${placePhoto}" var="photo">
                     <c:if test="${photo.DISTOREDIMGNAME ne null}">
                        <img height="510px" style="width: 100%; object-fit: cover" src="<%=request.getContextPath() %>/resources/upload/${photo.DISTOREDIMGNAME}" alt="대표사진"/>
                     </c:if>
                     <c:if test="${photo.DISTOREDIMGNAME eq null}">
                     <img height="510px" style="width: 100%; object-fit: cover" src="<%=request.getContextPath() %>/resources/image/do/default2.jpg"/>            
                     </c:if>      
                  </c:forEach>
               </div>
                  <c:if test="${empty logInInfo.uNo }">               
                     <div class="goheart"><img id="change" src="/resources/image/go/heart.png" alt="찜해주세요" onclick="toggleImg2();"/></div>                     
               </c:if>
               <c:if test="${not empty logInInfo.uNo }">
                  <c:choose>
                        <c:when test="${likeStatus eq 0 }">               
                           <div class="goheart"><img id="change" src="/resources/image/go/heart.png" alt="찜해주세요" onclick="toggleImg(${doDetail.doDetailList[0].DBNO})"/></div>                     
                     </c:when>
                     <c:when test="${likeStatus > 0 }">               
                           <div class="goheart"><img id="change" src="/resources/image/go/heart_pick.png" alt="찜" onclick="toggleImg(${doDetail.doDetailList[0].DBNO})"/></div>                     
                     </c:when>
                  </c:choose>
               </c:if>
             </div>
               <c:choose>
                  <c:when test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 0}">
                     <div class="gotag">모집중</div>
                  </c:when>
                  <c:when test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 1}">
                     <div class="gotag2">모집마감</div>
                  </c:when>
               </c:choose>
               <div class="float-right"><a href="/do" class="goatag"><span class="glyphicon glyphicon-remove"></span></a></div>
           
           
               <!-- 컨텐츠  제목 내용 -->
               <div id="contents">
                  <div id="contentsTitle">${doDetail.doDetailList[0].DBTITLE}</div><div id="contentsDate"><fmt:formatDate var="date" value="${doDetail.doDetailList[0].DBWRITTENDATE}" pattern="YYYY-MM-dd" />${date }</div> 
              </div>
              
              <div class="article-text">
                   ${doDetail.doDetailList[0].DBCONTENT}           
               </div>
             
              <!-- 가격및 카테고리 -->
              <div id="categoryBox">
                 <div id="cost">￦ ${doDetail.doDetailList[0].DBRECRUITCOST}</div>
                 
                 <div class="profile-type">
                         
                   <c:choose>
                      <c:when test="${doDetail.doDetailList[0].DBRECRUITGENDER eq 0}">
                         <span class="typelist">여성</span>
                         <span class="typelist">남성</span>
                      </c:when>
                      
                      <c:when test="${doDetail.doDetailList[0].DBRECRUITGENDER eq 1}">
                         <span class="typelist">남성</span>
                      </c:when>
                      
                      <c:when test="${doDetail.doDetailList[0].DBRECRUITGENDER eq 2}">
                         <span class="typelist">여성</span>
                      </c:when>
                   </c:choose>
                 
                       <c:forEach items="${doDetail.doDetailList}" var="dodetail">
                           <span class="typelist">
                              <c:choose>
                                 <c:when test="${dodetail.DCVALUE eq '20'}">
                                    20대
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq '30'}">
                                    30대
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq '40'}">
                                    40대
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq 'food'}">
                                    맛집
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq 'activity'}">
                                    액티비티
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq 'meseum'}">
                                    전시/ 박물관
                                 </c:when>
                                 <c:when test="${dodetail.DCVALUE eq 'etc'}">
                                    기타
                                 </c:when>   
                              </c:choose>
                              
                           </span>
                       
                       </c:forEach>
                        
                   </div>
                   
                   
                  <c:if test="${logInInfo.uNo ne doDetail.hostInfo[0].UNO}">
                     <c:if test="${not empty logInInfo.uNo}">
                        <button id="sendMsgBtn" onclick="send()">쪽지 보내기</button>
                     </c:if>
                     <c:if test="${empty logInInfo.uNo}">
                        <button id="sendMsgBtn" onclick="toggleImg2()">쪽지 보내기</button>
                     </c:if>
                  <c:if test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 0}">
                           <button id="applyBtn" onclick="applyDh(${doDetail.doDetailList[0].DBNO});">신청하기</button>                 
                        </c:if>
                  <c:if test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 1}">
                           <button id="applyBtn" disabled="disabled" style="background: #aaa;">신청불가</button>
                        </c:if>
               </c:if>
            
               
              </div>
           
         </div>
      </div>
<script type="text/javascript">
function applyDh(dbno) {
   $.ajax({
         url : "/do/apply"
         ,type : "post"
         ,data : { dbno : dbno }
          ,success : function(result){
             if(result == 0){                   
                alert("이미 신청한 동행입니다.");
             }else if(result == 1){
                 alert("신청이 완료 되었습니다.")
                 location.href=window.document.URL;             
             }else{
                alert('로그인이 필요한 서비스 입니다.');
                location.href='<%=request.getContextPath()%>/user/login';
             }
                   
          }
               
   })    
}
                        
</script>
      
      <!-- 호스트 소개 -->
      <div id="hostInfoBox">
         <div class="rvtop3-title">호스트 소개</div>
         
         <div id="hostInfo">
            <div class="profile">
                  <div class="profile-img">
                     <c:if test="${doDetail.hostInfo[0].UISTOREDIMGNAME eq null}"> <!-- 사진이 null이면 default -->
                      <img class="img-circle" src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="대표사진" />
                  </c:if>
                  <c:if test="${doDetail.hostInfo[0].UISTOREDIMGNAME ne null}"> <!-- 사진이 null이면 아니면 -->
                      <img class="img-circle" src="<%=request.getContextPath() %>/resources/upload/${doDetail.hostInfo[0].UISTOREDIMGNAME}" alt="대표사진"  />
                  </c:if>
                  </div>
                  
                  <div class="profile-name">
                     <h3>${doDetail.hostInfo[0].UNICK} </h3>
                     <small>${doDetail.hostInfo[0].AGE} 세 · 
                        <c:if test="${doDetail.hostInfo[0].UGENDER eq 1}">
                           남
                        </c:if>
                        <c:if test="${doDetail.hostInfo[0].UGENDER eq 2}">
                           여
                        </c:if>
                     </small>
                     <p>★ ${doDetail.hostInfo[0].STAR} 점</p>
                     
                     
<%--                      <c:choose> --%>
                        
<%--                         <c:when test="${0<=doDetail.hostInfo[0].STAR<0.5}">                    --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                  
<%--                      <c:when test="${0.5<=doDetail.hostInfo[0].STAR < 1 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star0.5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                        
<%--                         <c:when test="${1 <= doDetail.hostInfo[0].STAR < 1.5}">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star1.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                        
<%--                         <c:when test="${1.5 <= doDetail.hostInfo[0].STAR < 2 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star1.5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when>   --%>
                        
<%--                         <c:when test="${2 <= doDetail.hostInfo[0].STAR < 2.5 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star2.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when>  --%>
                        
<%--                         <c:when test="${2.5 <= doDetail.hostInfo[0].STAR < 3 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star2.5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                        
<%--                         <c:when test="${3 <= doDetail.hostInfo[0].STAR < 3.5 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star3.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when>  --%>
                        
<%--                         <c:when test="${3.5 <= doDetail.hostInfo[0].STAR < 4 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star3.5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                        
<%--                         <c:when test="${4 <= doDetail.hostInfo[0].STAR < 4.5 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star4.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when>  --%>
                        
<%--                         <c:when test="${4.5 <= doDetail.hostInfo[0].STAR < 5 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star4.5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
<%--                         <c:when test="${doDetail.hostInfo[0].STAR eq 5 }">                    --%>
<%--                            <p><img style="width: 95px;" id="star" src="<%=request.getContextPath() %>/resources/upload/star5.png" alt="별점"/></p> --%>
<%--                            <p>${doDetail.hostInfo[0].STAR}</p> --%>
<%--                         </c:when> --%>
                         
<%--                      </c:choose> --%>

                  </div>
                  
            </div>
            <!-- 호스트 후기 -->
            <div id="hostcomment">
            <!-- 후기없을때 이거 대신 출력 -->
            <c:if test="${doDetail.doReviewList[0].RBNO eq null}">
               <div class="reviewnot">아직 후기가 없습니다 ㅠ_ㅠ</div>
            </c:if>
                <!-- 이부분 반복 -->
               <c:forEach items="${doDetail.doReviewList}" var="reviewList" end="2">
               
                     <div class="rvtop3-mate">
                        <div class="rvtitle">
                           <div class="rvtimg">
                           <c:if test="${reviewList.UISTOREDIMGNAME eq null}"> <!-- 사진이 null이면 default -->
                               <img src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="대표사진" />
                           </c:if>
                           <c:if test="${reviewList.UISTOREDIMGNAME ne null}"> <!-- 사진이 null이면 아니면 -->
                               <img src="<%=request.getContextPath() %>/resources/upload/${reviewList.UISTOREDIMGNAME}" alt="대표사진"  />
                           </c:if>
                        </div>
<!--                            <div class="rvtimg"><img src="/resources/image/main/profileex.jpg" class="img-circle"/></div> -->
                           <div class="rvttitle">
                              <h4>${reviewList.UNICK}</h4>
                              <h6><fmt:formatDate var="date" value="${reviewList.RBWRITTENDATE}" pattern="YYYY-MM-dd" />${date}</h6>
                              <h6>★ ${reviewList.RBHOSTSTAR} 점</h6>
                           </div>
                        </div>
                        <div class="rvtext">
                              ${reviewList.RBCONTENT}
                        </div>
                     </div>
               </c:forEach>         
            </div><!-- hostcomment end -->
            </div><!-- hostInfo end -->
      </div><!-- hostInfoBox end -->
   
      
      <div id="inform">
         <div class="rvtop3-title">유의사항</div>
         <p><i style="font-weight: bolder; font-style: inherit;">동행 신청시 취소는 불가능 합니다. 아래의 유의사항을 잘 확인하시고 신청해주시기 바랍니다.</i><br>
            - 동행을 취소하거나 일정 변경이 필요한 경우 동행 호스트에게 직접 문의 바랍니다.<br>
            - 동행 참여 인원들은 원할한 여행을 위해 사전에 협의후 동행하시길 권고합니다.<br>
            - 동행 호스트, 메이트 모두 각자의 의견과을 서로 존중해주시고 배려해 주시길 바랍니다.<br>
            - 신청 연락 두절, 불참, 사전 협의 불이행 등 지속적인 신고가 들어오는 경우 DONGHANG COMFUNNY 활동에 제재가 있을 수 있습니다.<br>
            - 모든 금전적인 사항들은 DONGHANG COMFUNNY와는 무관하며, DONGHANG COMFUNNY에서는 금전적 요구를 하지않습니다.<br>
            - 해당 사항들을 지키지 않고 문제가 발생되었을 경우, 저희 DONGHANG COMFUNNY는 책임을 지지 않습니다. 
         </p>
      </div>
      
      <!-- 마지막 버튼 부분 -->      
      <div class="dobtn">
           <div class="ialign float-left btn1">  
               <!-- 신청목록 내용 보여짐 -->
               <a id="dolist" class="btn btn-primary">신청목록</a>
               <c:if test="${logInInfo.uNo eq doDetail.hostInfo[0].UNO}">
                  <a class="btn btn-warning " onclick="location.href='<%=request.getContextPath() %>/do/modify?dbNo=${doDetail.doDetailList[0].DBNO}'">수정</a> 
                 <a class="btn btn-danger" onclick="deleteDoDetail(${doDetail.doDetailList[0].DBNO})">삭제</a> 
              </c:if>
         </div>
         <script type="text/javascript">
            function deleteDoDetail(dbno) {
               console.log("삭제");
               $.ajax({
                  url : "/do/delete"
                  ,type : "post"
                  ,data : { dbno : dbno }
                   ,success : function(result){
                      if(result != 0){
                         var confirm_val = confirm("정말 삭제 하시겠습니까?");
                        if(confirm_val){
                            alert("삭제 완료!");
                           location.href='<%=request.getContextPath()%>/do';               
                        }
                         
                      }else{
                         alert("오류가 발생했습니다. 다시 시도해주세요.");
                         location.href=window.document.URL;
                      }
                   
                   }
                  
                     
               });
            }
         
         </script>
         
         
         
      
            <div class="ialign float-right btn3"> <!-- 공유하기 -->
               <h5 style="display: inline-block; margin: 0 20px; color:#03588C; ">공유하기 : </h5>
               <a title="페이스북" class="btn btn-default" href="#" id="vIconFb" onclick="return false;"><h3 style="margin: 0;">f</h3></a>
             <a title="트위터" class="btn btn-default" href="#" id="vIconTw" onclick="return false;"><h3 style="margin: 0;">t</h3></a> 
               <span title="네이버 카페">
               <script type="text/javascript" src="https://ssl.pstatic.net/share/js/naver_sharebutton.js"></script>
               <script type="text/javascript">
               new ShareNaver.makeButton({"type": "e" , "title":"DongHangComeFunny_함께해요_${doDetail.doDetailList[0].DBTITLE}"});
               </script>
            </span>
            <span title="네이버 블로그">
               <script type="text/javascript" src="//static.naver.net/blog/share/blog_sharebutton.js?v={0}"></script>
               <script type="text/javascript">
               new ShareBlog.makeButton({"type": "d" , "title":"DongHangComeFunny_함께해요_${doDetail.doDetailList[0].DBTITLE}"});
               </script>
            </span>
            </div>

         
         <script type="text/javascript">
            $(window).ready(function(){               
                 $(".btn3 a").click(function(){
                     shareAct(this);
                 });
              
            });
              
            function shareAct(a){
                    var snsCode = $(a).attr('id'); 
                    var cUrl = "window.document.URL";
              
                    switch(snsCode){
              
                        case"vIconTw":
                            //트위터
                            cUrl = 'https://twitter.com/intent/tweet?text=페이지제목:&url='+cUrl;
                        break;
                                            
                        case"vIconFb":
                            //페이스북
                            cUrl = 'http://www.facebook.com/sharer/sharer.php?u='+cUrl+'&title=${doDetail.doDetailList[0].DBTITLE}';
                        break;
              
                    }
              
                    window.open(cUrl,'','width=600,height=300,top=100,left=100,scrollbars=yes');
              
                }
         
         </script>
      </div>
      
      
   </div><!-- contentbox -->
   
   
   <!-- content2 -->
<!-- 신청 목록 박스 -->
<div class="contentbox2"> 
    <!-- 타이틀 -->
   <div class="contitle"> 신청 목록 </div>
      
    <!-- 신청 목록 -->
   <div class="mate-list">      
      <c:forEach items="${doDetail.applyList}" var="aplyList">
         <div class="mateone">
            <div class="mtitle">
               <c:if test="${aplyList.UISTOREDIMGNAME eq null}"> <!-- 사진이 null이면 default -->
                     <img class="img-circle" src="<%=request.getContextPath() %>/resources/image/go/default.png" alt="대표사진" />
               </c:if>
               <c:if test="${aplyList.UISTOREDIMGNAME ne null}"> <!-- 사진이 null이면 아니면 -->
                     <img class="img-circle" src="<%=request.getContextPath() %>/resources/upload/${aplyList.UISTOREDIMGNAME}" alt="대표사진"  />
               </c:if>
<!--             <img src="/resources/image/main/profileex.jpg" class="img-circle"/></div> -->
            <div class="mtitle">
               <h4>${aplyList.UNICK}</h4>
               <h5>${aplyList.AGE}세 ·
                  <c:if test="${aplyList.UGENDER eq 1}">
                          남
                       </c:if>
                       <c:if test="${aplyList.UGENDER eq 2}">
                          여
                       </c:if>
               </h5>
            </div>
         
               <div class="mbtn"> 
                  <!-- 작성자만 볼수 있음 -->
                  <c:if test="${logInInfo.uNo eq doDetail.hostInfo[0].UNO}">
                     <c:choose>
                        <c:when test="${aplyList.DASTATUS eq 0}">
                           <a class="btn btn-primary" onclick="accept(${aplyList.UNO},${doDetail.doDetailList[0].DBNO})">수락</a>
                           <a class="btn btn-default" onclick="refuse(${aplyList.UNO},${doDetail.doDetailList[0].DBNO})">거절</a>                        
                        </c:when>
                        <c:when test="${aplyList.DASTATUS eq 1}">
                           <p style="font-size: 15px; color: #5D7CA6;">수락완료</p>                           
                        </c:when>
                        <c:when test="${aplyList.DASTATUS eq 2}">
                           <p style="font-size: 15px; color: red;">거절완료</p>                           
                        </c:when>
                     </c:choose>
                  </c:if>
               </div>
            </div>
         </div>
      </c:forEach>
   
   </div><!-- mate-list end -->        

<script type="text/javascript">
function accept(uno, dbno) {
   $.ajax({
      url : "/do/acceptdh"
      ,type : "post"
      ,data : { uno : uno, dbno : dbno }
       ,success : function(result){
          console.log(result);
          if(result != "fail"){
             alert("동행 요청이 수락되었습니다.");

             document.querySelector(result).innerHTML = "<p style='font-size: 15px; color: #5D7CA6;'>수락완료</p>";
          }
       
       }
      
         
   });
}

function refuse(uno, dbno) {
//    console.log("거절");
//    console.log("uno : " + uno);
//    console.log("dbno : " + dbno);
   
   $.ajax({
      url : "/do/refusedh"
      ,type : "post"
      ,data : { uno : uno, dbno : dbno }
       ,success : function(result){
          console.log(result);
          if(result != "fail"){
             alert("동행 요청이 거절 되었습니다.");
             
//              console.log(result);
             document.querySelector(result).innerHTML = "<p style='font-size: 15px; color: red;'>거절완료</p>"
          }
       
       }
      
         
   });
}

</script>          
         
         
</div>
   

</div><!-- detail-container -->
   
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
   
</body>
</html>