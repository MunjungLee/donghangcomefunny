/**
 * 나의 동행
 */

//checkBox 전체 체크 
$(document).ready(function () {
	
	$("#deleteChkAll").click(function(){
		if($(this).prop("checked")){
			$(".deleteChk").prop("checked", true);
		}else{
			$(".deleteChk").prop("checked", false);
		}		
		
	})
	
	$(".deleteChk").click(function(){
		$("#deleteChkAll").prop("checked",false);
			
	})
	
	//자유게시판 삭제
	$(".deleteFboardBtn").click(function(){

		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {

				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				$.ajax({
					url : "/mypage/fboardlist/delete"
					,type : "post"
					,data : { deleteChk : checkArr }
					,traditional : true
					,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
					}
					
				});
			}
	
		}
	});
	
	//후기게시판 삭제
	$(".deleteRboardBtn").click(function(){

		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {

				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				$.ajax({
					url : "/mypage/rboardlist/delete"
					,type : "post"
					,data : { deleteChk : checkArr }
					,traditional : true
					,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
					}
					
				});
			}
	
		}
	});
	
	
	//댓글(자유게시판) 삭제
	$(".deleteCboardBtn").click(function(){

		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {
 	
				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				$.ajax({
					url : "/mypage/commentlist/delete"
					,type : "post"
					,data : { deleteChk : checkArr }
					,traditional : true
					,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
					}
					
				});
			}
	
		}
	});
	
	
	
	
	//댓글(후기게시판) 삭제
	$(".deleteRcboardBtn").click(function(){
		console.log("click");
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {
 				console.log($(this).val());
				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				$.ajax({
					url : "/mypage/rcommentlist/delete"
					,type : "post"
					,data : { deleteChk : checkArr }
					,traditional : true
					,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
					}
					
				});
			}
	
		}
	});
	
	
	
	//복권 구매내역 삭제
	$(".deletePmBtn").click(function(){
		console.log("click");
		var confirm_val = confirm("정말 삭제하시겠습니까?");
		
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {
 				console.log($(this).val());
				checkArr.push($(this).val());
			});
			console.log(checkArr);
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				$.ajax({
					url : "/mypage/paymentlist/delete"
					,type : "post"
					,data : { deleteChk : checkArr }
					,traditional : true
					,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
					}
					
				});
			}
		}
	});
	
	//신청한 동행 관리 삭제(함께가요)
	$(".deleteApBtn").click(function(){
		console.log("click");

		var confirm_val = confirm("!신청한 내역만 삭제 가능하며, 신청 취소는 호스트에게 문의 해주세요! 정말로 삭제하시겠습니까?");
	
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
					url : "/mypage/applydonghang/delete"
						,type : "post"
						,data : { deleteChk : checkArr }
						,traditional : true
						,success : function(result){
							if(result ==1){
								location.href=window.document.URL;
							}else{
								alert("삭제 실패");
							}
						}
				
				});
			}
			
	
		}
	});
	
	
	//신청한 동행 관리 삭제(함께 해요)
	$(".deleteDoApBtn").click(function(){
		console.log("click");

		var confirm_val = confirm("!신청한 내역만 삭제 가능하며, 신청 취소는 호스트에게 문의 해주세요! 정말로 삭제하시겠습니까?");
	
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
					url : "/mypage/doapplydonghang/delete"
						,type : "post"
							,data : { deleteChk : checkArr }
				,traditional : true
				,success : function(mav){
					if(mav ==1){
						location.href=window.document.URL;
					}else{
						alert("삭제 실패");
					}
				}
				
				});
			}
			
	
		}
	});
	
	
	//나의 동행 삭제
	$(".deleteGoMyDhBtn").click(function(){
		console.log("click");

		var confirm_val = confirm("정말로 삭제하시겠습니까?");
	
		if(confirm_val){
			
			var checkArr = new Array();
			
			$("input[class='deleteChk']:checked").each(function() {
 				console.log($(this).val());
				checkArr.push($(this).val());
			});
			console.log(checkArr);
			console.log(checkArr[1]);
			console.log(checkArr[2]);
			console.log(checkArr[1]);
			
			
			if(checkArr==null || checkArr ==""){
				confirm_val = confirm("삭제할 대상을 선택해 주세요.");
			}else{
				
				$.ajax({
					url : "/mypage/mydonghang/delete"
					,type : "post"
					,dataType : "json"
				    ,contentType : "application/x-www-form-urlencoded; charset=UTF-8"
					,data : { deleteChk : checkArr }
				    ,traditional : true
				    ,success : function(result){
						if(result ==1){
							location.href=window.document.URL;
						}else{
							alert("삭제 실패");
						}
				    }
				
				});
			}
			
	
		}
	});
	
	
	//나의 동행 관리(함께 해요)
	$(".adminBtn").click(function(){
		console.log("click");
		console.log("게시물 번호 : " +$(this).val());
		visiblemodal();
		var checkArr = new Array();
		
		checkArr.push($(this).val());
		console.log(checkArr);
		
		$.ajax({
			url : "/mypage/mydonghang/admin"
				,type : "post"
				,data : { gbarr : checkArr }
        		,traditional : true
        		,dataType : "json"
				,success : function(data){
//					alert("통신 성공")
					if( data == null || data==""){
						alert("아직 신청자가 없습니다ㅠㅅㅠ")
						location.href='/mypage/mydonghang';
					}else{	
//						alert("vvvvvv");
						var element = document.getElementById("tableval");						
//						console.log(element.innerHTML);
						console.log(data.recruitedList);
//						console.log(data.recruitedList[0].AGE);
						$.each(data.recruitedList,function(index,item){
							
//							console.log("들어온 닉네임 : "+ item.UNIK);
							var gender = "";
							var status = "";
							
							if(item.UGENDER==1){
								gender = "남성";
							}else{gender = "여성"; }
							
							if(item.GASTATUS == 1){
								status="<td>수락 완료</td>";
							}else if(item.GASTATUS == 2){
								status="<td>거절 완료</td>";
							}else if(item.DASTATUS == 1){
								status="<td>수락 완료</td>";
							}else if(item.DASTATUS == 2){
								status="<td>거절 완료</td>";
							}else{
								if(item.GACATEGORY == "함께가요"){
									var cate = 0;
//									status ='<td><button class="agreeBtn" onclick="agree('+item.UNO+','+item.GANO+');" style="color: #fff;" value="'+item.UNO+'">수락</button>'
									status ='<td><button class="agreeBtn" onclick="agree('+item.UNO+','+item.GANO+','+cate+');" style="color: #fff;" value="'+item.UNO+'">수락</button>'
									+ '<button class="refuseBtn" onclick="disagree('+item.UNO+','+item.GANO+','+cate+');" style="color: #fff;" value="'+item.UNO+'">거절</button>'
									+ '</td>';
									
								}else if(item.DACATEGORY == "함께해요"){
									var cate = 1;
									status ='<td><button class="agreeBtn" onclick="agree('+item.UNO+','+item.DANO+','+cate+');" style="color: #fff;" value="'+item.UNO+'">수락</button>'
									+ '<button class="refuseBtn" onclick="disagree('+item.UNO+','+item.DANO+','+cate+');" style="color: #fff;" value="'+item.UNO+'">거절</button>'
									+ '</td>';
									
								}
							}
							
							element.innerHTML += "<tr>"
												 +'<td id="gotoUserInfo">' + item.UNICK + '</td>'
												 + '<td id="patiAge">' + item.AGE + '</td>'
												 + '<td id="patiGender">'+gender+'</td>'
												 + status
												 + "</tr>"
						
							
						})
						
					}
				}
		
		});

	});
	
	
