<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>함께가요 :: 수정하기</title>
<!-- goForm.css -->
<link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/go/goForm.css" />

<!-- JQuery -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>

<!-- 부트스트랩 -->
<!-- 합쳐지고 최소화된 최신 CSS -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<!-- 부가적인 테마 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<!-- 합쳐지고 최소화된 최신 자바스크립트 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>
</head>

<!-- <form>태그의 submit을 수행하면 editor에 작성한 내용을 <textarea>에 반영 -->
<script type="text/javascript">
function submitContents(elClikedObj) {
   
   //에디터의 내용을 #content에 반영
   oEditors.getById["goContent"].exec("UPDATE_CONTENTS_FIELD", []);
   
   try {
      
      
      elClikedObj.form.submit();
      
      
   } catch(e) {
      
   }
   
   
}
</script>

<script type="text/javascript">
$(document).ready(function () {
   //체크박스, 라디오 박스 비활성화
   $("input[type='checkbox']").prop('disabled', true);
   $("input[type='radio']").prop('disabled', true);
   
   //작성시 내용 연결
   $("#btnWrite").click(function() {
      //스마트에디터의 내용을 <textarea>에 적용하는 함수 호출
      submitContents($("#btnWrite"));
      
      //공백 제어
      if($("#inputdate").val() == null || $("#inputdate").val() == ''){
         alert("날짜은 필수 선택 값 입니다")
      }
      else if($("#inputarea").val() == null || $("#inputarea").val() ==''){
         alert("지역은 필수 선택 값 입니다")
      }
      else if($("#inputstatus").val() == null || $("#inputstatus").val() ==''){
         alert("상태는 필수 선택 값 입니다")
      }
      else if($("#inputtitle").val() == null || $("#inputtitle").val() ==''){
         alert("글 제목은 필수 입력 값 입니다")
      }
      else if($("#inputrenum").val() == null || $("#inputrenum").val() ==''){
         alert("인원수는 필수 선택 값 입니다.")
      }
      else if(!($("input:radio[name='gbRecruitGender']").is(':checked'))){
         alert("성별은 필수 선택 값 입니다.")
      }
      else if($("input:checkbox[name='gcAgeGroup']:checked").length < 1){
         alert("모집 연령대를 하나 이상 체크해주세요.")
      }
      else if($("input:checkbox[name='gcTheme']:checked").length < 1){
         alert("여행 타입을 하나 이상 체크해주세요.")
      }
      else{
         //submit
         $(this).parents("form").submit();   
      }

   });

   //취소버튼 동작
   $("#btnCancel").click(function() {
      history.go(-1);
   });
   
   
});
   
</script>

<body>
<div class="body-container">


