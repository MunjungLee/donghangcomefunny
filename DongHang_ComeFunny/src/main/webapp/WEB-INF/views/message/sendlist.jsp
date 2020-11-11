<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />

<meta charset="UTF-8">
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
      <div style="height: 7%;">

         <div id="mail_top_btn" onclick=fn_userDel()
            style="margin-left: 2px; border-radius: 5px 0px 0px 5px;">삭제</div>
         <div id="mail_top_btn" onclick=fn_userStore()
            style="border-width: 2px 2px 2px 0px; border-radius: 0px 5px 5px 0px;">보관</div>


      </div>
      <div>
         <div>
            <div>
               <table class="table table-bordered table-hover">
                  <thead>
                     <tr>
                        <th style="width: 5%;"><input id="allCheck" name="allCheck"
                           class="allCheck" type="checkbox" onclick="allChk(this);" /></th>
                        <th style="width: 20%;">받는사람</th>
                        <th style="width: 55%;">제목</th>
                        <th style="width: 20%;">날짜</th>
                     </tr>
                  </thead>
                  <tbody>
                     <tr>

                        <c:forEach items="${SendMsgData.mList }" var="send">
                           <tr>
                              <td><input name="RowCheck" class="RowCheck"
                                 type="checkbox" value="${send.MSNO }"
                                 onclick="rowChk(this);" /></td>
                              <td>${send.receiverid }</td>
                              <td><a
                                 href="<%=request.getContextPath() %>/message/messagesendview?msno=${send.MSNO }">${send.MSTITLE }</a></td>
                              <td><fmt:formatDate value="${send.MSWRITTENTIME}"
                                    pattern="yyyy-MM-dd HH:mm" /></td>
                           </tr>
                        </c:forEach>
                     </tr>

                  </tbody>
               </table>

            </div>
         </div>
      
      </div>
<nav aria-label="Page navigation" style="text-align: center;">
        <ul class="pagination">
          <li>
            <a href="<%= request.getContextPath() %>/message/sendlist" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
            
            <c:choose>
               <c:when test="${paging.blockStart > 1 }">
                  <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.currentPage-1}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
               </c:when>
               
               <c:when test="${paging.currentPage eq 1 }">
                  <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.blockStart}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
               </c:when>
               
               <c:otherwise>
                  <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.currentPage-1}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
                 </c:otherwise>
            </c:choose>
            
            <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
                  <li><a href="<%= request.getContextPath() %>/message/sendlist?cPage=${page}"><span>${page}</span></a></li>
             </c:forEach> 
            
          </li>
          
          <li>
             <c:choose>
                    <c:when test="${paging.currentPage eq paging.lastPage }">
                        <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.blockEnd}" aria-label="Next">
                          <span aria-hidden="true">&gt;</span>
                     </a>
                    </c:when>
                 <c:otherwise>
                        <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.currentPage+1}" aria-label="Next">
                          <span aria-hidden="true">&gt;</span>
                     </a>
                </c:otherwise>
                  </c:choose>
          
          
            <a href="<%= request.getContextPath() %>/message/sendlist?cPage=${paging.lastPage}" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>         
          
        </ul>
   </nav>

   </div>

</div>


<c:import url="/WEB-INF/views/board/boardfooter.jsp" />

<script type="text/javascript">
   // 1.모두 체크
   function allChk(obj) {
      var chkObj = document.getElementsByName("RowCheck");
      var rowCnt = chkObj.length - 1;
      var check = obj.checked;
      if (check) {
         for (var i = 0; i <= rowCnt; i++) {
            if (chkObj[i].type == "checkbox")
               chkObj[i].checked = true;
         }
      } else {
         for (var i = 0; i <= rowCnt; i++) {
            if (chkObj[i].type == "checkbox") {
               chkObj[i].checked = false;
            }
         }
      }
   }

   // 2. 체크박스 선택된 것 삭제 처리 (N개) 
   function fn_userDel() {
      var recMsg = "";
      var msgChk = document.getElementsByName("RowCheck");
      var chked = false;
      var indexid = false;
      for (i = 0; i < msgChk.length; i++) {
         if (msgChk[i].checked) {
            if (indexid) {
               recMsg = recMsg + '-';
            }
            recMsg = recMsg + msgChk[i].value;
            indexid = true;
         }
      }
      if (!indexid) {
         alert("삭제할 메일을 체크해 주세요");
         return;
      }

      var agree = confirm("삭제 하시겠습니까?");
      if (agree) {
         location.href = "/message/delete?msno=" + recMsg;
         ;
      }
   }
   function fn_userStore() {
      var recMsg = "";
      var msgChk = document.getElementsByName("RowCheck");
      var chked = false;
      var indexid = false;
      for (i = 0; i < msgChk.length; i++) {
         if (msgChk[i].checked) {
            if (indexid) {
               recMsg = recMsg + '-';
            }
            recMsg = recMsg + msgChk[i].value;
            indexid = true;
         }
      }
      if (!indexid) {
         alert("보관할 메일을 체크해 주세요");
         return;
      }

      var agree = confirm("보관 하시겠습니까?");
      if (agree) {
         location.href = "/message/store?msno=" + recMsg;
         ;
      }
   }
   function fn_userReply() {

      var recMsg = "";
      var msgChk = document.getElementsByName("RowCheck");
      var chked = false;
      var indexid = false;
      var checked = true;
      for (i = 0; i < msgChk.length; i++) {

         if (msgChk[i].checked) {
            if (!indexid && checked) {

               recMsg = msgChk[i].value;
               indexid = true;
               checked = false;
               continue
            }
            if (!checked && indexid) {
               alert("하나의 메일을 체크해 주세요");
               return;
            }
         }

      }

      if (!indexid) {
         alert("답장할 메일을 체크해 주세요");
         return;
      }
      var agree = confirm("답장 하시겠습니까?");
      if (agree) {
         location.href = "/message/send?msno=" + recMsg;
         ;
      }

   }
   function rowChk() {

      var memberChk = document.getElementsByName("RowCheck");
      var allChk = document.getElementById("allCheck");
      var isChk = 0;
      for (i = 0; i < memberChk.length; i++) {
         if (memberChk[i].checked) {
            isChk++;
         }
      }
      if (isChk == memberChk.length) {
         allChk.checked = true;
      } else {
         allChk.checked = false;
      }
   };
</script>


   