//	//나의 동행 관리(함께 해요)
//	$("#gbnobt").click(function(){
//		console.log("click");
////		location.href='/mypage/mydonghang?cPage='+$('#pagenum').val()+'&gbno=+'$('#mygodhgbno').val()+'&#applyAdminPopup';
//		
//		var checkArr = new Array();
//		
//		checkArr.push($("#gbnobt").val());
//		checkArr.push($("#catebt").val());
//		
//		
//		$.ajax({
//			url : "/mypage/mydonghang/admin"
//				,type : "post"
//				,data : { gbarr : checkArr }
//		        ,traditional : true
//				,dataType : "json"
//				,success : function(data){
//					if( data == null || data==""){
//						alert("아직 신청자가 없습니다ㅠㅅㅠ")
//						location.href='/mypage/mydonghang';
//					}else{	
//						alert("asdasdasdasdads");
//						alert("data.recruitList : " + data.recruitList);
//						alert(data.recruitList(0));
//						var element = document.getElementById("tableval");						
//						console.log(element.innerHTML);
//						$.each(data.recruitList,function(index,item){
//							console.log("들어온 닉네임 : " + item.UNICK);
//							var gender = "";
//							var status = "";
//							
//							if(item.UGENDER==1){
//								gender = "남성";
//							}else{gender = "여성"; }
//							
//							if(item.GASTATUS == 1){
//								status="<td>수락 완료</td>";
//							}else if(item.GASTATUS == 2){
//								status="<td>거절 완료</td>";
//							}else{
//								status ='<td><button class="agreeBtn" onclick="agree('+item.UNO+');" style="color: #fff;" value="'+item.UNO+'">수락</button>'
//								 + '<button class="refuseBtn" onclick="disagree('+item.UNO+');" style="color: #fff;" value="'+item.UNO+'">거절</button>'
//								 + '</td>';
//							}
//							
//							element.innerHTML += "<tr>"
//												 +'<td id="gotoUserInfo">' + item.UNICK + '</td>'
//												 + '<td id="patiAge">' + item.AGE + '</td>'
//												 + '<td id="patiGender">'+gender+'</td>'
//												 + status
//												 + "</tr>"
//						
//							
//						})
//						
//					}
//				}
//		
//		});
//
//	});
//	
	
})