<!-- content -->
<form action="<%=request.getContextPath() %>/go/updatemodify" method="post" enctype="multipart/form-data" id="formid">
<input type="hidden" name="gbNo" value="${goboard.goBoardUserInfo.GBNO }">
   <div class = "gowrite"> 
      <div class = "gowritebox">
         <!-- title -->
         <div class = "gowrite-title">
            <div class = "gowrite-label" ><span>함께가요</span></div>
            <span class="gowrite-text">동행 모집하기</span>
         </div>
         
         <!-- table -->
         <table class="gowrite-table">
         <tr>
            <td>카테고리</td>
            <td colspan="3">
            <div class="tdleft">
               <select name="gbRecruitDate" class="selectbox" id="inputdate" disabled>
                        <option value="snone" disabled="disabled">날짜</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITDATE eq 1}">selected</c:if> value="1">1월-3월</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITDATE eq 2}">selected</c:if> value="2">4월-6월</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITDATE eq 3}">selected</c:if> value="3">7월-9월</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITDATE eq 4}">selected</c:if> value="4">10월-12월</option>
                   </select>
                   
                   <select name="gbRecruitArea" class="selectbox" id="inputarea" disabled>
                        <option value="none" disabled="disabled">지역</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'seoul'}">selected</c:if> value="seoul">서울</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'jeju'}">selected</c:if> value="jeju">제주</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'incheon'}">selected</c:if> value="incheon">인천</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'daegu'}">selected</c:if> value="daegu">대구</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'busan'}">selected</c:if> value="busan">부산</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'daejeon'}">selected</c:if> value="daejeon">대전</option>
                        <option <c:if test="${goboard.goBoardUserInfo.GBRECRUITAREA eq 'gyang'}">selected</c:if> value="gyang">광주</option>
                   </select>
                   
                   <!-- 수정 가능  -->
                   <select name="gbRecruitStatus" class="selectbox" id="inputstatus">
                        <option value="0" <c:if test="${goboard.goBoardUserInfo.GBRECRUITSTATUS eq 0}">selected</c:if>>모집중</option>
                        <option value="1" <c:if test="${goboard.goBoardUserInfo.GBRECRUITSTATUS eq 1}">selected</c:if>>모집마감</option>
                   </select>
               </div>
            </td>
         </tr>
         <tr>
            <td>글 제목</td>
            <td>
               <input type="text" name="gbTitle" class="form-control" value="${goboard.goBoardUserInfo.GBTITLE}" id="inputtitle">
            </td>
            <td>모집 인원수</td>
            <td>
               <select name="gbRecruitNumber" class="selectbox" id="inputrenum" disabled>
                        <option value="1" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 1}">selected</c:if>>1</option>
                        <option value="2" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 2}">selected</c:if>>2</option>
                        <option value="3" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 3}">selected</c:if>>3</option>
                        <option value="4" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 4}">selected</c:if>>4</option>
                        <option value="5" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 5}">selected</c:if>>5</option>
                        <option value="6" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 6}">selected</c:if>>6</option>
                        <option value="7" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 7}">selected</c:if>>7</option>
                        <option value="8" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 8}">selected</c:if>>8</option>
                        <option value="9" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 9}">selected</c:if>>9</option>
                        <option value="10" <c:if test="${goboard.goBoardUserInfo.GBRECRUITNUMBER eq 10}">selected</c:if>>10</option>
                   </select>
            </td>
         </tr>
         <tr>
            <td>모집 성별</td>
            <td colspan="3">
               <div class="tdleft" id="inputgender"> 
                  <span><input type="radio" name="gbRecruitGender" value="0" <c:if test="${goboard.goBoardUserInfo.GBRECRUITGENDER eq 0}">checked</c:if>><span>무관</span></span>
                  <span><input type="radio" name="gbRecruitGender" value="1" <c:if test="${goboard.goBoardUserInfo.GBRECRUITGENDER eq 1}">checked</c:if>><span>남성만</span></span>
                  <span><input type="radio" name="gbRecruitGender" value="2" <c:if test="${goboard.goBoardUserInfo.GBRECRUITGENDER eq 2}">checked</c:if>><span>여성만</span></span>
               </div>
            </td>
         </tr>
         <tr>
            <td>모집 연령대</td>
            <td colspan="3"> 
               <div class="tdleft" id="inputage" >
                <c:set value="${goboard.goChecklist.GCVALUE2}" var="goValue"/>
                  <span><label><input type="checkbox" name="gcAgeGroup" value="20" class="deleteChk" 
                     <c:if test="${fn:contains(goValue,'20') }">checked</c:if>><span>20대</span></label></span>
                     <span><label><input type="checkbox" name="gcAgeGroup" value="30" class="deleteChk"
                        <c:if test="${fn:contains(goValue,'30') }">checked</c:if>><span>30대</span></label></span>
                     <span><label><input type="checkbox" name="gcAgeGroup" value="40" class="deleteChk"
                        <c:if test="${fn:contains(goValue,'40') }">checked</c:if>><span>40대</span></label></span>
               </div>
            </td>
         </tr>
         <tr>
            <td>여행 타입</td>
            <td colspan="3">
               <div class="tdleft" id="inputtype">
                  <span><label><input type="checkbox" name="gcTheme" value="food" 
                     <c:if test="${fn:contains(goValue,'food') }">checked</c:if>><span>음식</span></label></span>
                   <span><label><input type="checkbox" name="gcTheme" value="photo" 
                      <c:if test="${fn:contains(goValue,'photo') }">checked</c:if>><span>사진</span></label></span>
                   <span><label><input type="checkbox" name="gcTheme" value="seeing"
                      <c:if test="${fn:contains(goValue,'seeing') }">checked</c:if>><span>관광</span></label></span>
                   <span><label><input type="checkbox" name="gcTheme" value="drink"
                      <c:if test="${fn:contains(goValue,'drink') }">checked</c:if>><span>술</span></label></span>
                   <span><label><input type="checkbox" name="gcTheme" value="shopping"
                      <c:if test="${fn:contains(goValue,'shopping') }">checked</c:if>><span>쇼핑</span></label></span>
                   <span><label><input type="checkbox" name="gcTheme" value="etc"
                      <c:if test="${fn:contains(goValue,'etc') }">checked</c:if>><span>기타</span></label></span>
               </div>
            </td>
         </tr>
         <tr>
            <td colspan="4">
               <textarea id="goContent" name="gbContent" class="gotextarea">${goboard.goBoardUserInfo.GBCONTENT}</textarea>
            </td>
         </tr>
         <tr>      
            <td colspan="4">
            <div class="tdright">
               <span><input type="button" class ="btn btn-primary btnsize" value="수정완료" id="btnWrite"></span>
               <span><input type="button" value="수정취소" class="btn btn-default btnsize" id="btnCancel"/></span>
            </div>
            </td>
            
         </tr>
         </table>
      </div>
   </div>
</form>
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
<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
   oAppRef: oEditors,
   elPlaceHolder: "goContent", // 에디터가 적용되는 <textarea>의 id
   sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
   fCreator: "createSEditor2",
   htParams: {
      bUseToolbar: true, //툴바 사용여부
      bUseVerticalResizer: false, //입력창 크기 조절 바
      bUseModeChanger: true //글쓰기 모드 탭
   }
});
</script>



</body>
</html>