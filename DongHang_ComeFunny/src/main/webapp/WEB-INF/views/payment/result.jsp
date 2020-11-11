<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
	src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<%@ page import="com.DongHang_ComeFunny.www.model.vo.User"%>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/resources/css/mypage/mypage_header.css" />


<div>
	<div>
		<div style="width: 200px; height: 70px;">
			<img style="width: 200px; height: 70px;" logo-img" alt="로고이미지"
				src="/resources/image/header/logo.png">
		</div>
	</div>
</div>

<div
	style="width: 700px; height: 120px;">
	<div
		style="width:685px;margin-left:100px;margin-top: 2em; padding: 0.5em; font-size: 17px; font-weight: bold; border-bottom: 2px solid #999;">결제가 완료되었습니다.</div>
	<div
		style="text-align: center;width:700px; margin: 1em 0;padding-top: 0.5em; border: 1px solid #ccc; height: 120px; margin-left:100px; ">
		<p style="margin-top:30px;">결제내역  : <%=request.getParameter("count") %> 개</p>
		<p>가격 : <%=request.getParameter("paidamount") %> 원</p>
	</div>
</div>
<div style="margin-top:330px; margin-left:400px "><button style="height:30px;background-color: rgb(93, 124, 166); border-radius: 2px; border: none; margin: 3px 0px; color: white; width:100px;"onclick="closes()">닫기</button></div>

<script>
	function closes(){
		opener.parent.location.reload();
		window.close();
	}
</script>
