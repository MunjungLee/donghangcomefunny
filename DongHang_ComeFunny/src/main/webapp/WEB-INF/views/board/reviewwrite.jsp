<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />   
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
<!-- 스마트 에디터2 라이브러리 -->
<script type="text/javascript"
 src="/resources/se2/js/service/HuskyEZCreator.js" charset="utf-8"></script>

<script type="text/javascript">
// <form>이 submit되면
// 스마트 에디터 내용을 <textarea>반영해주는 함수
function submitContents(elClickedObj) {
	// 에디터의 내용이 textarea에 적용된다.
	oEditors.getById["rbContent"].exec("UPDATE_CONTENTS_FIELD", []);

	try {
		elClickedObj.form.submit(); // <form> submit 수행
	} catch(e) {}
}

function popupOpen(){
	var url= "/board/reviewfinddh";    //팝업창에 출력될 페이지 URL
	var winWidth = 800;
    var winHeight = 600;
    var popupOption= "width="+winWidth+", height="+winHeight;    //팝업창 옵션(optoin)
    var myWindow = window.open(url,"",popupOption);
//     myWindow.document.write("<h1>"+myWindow.name+"</h1>");
}

$(document).ready(function () {
	$('#searchDHList').click(function(event){  //버튼을 클릭 했을시 popupOpen 함수 출력 
	    console.log('click');
	    popupOpen();
	});
});

function sendMeData(no, title, category) {
	console.dir(title);
	console.dir(category);
	document.getElementById("donghangTitle").innerHTML = title;
	document.getElementById("donghangCategory").innerHTML = category;
	document.getElementById("gbNo").value = no;
	document.getElementById("gbTitle").value = title;
	document.getElementById("gbCategory").value = category;
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
	
// 	$("#btnConfirm").click(function() {
// // 		console.dir("clicked");
// 		var gbNo = $("#gbNo").val();
// 		var gbTitle = $("#gbTitle").val();
// 		var gbCategory = $("#gbCategory").val();
// 		var rbDhStar = $("#rbDhStar").val();
// 		var rbHostStar = $("#rbHostStar").val();
		
// 		console.dir(gbNo);
// 		console.dir(gbTitle);
// 		console.dir(gbCategory);
// 		console.dir(rbDhstar);
// 		console.dir(rbHoststar);
// 	})
});
</script>

<div class = "reviewwrite"> 
	<div class = "reviewwrite__border">
	<div class = "reviewwrite__header">
		<div class = "reviewwrite__header__label">
			<span>후기게시판</span>
		</div>
		<span class = "reviewwrite__header__title">글쓰기</span>
	</div>
	<div class = "reviewwrite__table">
		<form action="<%= request.getContextPath() %>/board/reviewUploadImpl" method="post" enctype="multipart/form-data">
		<table>
		<tr>
			<td>동행 제목</td>
			<td>
			<div class="form-inline">
		      <div class="input-group">
		      		<input type="hidden" name="gbNo" id="gbNo" value="">
		      		<input type="hidden" name="gbTitle" id="gbTitle" value="">
		      		<input type="hidden" name="gbCategory" id="gbCategory" value="">
		      		<span id="donghangCategory"></span>
		      		&ensp;||
			  </div>
			  <div class="input-group reviewwrtie__finddh__input">
		      	<span id="donghangTitle"></span>
		      </div>
		      <div class="input-group">
		      	<button class="btn btn-default" type="button" id="searchDHList" onclick="">&ensp;&ensp;<span class="glyphicon glyphicon-search" aria-hidden="true"></span>&ensp;&ensp;</button>
		      </div>
		    </div>
			</td>
		</tr>
		<tr>
			<td>동행 평점</td>
			<td>
				<div class="reviewwrite__table__grade">
					<div class="col-lg-5">
				      <div class="input-group">
				      		<select class="form-control" id="rbDhStar" name="rbDhStar">
								<option value="5">★★★★★</option>
								<option value="4">★★★★☆</option>
								<option value="3">★★★☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="1">★☆☆☆☆</option>
							</select>
					  </div>
					</div>
					<div class="reviewwrite__host__grade">호스트평점</div>
					<div class="col-lg-3">
				      <div class="input-group">
				      		<select class="form-control" id="rbHostStar" name="rbHostStar">
								<option value="5">★★★★★</option>
								<option value="4">★★★★☆</option>
								<option value="3">★★★☆☆</option>
								<option value="2">★★☆☆☆</option>
								<option value="1">★☆☆☆☆</option>
							</select>
					  </div>
					</div>
				</div>
			</td>
		</tr>
		
		<tr>
			<td>제목</td>
			<td>
				<input type="text" class="form-control" name = "rbTitle"  placeholder="제목을 입력하세요.">
			</td>
		</tr>
		<tr>
			<td>작성자</td>
			<td>
				<div><span>${logInInfo.uNick }</span></div>
			</td>
		</tr>
		<tr>			
			<td colspan="2">본문</td>
		</tr>
		<tr>
			<td colspan="2">
				<textarea id="rbContent" name="rbContent" style="width: 100%;"></textarea>
			</td>
		</tr>
		<tr>			
			<td>파일업로드</td>
			<td><input type="file" name="files" multiple/></td>
		</tr>
		<tr>			
			<td colspan="2" class="reviewwrite__button">
<!-- 				<button class ="reviewlist__button__write" type="button" id="btnConfirm">확인</button> -->
				<button class ="reviewlist__button__write" type="submit" id="btnWrite">글쓰기</button>
			</td>
		</tr>
		</table>
		</form>
	</div>
	

	

	
	
</div>	
</div>

<c:import url="/WEB-INF/views/board/boardfooter.jsp" />    


<script type="text/javascript">
var oEditors = [];
nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: "rbContent", // 에디터가 적용되는 <textarea>의 id
	sSkinURI: "/resources/se2/SmartEditor2Skin.html", // 에디터 스킨
	fCreator: "createSEditor2",
	htParams: {
		bUseToolbar: true, //툴바 사용여부
		bUseVerticalResizer: false, //입력창 크기 조절 바
		bUseModeChanger: true //글쓰기 모드 탭
	}
	
});
</script>

