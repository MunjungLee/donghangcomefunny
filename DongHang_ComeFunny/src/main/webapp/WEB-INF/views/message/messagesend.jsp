<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.DongHang_ComeFunny.www.model.vo.User" %>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />

<meta charset="UTF-8">
<script type="text/javascript">
   function abba() {
      var length = document.getElementById("textarea_send").value.length;

      document.getElementById("counter").innerHTML = length + " / 2000자";
      if (length >= 2000) {
         document.getElementById("counter").innerHTML = "2000 / 2000자";
      }
   };
   function showPopup(){
      var popupWidth = 1000;
      var popupHeight = 500;
      var popupX = (window.screen.width / 2) - (popupWidth / 2);
      var popupY= (window.screen.height / 2) - (popupHeight / 2);
      window.open("/message/userSearch", "userSearch", "width=1000, height=500, left="+popupX+", top="+popupY); }
   function check(box){

      if(box.checked == true)
   {

      <%
         User user = (User) session.getAttribute("logInInfo");
      %>

      document.getElementById("userid").value="<%= user.getUserId()%>";

   }
      else
   {
         document.getElementById("userid").value="";
      }
}


</script>

<link rel="stylesheet"
   href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
   <div id="div_back">
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

            <div id="mail_top_btn" style=" margin-left: 2px; border-radius: 5px;" onclick="fn_send()">
               보내기</div>


         </div>

         <div id="div_msg_info" style="padding: 30px 0px; ">
         
         
         <div style="margin: 0px 20px">
            <span id="span_msg_fixed ">받는사람</span>
            <input type="checkbox" onclick="check(this)"/><span style="font-size: 0.8em;">내게쓰기</span>
            
            <input type="text" id="userid"style="height: 20px; width: 300px" value="${message.receiver.getUserId() }" />
            <input type="button" id="btn_msg_search" value="검색하기" onclick="showPopup();"/>
            
   </div>
         </div>
         
      <div style="width:570px;">
         <span>제목</span><input style="width:510px" type="text" id="title">
         <div id="div_msg_content" >
            <textarea onKeyUp="javascript:abba()" id="textarea_send" class="textarea_send" maxlength="2000"></textarea>
            
            <br>
            <div style="float:right; margin:0px 40px"><span style="color: black;" id="counter">0 / 2000자</span></div>
         </div>
         
      </div>   
</div>

   </div>
<c:import url="/WEB-INF/views/board/boardfooter.jsp" />
<script>
function getTimeStamp() {
    var d = new Date();
    var s =
      leadingZeros(d.getFullYear(), 4)+
      leadingZeros(d.getMonth() + 1, 2)+
      leadingZeros(d.getDate(), 2) +
      leadingZeros(d.getHours(), 2)+
      leadingZeros(d.getMinutes(), 2)+
      leadingZeros(d.getSeconds(), 2);
      
    return s;
  }
function leadingZeros(n, digits) {
    var zero = '';
    n = n.toString();

    if (n.length < digits) {
      for (i = 0; i < digits - n.length; i++)
        zero += '0';
    }
    return zero + n;
  }
function fn_send(){
   if(confirm('전송  하시겠습니까?')){
       var form=document.createElement("form");
        form.name='formact';
        form.method='post';
        form.action='/message/send'; 
        
        var input=document.createElement("input");
        input.type="hidden";
        input.name='receiver';
        input.value= document.getElementById("userid").value; 
        var input2=document.createElement("input");
        input2.type="hidden";
        input2.name='content';
        input2.value= document.getElementById("textarea_send").value;
        form.appendChild(input)
        form.appendChild(input2)
        var input3=document.createElement("input");
        input3.type="hidden";
        input3.name='date';
        var d = new Date()
        var input4 = document.createElement("input");
        input4.type="hidden";
        input4.name='title';
        input4.value= document.getElementById("title").value;
         var fcwrittendate = getTimeStamp(); 
        input3.value=fcwrittendate
        form.appendChild(input)
        form.appendChild(input2)
        form.appendChild(input3)
        form.appendChild(input4)
        document.body.appendChild(form);
        form.submit();
      
   }
}

</script>