<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/header.jsp" />

<link rel="stylesheet" href="/resources/css/admin/adminMain.css">

<script type="text/javascript">
$(document).ready(function(){
   $("#user").mouseover(function(){
      $("#info1").text("회원 관리")
      $("#info2").text("회원의 목록조회, 상세조회, 정보수정 및 삭제가 가능합니다")
      $("#info3").text("목록조회 : 전체 회원의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 해당 회원의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("정보수정 : 해당 회원의 정보를 DB에서 수정합니다.")
      $("#info6").text("회원삭제 : 해당 회원의 정보를 DB에서 삭제합니다.")
   })
   
   $("#board").mouseover(function(){
      $("#info1").text("게시판 관리")
      $("#info2").text("각 게시판의 목록조회, 상세조회, 게시글 삭제가 가능합니다")
      $("#info3").text("목록조회 : 전체 게시글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 해당 게시글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("게시글삭제 : 해당 게시글을 DB에서 삭제합니다.")
      $("#info6").text("")
   })
   
   $("#doBoard").mouseover(function(){
      $("#info1").text("함께해요 게시판 관리")
      $("#info2").text("함께해요 게시판의 목록조회, 상세조회, 게시글 삭제가 가능합니다")
      $("#info3").text("목록조회 : 함께해요 게시글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 함께해요 게시글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("게시글삭제 : 함께해요 게시글을 DB에서 삭제합니다.")
      $("#info6").text("")
   })
   
   $("#goBoard").mouseover(function(){
      $("#info1").text("함께가요 게시판 관리")
      $("#info2").text("함께가요 게시판의 목록조회, 상세조회, 게시글 삭제가 가능합니다")
      $("#info3").text("목록조회 : 함께가요 게시글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 함께가요 게시글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("게시글삭제 : 함께가요 게시글을 DB에서 삭제합니다.")
      $("#info6").text("")
   })
   
   $("#freeBoard").mouseover(function(){
      $("#info1").text("자유 게시판 관리")
      $("#info2").text("자유 게시판의 목록조회, 상세조회, 게시글 삭제가 가능합니다")
      $("#info3").text("목록조회 : 자유 게시글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 자유 게시글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("게시글삭제 : 자유 게시글을 DB에서 삭제합니다.")
      $("#info6").text("")
   })
   
   $("#reviewBoard").mouseover(function(){
      $("#info1").text("후기 게시판 관리")
      $("#info2").text("후기 게시판의 목록조회, 상세조회, 게시글 삭제가 가능합니다")
      $("#info3").text("목록조회 : 후기 게시글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 후기 게시글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("게시글삭제 : 후기 게시글을 DB에서 삭제합니다.")
      $("#info6").text("")
   })
   
   $("#question").mouseover(function(){
      $("#info1").text("1대1문의 관리")
      $("#info2").text("1대1문의의 목록조회, 상세조회, 문의글 삭제, 답변작성 및 수정, 삭제가 가능합니다")
      $("#info3").text("목록조회 : 1대1문의글의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 1대1문의글의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("문의글삭제 : 1대1문의글을 DB에서 삭제합니다.")
      $("#info6").text("답변작성 : 1대1문의글에 대한 답변을 DB에 작성합니다.")
      $("#info7").text("답변수정 : 이미 작성된 1대1문의글에 대한 답변을 DB에서 수정합니다.")
      $("#info8").text("답변삭제 : 이미 작성된 1대1문의글을 DB에서 삭제합니다.")
   })
   
   $("#notice").mouseover(function(){
      $("#info1").text("공지사항 관리")
      $("#info2").text("공지사항의 목록조회, 상세조회, 공지사항 작성 및 수정, 삭제가 가능합니다")
      $("#info3").text("목록조회 : 공지사항의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 공지사항의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("공지사항삭제 : 공지사항을 DB에서 삭제합니다.")
      $("#info6").text("공지사항작성 : 새로운 공지사항을 DB에 작성합니다.")
      $("#info7").text("공지사항수정 : 이미 작성된 공지사항을 DB에서 수정합니다.")
      $("#info8").text("")
   })
   
   $("#payment").mouseover(function(){
      $("#info1").text("결제 관리")
      $("#info2").text("결제내역의 목록조회, 상세조회, 삭제가 가능합니다")
      $("#info3").text("목록조회 : 결제내역의 리스트를 DB에서 조회합니다.")
      $("#info4").text("상세조회 : 결제내역의 상세정보를 DB에서 조회합니다.")
      $("#info5").text("결제내역삭제 : 결제내역을 DB에서 삭제합니다.")
      $("#info6").text("")
      $("#info7").text("")
      $("#info8").text("")
   })
   
   $("li").mouseleave(function(){
      $("#info1").text("환영합니다 관리자님")
      $("#info2").text("기능을 선택해주세요")
      $("#info3").text("오늘 가입 회원 : ")
      $("#info4").text("오늘 결재 내역 : ")
      $("#info5").text("오늘 작성 글 : ")
      $("#info6").text("")
      $("#info7").text("")
      $("#info8").text("")
   })
   
   
});

</script>



<div class="adminMain">
   <div id="adminMenuInfo">
      <ul style="list-style: none;">
         <li><span id="info1">환영합니다 관리자님</span></li> 
         <li><span id="info2">기능을 선택해주세요</span></li>
         <li><span id="info3">오늘 가입 회원 : </span></li>
         <li><span id="info4">오늘 결재 내역 : </span></li>
         <li><span id="info5">오늘 작성 글 : </span></li>
         <li><span id="info6"></span></li>
         <li><span id="info7"></span></li>
         <li><span id="info8"></span></li>
      </ul>
   </div>
    <div class="menuBar">
       <ul class="mainMenu">
          <li><a href="user/list" id="user">회원관리</a></li>
          <li><a href="boards/main" id="board">게시판 관리</a>
             <ul class="boardMenu">
                <li><a href="boards/goBoard/list" id="goBoard">함께가요 게시판</a></li>
                <li><a href="boards/doBoard/list" id="doBoard">함께해요 게시판</a></li>
                <li><a href="boards/freeBoard/list" id="freeBoard">자유 게시판</a></li>
                <li><a href="boards/reviewBoard/list" id="reviewBoard">후기 게시판</a></li>
             </ul>
          </li>
          <li><a href="question/list" id="question">1대1문의 관리</a></li>
          <li><a href="notice/list" id="notice">공지사항 관리</a></li>
          <li><a href="order/list" id="payment">결제 관리</a></li>
       </ul>
    </div>
</div>

<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />    