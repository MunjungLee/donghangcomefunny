<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/admin/layout/serviceCenterHeader.jsp" />

 

<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"> </script>
 
<script type="text/javascript">
//<form>이 submit되면
//스마트 에디터 내용을 <textarea>반영해주는 함수
function submitContents(elClickedObj) {
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["qbContent"].exec("UPDATE_CONTENTS_FIELD", []);

	try {
		elClickedObj.form.submit(); // <form> submit 수행
	} catch(e) {}
}



</script>

<script type="text/javascript">
$(document).ready(function() {
	
	//작성버튼 동작
	$("#btnWrite").click(function() {

		// 스마트에디터의 내용을 <textarea>에 적용
		submitContents( $("#btnWrite") );
		
		// form submit
		$("form").submit();
	});
	
	//취소버튼 동작
	$("#btnCancel").click(function() {
		history.go(-1);
	});
});


</script>




<div class = "freewrite"> 
	<div class = "freewrite__border">
	<div class = "freewrite__header">
		<div class = "freewrite__header__label">
			<span>1대1문의</span>
		</div>
		<span class = "freewrite__header__title">글쓰기</span>
	</div>
	<div class = "freewrite__table">
		<form action="writeImpl" method="post" enctype="multipart/form-data">
		<table>
		<tr>
			<td>제목</td>
			<td>
				<input type="text" class="form-control" name = "qbTitle" placeholder="제목을 입력하세요.">
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<input type="hidden" name = "qbUno" value= "${logInInfo.uNo }" />
				<div><span>${logInInfo.uNick}</span></div>
			</td>
		</tr>
		<tr>			
			<td colspan="2">본문</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea id="qbContent" name="qbContent" style="width: 100%;"></textarea>
			</td>
		</tr>
		<tr>			
			<td>파일업로드</td>
			<td><input type="file" name="questionFiles" multiple/></td>
		</tr>
		<tr>			
			<td colspan="2" class="freewrite__button">
				<button class ="freewrite__button__write" type="submit" id="btnWrite">작성하기</button>
			</td>
		</tr>
		</table>
		</form>
	</div>
	
	
</div>	
</div>

<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "qbContent", // 에디터가 적용되는 <textarea>의 id
	sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
	fCreator: "createSEditor2",
	htParams: {
		bUseToolbar: true, //툴바 사용여부
		bUseVerticalResizer: false, //입력창 크기 조절 바
		bUseModeChanger: true //글쓰기 모드 탭
	}
	
});
</script>


<c:import url="/WEB-INF/views/admin/layout/footer.jsp" />  
