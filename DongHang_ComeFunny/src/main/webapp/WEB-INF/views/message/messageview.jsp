<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />

<meta charset="UTF-8">
<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
	<div id="div_back" style="min-height:33500px;">
		<div id="div_left_area">
			<div id="div_line_left_mail">
							<div id="div_mail" onclick="location.href ='/message/send'">쪽지쓰기</div>
			<div>
				<!-- [D] 마우스오버시 li에 ovr, 클릭시 li에 click 클래스 추가 -->
				<ul class="left_mail_menu">
						<li><a href="/message/receivelist">받은쪽지함</a></li>
						<li><a href="/message/sendlist">보낸쪽지함</a></li>
						<li><a href="/message/mymsglist">내게쓴쪽지함</a></li>
						<li><a href="/message/storelist">쪽지보관함</a></li>
					</ul>
				</div>
			</div>
		</div>
		<div id="div_right_area">
			<div style="height: 7.5%;">
		
							<div id="mail_top_btn" onclick="fn_userDel()" style="margin-left:2px; border-radius:5px 0px 0px 5px;">
							삭제</div>
							<div  id="mail_top_btn" onclick="fn_userStore()" style="border-width: 2px 0px 2px 0px;">
							보관</div>
							<div  id="mail_top_btn" onclick = "fn_userReply()"style="border-radius:0px 5px 5px 0px;">
							답장</div>	
							
			</div>
			<div></div>	
			<div id="div_msg_info">
				<span id="span_msg_fixed">받는사람</span><span>${message.sender.getUserId() }</span>
				<br>
				<span id="span_msg_fixed">받은시간</span><span><fmt:formatDate value="${message.message.getMsWrittenTime() }" pattern="yyyy-MM-dd HH:mm" /> </span>
			</div>
			<div id="div_msg_content">
				<pre style="white-space: pre-wrap;">
					${message.message.getMsContent() }
				</pre>	
							
			</div>
		</div>
	</div>
<c:import url="/WEB-INF/views/board/boardfooter.jsp" />

<script>
function fn_userDel(){
	var agree=confirm("삭제 하시겠습니까?");
    if (agree){
    	location.href = "/message/delete?msno=${message.message.getMsNo() }";
    }
}﻿
  function fn_userStore(){
		                               
	  var agree=confirm("보관 하시겠습니까?");
	     if (agree){
	    	 location.href = "/message/store?msno=${message.message.getMsNo() }";
	     }
  }
  function fn_userReply(){
	  var agree=confirm("답장 하시겠습니까?");
	     if (agree){
	    	 location.href = "/message/send?msno=${message.message.getMsNo() }";
	     }
  }

</script>
