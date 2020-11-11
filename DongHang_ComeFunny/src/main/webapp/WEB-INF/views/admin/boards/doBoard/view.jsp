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
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">


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

$(function() {

	  var UI = {
	    init: function() {
	      this.quickMenuFn();
	      this.topBtn();
	    },

	    initialize: function() {
	      this.id = {
	        target: {
	          quick: '.rightQuickBar',
	          stickyTop: '#footer'
	        },
	        topBtnClass: 'btn_top'
	      };
	      this.init();
	    },

	    quickMenuFn: function() {
	      var quick = $(this.id.target.quick);
	      var qTop = parseInt(quick.css('top'));

	      $(window).scroll(function() {
	        var winTop = $(window).scrollTop();

	        quick.stop().animate({
	          top: winTop + qTop
	        }, 400);

	      })
	    },

	    topBtn: function() {
	      var btnLocation = $('.' + this.id.topBtnClass);
	      var timerId = 0;

	      $(window).on('scroll', function() {
	        var winTop = $(window).scrollTop();
	        if (winTop > 200) {
	          btnLocation.fadeIn();
	          clearInterval(timerId);
	          timerId = setInterval(btnEffet, 2000);
	        } else {
	          btnLocation.fadeOut();
	          clearInterval(timerId);
	        }

	      });

	      function btnEffet() {
	        btnLocation.fadeTo('300', 0.3).fadeTo('300', 1);
	      }

	      this.scrollTop(btnLocation);
	    },

	    scrollTop: function(eTarget, speed) {
	      var speed = speed || null;
	      eTarget.on('click', function() {
	        $('html, body').animate({
	          scrollTop: $("body").offset().top
	        }, speed)
	      })
	    }

	  };

	  $(function() {
	    UI.initialize();
	  })

	})
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
      </div>
   </div>
   
   <div class="rightQuickBar">
  	<ul class="mainMenu">
  		<li><a href="/admin/user/list">회원관리</a></li>
  		<li><a href="/admin/boards/main">게시판 관리</a></li>
  		<li><a href="/admin/question/list">1대1문의 관리</a></li>
  		<li><a href="/admin/notice/list">공지사항 관리</a></li>
  		<li><a href="/admin/order/list">결제 관리</a></li>
  	</ul>
  </div>
  
    <p class="btn_top"><a href="#none">top</a></p>
   

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
             </div>
               <c:choose>
                  <c:when test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 0}">
                     <div class="gotag">모집중</div>
                  </c:when>
                  <c:when test="${doDetail.doDetailList[0].DBRECRUITSTATUS eq 1}">
                     <div class="gotag2">모집마감</div>
                  </c:when>
               </c:choose>
           
           
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
                   
              </div>
           
         </div>
      </div>
      
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
         
            </div>
         </div>
      </c:forEach>
   
   </div><!-- mate-list end -->        

         
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