function agree(uno, bano, cate) {
	console.log("수락 uno  : " + uno);
	console.log("수락 gano  : " + bano);
	console.log("수락 cate  : " + cate);

	var checkArr = new Array();
	
	checkArr.push(uno);
	checkArr.push(bano);
	checkArr.push(cate);
	console.log(checkArr);
	
	$("#agreementPop").css({
		  visibility: "visible"
		  ,opacity: "1"
	});		
	$('#agreebtn').click(function() {
		
		$.ajax({
			url : "/mypage/mydonghang/adminrecruit"
			,type : "post"
			,data : { agreeChk : checkArr }
		    ,traditional : true
		    ,success : function(result){
				if(result ==1){
					$("#agreementPop2").css({
						visibility: "visible"
						,opacity: "1"
					})
					$("#agreementPop").css({
						  visibility: "hidden"
						  ,opacity: "0"
					});	
				}else{
					alert("수락실패");
				}
		    }
		
		});
		
		
		
		
		
//		location.href=window.document.URL;
		
	})
	
	
	
}


function disagree(uno, bano , cate) {
	
	console.log("거절 uno  : " + uno);
	console.log("거절 gano  : " + bano);
	console.log("거절 cate  : " + cate);

	var checkArr = new Array();
	
	checkArr.push(uno);
	checkArr.push(bano);
	checkArr.push(cate);
	console.log(checkArr);
	
	
	$("#refusedPop").css({
		  visibility: "visible"
		  ,opacity: "1"
	});
	$('.refusedbt').click(function() {
		console.log("거절버튼");
		
		$.ajax({
			url : "/mypage/mydonghang/refuserecruit"
			,type : "post"
			,data : { refuseChk : checkArr }
		    ,traditional : true
		    ,success : function(result){
				if(result ==1){
					$("#refusedPop2").css({
						visibility: "visible"
						,opacity: "1"
					});
					$("#refusedPop").css({
						visibility: "hidden"
						,opacity: "0"
					});
				}else{
					alert("거절실패");
				}
		    }
		
		});
		
		
		
//		location.href=window.document.URL;
	})
}


