<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/user/adminUserView.css">
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

<script type="text/javascript">


$(document).ready(function(){
   $("#userList").click(function(){
         history.go(-1);
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


<div class="userView">
      <table class="userInfoTable" border="1">
      <caption>결제 상세정보</caption>
      <tr>
         <td>결제번호</td>
         <td>${Order.pONo}</td>
      </tr>
      <tr>
         <td>구매자</td>
         <td>${Order.buyer}</td>
      </tr>
      <tr>
         <td>결제명</td>
         <td>${Order.oName}</td>
      </tr>
      <tr>
         <td>구매갯수</td>
         <td>${Order.oQunatity}</td>
      </tr>
      <tr>
         <td>결제날짜</td>
         <td>${Order.oDate}</td>
      </tr>
      <tr>
         <td>결제금액</td>
         <td>${Order.oPrice}</td>
      </tr>
   </table>
   
   <hr>
   <div style="text-align: center;">
      <div>
         <button class="userViewToolbar" id="userList">목록</button>
      </div>
   </div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    