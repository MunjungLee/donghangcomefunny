<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동행 :: 마이페이지</title>

<!-- jQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>


<!-- CSS -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mydonghang.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/mypage_header.css" >
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/mypage/footer.css" />





<!-- checkBox 전체 체크  js-->
<script type="text/javascript">
//checkBox 전체 체크 
$(document).ready(function () {
   
   $("#deleteChkAll").click(function(){
      if($(this).prop("checked")){
         $(".deleteChk").prop("checked", true);
      }else{
         $(".deleteChk").prop("checked", false);
      }      
      
   })
})
</script>
<script type="text/javascript">
$(document).ready(function() {
   
   $(".golikedeletebtn").click(function(){
       console.log("삭제버튼클릭");

       var confirm_val = confirm("함께가요 찜한 목록을 삭제하시겠습니까?");
    
       if(confirm_val){
          
          var checkArr = new Array();
          
          $("input[class='deleteChk']:checked").each(function() {
             console.log($(this).val());
             checkArr.push($(this).val());
          });
          
          if(checkArr==null || checkArr ==""){
             confirm_val = confirm("삭제할 대상을 선택해 주세요.");
          }else{
             
             $.ajax({
                url : "/mypage/deletegolike"
                ,type : "post"
                ,data : { deleteChk : checkArr }
                ,traditional : true
                ,success : function(result){
                   if(result == 1){
                      alert("함께가요 찜목록이 삭제되었습니다.");
                      location.href=window.document.URL;
                   }else{
                      alert("삭제 실패");
                }
             }
             
             });
          }
          
    
       }
    })
   
})
</script>
</head>
<body>

<c:import url="mypage_header.jsp" />


<!-- 본문 -->   
<div class="container" id="myDongHang">
   <div id="dongHangBtn">
      <!-- 함께가요  -->
      <div id="switchBlock1" onclick="location.href='#'"></div>
      <!-- 함께해요  -->
      <div id="switchBlock2" onclick="location.href='/mypage/likelist'"></div>
      <div>
         <img id="myDongHangBtn" alt="함께가요" src="/resources/image/mypage/golike.png">
      </div>
   </div>
   
   <!-- 함께가요 테이블 -->
   <div id="donghangform">
      <div id="donghangformTitle">함께가요</div>
      <button id="deleteBtn" class="golikedeletebtn" type="button">삭제</button>
   
      <table id="donghangtable" class="table table-hover table-bordered">
         <tr>
            <th style="width: 5%"><input type="checkbox" id="deleteChkAll"/></th>
            <th style="width: 20%">작성일</th>
            <th style="width: 50%">제목</th>
            <th style="width: 25%">작성자</th>
      
         </tr>
         <c:forEach items="${golikeList.golist }" var="list">
         <tr>
            <td style="vertical-align: inherit;"><input type="checkbox"class="deleteChk" value="${list.GBNO }" /></td>
               <td style="vertical-align: inherit;"><fmt:formatDate var="date" value="${list.GBWRITTENDATE}" pattern="YYYY-MM-dd"/>${date}</td>
               <td style="vertical-align: inherit;"><a href="<%=request.getContextPath() %>/go/goDetail?gbNo=${list.GBNO }">${list.GBTITLE }</a></td>
               <td style="vertical-align: inherit;">${list.USERID }</td>
         </tr>
         </c:forEach>
      </table>
   </div>
   <!-- 페이징 처리 -->
   <nav aria-label="Page navigation" style="text-align: center;">
        <ul class="pagination">
          <li>
            <a href="<%= request.getContextPath() %>/mypage/golike" aria-label="Previous">
              <span aria-hidden="true">&laquo;</span>
            </a>
            
            <c:choose>
               <c:when test="${paging.blockStart > 1 }">
                  <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.currentPage-1}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
               </c:when>
               
               <c:when test="${paging.currentPage eq 1 }">
                  <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.blockStart}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
               </c:when>
               
               <c:otherwise>
                  <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.currentPage-1}" aria-label="Previous">
                    <span aria-hidden="true">&lt;</span>
                  </a>
                 </c:otherwise>
            </c:choose>
            
            <c:forEach begin="${paging.blockStart}" end="${paging.blockEnd}" var="page">
                  <li><a href="<%= request.getContextPath() %>/mypage/golike?cPage=${page}"><span>${page}</span></a></li>
             </c:forEach> 
            
          </li>
          
          <li>
             <c:choose>
                    <c:when test="${paging.currentPage eq paging.lastPage }">
                        <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.blockEnd}" aria-label="Next">
                          <span aria-hidden="true">&gt;</span>
                     </a>
                    </c:when>
                 <c:otherwise>
                        <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.currentPage+1}" aria-label="Next">
                          <span aria-hidden="true">&gt;</span>
                     </a>
                </c:otherwise>
                  </c:choose>
          
          
            <a href="<%= request.getContextPath() %>/mypage/golike?cPage=${paging.lastPage}" aria-label="Next">
              <span aria-hidden="true">&raquo;</span>
            </a>
          </li>
        </ul>
   </nav>

</div>



<c:import url="footer.jsp" />


</body>
</html>