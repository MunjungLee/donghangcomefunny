<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix ="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.DongHang_ComeFunny.www.model.vo.User" %>
<script src="/resources/bower_components/jquery/dist/jquery.min.js"></script>
<script>
var cnt= 0;
var result;
function btn_Ok(){
	var parent = window.opener;
	 
    var msgChk = document.getElementsByName("userInfo");
	var recMsg = ""
   var indexid = false;
    
    for(i=0; i < msgChk.length; i++){
	
				if(indexid){
				recMsg = recMsg + ',';
				}
				
			recMsg = recMsg + msgChk[i].value;
			indexid= true;
		
	}
	if(!indexid){
		alert("아이디(닉네임)을 선택해 주세요!")
		return;
	}
	else{
		 parent.document.getElementById('userid').value = recMsg;
		 window.close();
	}
}
function fn_delUser(){
	var arr;
	var recMsg = "";
	var msgChk = document.getElementsByName("userInfo");
	var chked = false;
	var indexid = false;
	var resUserInfo = document.getElementById("resUserInfo")
	
	
	for(i=0; i < msgChk.length; i++){
		if(msgChk[i].checked){
				if(indexid){
				recMsg = recMsg + '-';
				}
				
			recMsg = recMsg + msgChk[i].value;
			indexid= true;
		}
	}
	if(!indexid){
		alert("아이디(닉네임)을 선택해 주세요!")
		return;
	}
	else {
		if(recMsg.indexOf("-")!="-1"){
			arr= recMsg.split("-")
			for(i =0; i<arr.length; i++){	
				var inputId = document.getElementById("userInfo"+arr[i])
				var spanId = document.getElementById("span"+arr[i])
				var divId = document.getElementById("div"+arr[i])
				resUserInfo.removeChild(inputId)
				resUserInfo.removeChild(spanId)
				resUserInfo.removeChild(divId)
				result = "";
				cnt--;
			}
		
		}else{
			var inputId = document.getElementById("userInfo"+arr[i])
			var spanId = document.getElementById("span"+arr[i])
			var divId = document.getElementById("div"+arr[i])
			resUserInfo.removeChild(inputId)
			resUserInfo.removeChild(spanId)
			resUserInfo.removeChild(divId)
			result = "";
			cnt--;
		}
		
	}
		
}

function fn_addUser(){
	var res = "<div id='div"+result.user.userId+"'><input type='checkbox' id='userInfo"+result.user.userId+"' name='userInfo' class='userInfo' value='"+result.user.userId+"'/><a id='span"+result.user.userId+"'>"+result.user.userId + "(" + result.user.uNick+")</a></div>"
	
	cnt++
	if(cnt=="10"){
		alert("최대 아이디(닉네임)를 초과 했습니다.")
		document.getElementById("values").value="";
		document.getElementById("searchResult").innerHTML="";
		return;
	}
	if( document.getElementById("resUserInfo").innerHTML.indexOf(result.user.userId+"(") !="-1"){
		alert("이미 추가한 아이디(닉네임) 입니다.")
		document.getElementById("values").value="";
		document.getElementById("searchResult").innerHTML="";
		return;
	}
	else{
	document.getElementById("resUserInfo").innerHTML+=res;
	document.getElementById("searchResult").innerHTML="";
	document.getElementById("userCntNum").innerHTML="받는 사람 "+ cnt + " / 10";
	document.getElementById("values").value="";
	}
}
function fn_searchUser(){
	var select = document.getElementById("searchOption");
	var Option = select.options[select.selectedIndex].value;
	var value = document.getElementById("values").value;
	
	
	if(!value){
		
		alert("검색어를 입력 해 주세요!")
	}else{
		var agree=confirm("검색 하시겠습니까?");
	     if (agree){
	    	 recMsg = Option+"-"+value;
	    	 $.ajax({
	             type: "get",
	             url: "/message/searchUser?userId="+recMsg,
	             async: false,     //값을 리턴시 해당코드를 추가하여 동기로 변경
	             dataType:"JSON",
	             success: function (data) {
	                 result = data;	                
	                 document.getElementById("searchResult").innerHTML=result.user.userId + "(" + result.user.uNick+")"	                 
	             }
	         });
	     }
	}
	
}

</script>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />

<meta charset="UTF-8">

<link rel="stylesheet"
	href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
<div style="border-bottom: 0.5px solid black">
	<div style="margin: 20px 30px 10px 30px;">
		<span style="font-weight: bold;">유저검색</span><br>
		<div style="margin-right: 10px">
			<div>
				<select name="search_item" id="searchOption"
					style="margin: 10px 0px; font-size: 0.9em; border: 0.5px solid black; border-radius: 3px 0px 0px 3px; height: 20px; float: left">
					<option style="font-size: 0.9em;" value="id" selected="selected">아이디</option>
					<option style="font-size: 0.9em;"value="nick">닉네임</option>
				</select>
			</div>

			<div style="float: left">
				<input type="text" id="values"
					style="width: 200px; margin: 10px 0px; height: 20px; border: 0.5px solid black; border-radius: 0px 3px 3px 0px;" />
			</div>
			<div>
				<input type="button" value="검색" onclick="fn_searchUser()"
					style="margin: 10px 0px 10px 10px; text-align: center; color: white; border-radius: 3px; outline: 0px; border: 0px; height: 20px; background: rgb(56, 87, 115); font-size: 0.9em;" />
			</div>
		</div>
	</div>
</div>
<div style="margin: 10px 0px 10px 30px; height: 350px;">
	<div style="float: left; margin: 10px 10px;">
		<div>
			<span style="font-weight: bold;">검색한 유저</span>
		</div>

		<div style="">
			<div style="height: 300px; width: 400px; border: 0.5px solid black">
				<div id="searchResult"> </div>
			</div>
		</div>
	</div>
	<div
		style="float: left; height: 350px; width: 85px; margin: 0px 5px; display: inline-block;">
		<div style="text-align: center; margin-top: 135px;">
			<input type="button" class="search_add_remove_btn" id="search_add_remove_btn" value="＜" onclick="fn_delUser()"
			style="font-size: 1em; width: 35px; height: 35px; text-align: center; color: white; border-radius: 3px; outline: 0px; border: 0px; background: rgb(56, 87, 115);"/>
		</div>
		<div style="text-align: center;">
			<input type="button" value="＞" class = "search_add_remove_btn" id="search_add_remove_btn" onclick="fn_addUser()"
			style="margin-top:10px; font-size: 1em; width: 35px; height: 35px; text-align: center; color: white; border-radius: 3px; outline: 0px; border: 0px; background: rgb(56, 87, 115);"/>
		</div>
	</div>
	<div style="float: left; margin: 10px 10px;">
		<div>
			<span style="font-weight: bold;" id="userCntNum">받는 사람 0 / 10</span>
		</div>

		<div style="">
			<div id="resUserInfo" style="height: 300px; width: 400px; border: 0.5px solid black">
			
			</div>
		</div>
		
	</div>
	
</div>
<input type="button" value="확인" onclick="btn_Ok()">
<input type="button" value="취소" onclick="window.close();">
<c:import url="/WEB-INF/views/board/boardfooter.jsp" />

