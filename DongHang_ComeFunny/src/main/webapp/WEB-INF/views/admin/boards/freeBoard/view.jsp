<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:import url="/WEB-INF/views/board/boardheader.jsp" />
<link rel="stylesheet" href="/resources/css/admin/adminQuickBar.css">

<script type="text/javascript">
$(function() {

	  var UI = {
	    init: function() {
	      this.quickMenuFn();
	      this.topBtn();
	    },

	    initialize: function() {
	      this.id = {
	        target: {
	          quick: '.rightQuickBar',
	          stickyTop: '#footer'
	        },
	        topBtnClass: 'btn_top'
	      };
	      this.init();
	    },

	    quickMenuFn: function() {
	      var quick = $(this.id.target.quick);
	      var qTop = parseInt(quick.css('top'));

	      $(window).scroll(function() {
	        var winTop = $(window).scrollTop();

	        quick.stop().animate({
	          top: winTop + qTop
	        }, 400);

	      })
	    },

	    topBtn: function() {
	      var btnLocation = $('.' + this.id.topBtnClass);
	      var timerId = 0;

	      $(window).on('scroll', function() {
	        var winTop = $(window).scrollTop();
	        if (winTop > 200) {
	          btnLocation.fadeIn();
	          clearInterval(timerId);
	          timerId = setInterval(btnEffet, 2000);
	        } else {
	          btnLocation.fadeOut();
	          clearInterval(timerId);
	        }

	      });

	      function btnEffet() {
	        btnLocation.fadeTo('300', 0.3).fadeTo('300', 1);
	      }

	      this.scrollTop(btnLocation);
	    },

	    scrollTop: function(eTarget, speed) {
	      var speed = speed || null;
	      eTarget.on('click', function() {
	        $('html, body').animate({
	          scrollTop: $("body").offset().top
	        }, speed)
	      })
	    }

	  };

	  $(function() {
	    UI.initialize();
	  })

	})
	
	
	
	

</script>


<div class="rightQuickBar">
    	<ul class="mainMenu">
    		<li><a href="/admin/user/list">회원관리</a></li>
    		<li><a href="/admin/boards/main">게시판 관리</a></li>
    		<li><a href="/admin/question/list">1대1문의 관리</a></li>
    		<li><a href="/admin/notice/list">공지사항 관리</a></li>
    		<li><a href="/admin/order/list">결제 관리</a></li>
    	</ul>
    </div>
    
      <p class="btn_top"><a href="#none">top</a></p>


   

<div class = "freeview"> 
	<div class = "freeview__border">
	<div class = "freeview__header">
		<div class = "freeview__header__label">
			<span>자유게시판</span>
		</div>
		<span class = "freeview__header__title">상세보기</span>
	</div>
	<div class = "freeview__table">
		<table>
		<tr>
			<td colspan="2"> 
				<div class= "freeview__table__title">
				제목 : &nbsp;
					<span>${fview.detail.FBTITLE}</span>
				</div>
			</td>
		</tr>
		<tr >			
			<td colspan="2">
			<div class= "freeview__table__header ">
				<div>${fview.detail.UNICK } &nbsp; | &nbsp; ${fview.detail.FBWRITTENDATE}</div>
				<div>조회 &nbsp; : &nbsp; ${fview.detail.FBHITSCNT} &nbsp; | &nbsp; 댓글 &nbsp; : &nbsp; 0 </div>
			</div>
			</td>
			
		</tr>
		<tr>
			<td colspan="2">
			<div class= "freeview__table__content">
				${fview.detail.FBCONTENT }
			</div>
			</td>
		</tr>
		
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>업로드된 파일 </span>
			</div>
			</td>
			
		</tr>
		
		<c:forEach items="${fview.filelist }" var="file" varStatus="status">
		<tr>			
			<td colspan="2">
				<div class="freeview__table__download">
					<span>${status.count}. : &nbsp;</span>
				 <a href="javascript:downloadFile('${file.FFORIGINFILENAME}', '${file.FFSTOREDFILENAME}')">
				 	${file.FFORIGINFILENAME}</a>
			</div>
			</td>
			
		</tr>
		</c:forEach>

		</table>
		
		<div class="freeview__button">
			<div>
<!-- 				<button class ="freeview__button__list" type="button" onclick="location.href='/board/freelist'">목록</button> -->
				<button class ="freeview__button__list" type="button" onclick="history.go(-1)">목록</button>
			</div>
				<div>
					<button class ="freeview__button__delete" onclick="submitData('/admin/boards/freeBoard/delete?fbNo=${fview.detail.FBNO}')">삭제</button>
				</div>
		</div>

  		
  		<div class="freeview__comment">
  			<div class="freeview__comment__write">
  				<span>댓글</span>
  			</div>
  			
		</div>
  
	</div>
	 <!-- Main content -->
        <section class="content container-fluid">
		 <div class="row justify-content-md-center">				
            <div class="col-lg-12" style="margin: auto 5%; width: 90%;">
<!--                 <div class="box box-warning"> -->
<!--                     <div class="box-header with-border"> -->
<!--                         <a class="link-black text-lg"><i class="fa fa-pencil margin-r-5"></i> 댓글 쓰기</a> -->
<!--                     </div> -->
<!--                     <div class="box-body"> -->
<%--                         <c:if test="${not empty logInInfo}"> --%>
<!--                             <form id="replyForm"> -->
<!--                                 <div class="form-group"> -->
<!--                                     <textarea class="form-control" id="newReplyText" name="fcContent" rows="3" placeholder="댓글내용..."style="resize: none"></textarea> -->
<!--                                 </div> -->
<!--                                 <div class="col-sm-2" hidden> -->
<%--                                     <input class="form-control" id="newReplyFreeBoardNo" type="text" name="fbNo" value="${fview.detail.FBNO}" readonly> --%>
<%--                                     <input class="form-control" id="newReplyWriter" type="text"name="userId" value="${logInInfo.userId}" readonly> --%>
<%--                                     <input class="form-control" id="newReplyWriterNo" type="text"name="uNo" value="${logInInfo.uNo}" readonly> --%>
<!--                                 </div> -->
<!--                                 <button type="button" class="btn btn-default btn-block replyAddBtn"> -->
<!--                                     <i class="fa fa-save"></i> 댓글 저장 -->
<!--                                 </button> -->
<!--                             </form> -->
<%--                         </c:if> --%>
<%--                         <c:if test="${empty logInInfo}"> --%>
<%--                             <a href="${path}/user/login" class="btn btn-default btn-block" role="button"> --%>
<!--                                 <i class="fa fa-edit"></i> 로그인 한 사용자만 댓글 등록이 가능합니다. -->
<!--                             </a> -->
<%--                         </c:if> --%>
<!--                     </div> -->
<!--                 </div> -->

                    <%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%>
                <div class="box box-success">
                    <div class="box-header with-border">
                   		<a class="link-black text-lg"><i class="fa fa-pencil margin-r-5"></i> 댓글 목록</a>
                        <a class="link-black text-lg"><i class="fa fa-comments-o margin-r-5 replyCount"></i> </a>
                        <div class="box-tools">
                            <button type="button" class="btn btn-box-tool" data-widget="collapse">
                                <i class="fa fa-minus"></i>
                            </button>
                        </div>
                    </div>
                    <div class="box-body repliesDiv">
                    
							<div id="replyStop"></div>
					</div>
                </div>
                
                <%--댓글 수정 modal 영역--%>
                <div class="modal fade" id="modModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">댓글수정</h4>
                            </div>
                            <div class="modal-body" data-rno>
                                <input type="hidden" class="replyNo"/>
                                <textarea class="form-control" id="replyText" rows="3" style="resize: none"></textarea>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button>
                                <button type="button" class="btn btn-primary modalModBtn">수정</button>
                            </div>
                        </div>
                    </div>
                </div>

                <%--댓글 삭제 modal 영역--%>
                <div class="modal fade" id="delModal">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span></button>
                                <h4 class="modal-title">댓글 삭제</h4>
                                <input type="hidden" class="rno"/>
                            </div>
                            <div class="modal-body" data-rno>
                                <p>댓글을 삭제하시겠습니까?</p>
                                <input type="hidden" class="rno"/>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-default pull-left" data-dismiss="modal">아니요.
                                </button>
                                <button type="button" class="btn btn-primary modalDelBtn">네. 삭제합니다.</button>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

			</div>

        </section>
	</div>
</div>	


	






<script type="text/javascript">
   
   function submitData(url){
      location.href = url;
   } 
   
   function downloadFile(ofname, rfname){
       location.href = "freedownload?"
            +"ofname="+ofname
            +"&rfname="+rfname;
 
      
   }
</script>
<%@ include file="/WEB-INF/views/admin/include/plugin_js.jsp" %>
<script>

$(document).ready(function () {

		showReplyList();

	});


</script>
<script>
	function showReplyList(){
		var url = "${pageContext.request.contextPath}/admin/boards/freeBoard/getReplyList";
		var paramData = {"fbNo" : "${fview.detail.FBNO}"};
// 		console.dir(url);

// 		console.dir(paramData);
		$.ajax({
            type: 'POST',
            url: url,
            data: paramData,
            dataType: 'json',
            success: function(result) {
               	var htmls = "";
//                	console.dir(result);
			if(result.length < 1){
				htmls+= "등록된 댓글이 없습니다.";
			} else {
	                    $(result).each(function(){
	                    	var d = new Date(this.FCWRITTENDATE);
	                    	var fcwrittendate = d.getFullYear() + '-' + d.getMonth() + '-' + d.getDate() + ' ' + d.getHours() + ':' + d.getMinutes() + ":" + d.getSeconds(); 
// 	                    	console.dir(d);
// 	                    	console.dir(fcwrittendate);
						htmls+='<div class="post replyDiv" data-replyNo="'+this.FCNO+'">';
						htmls+='<div class="user-block">';
						htmls+='<div class="username">';
					    //작성자 이름
						htmls+='<span>No :' + this.RNUM + ' &nbsp; | &nbsp;' + this.UNICK +'&nbsp; | &nbsp; </span>';
						//댓글 유저 정보 = 세션정보
// 						htmls+='<c:if test="${not empty logInInfo}">';
					    //댓글 삭제 버튼
						htmls+='<a href="#" class="pull-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#delModal"><i class="fa fa-times"> 삭제</i></a>';
					    //댓글 작성자 프로필사진
				        <img class="img-circle img-bordered-sm" src="/{{userVO.userImg}}" alt="user image"> -->
					    //댓글 수정 버튼
// 					    htmls+='<a href="#" class="pull-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modModal"><i class="fa fa-edit"> 수정</i></a></div>';
					    htmls+='</div>';
// 					    htmls+='</c:if>';
					    //댓글 작성일자
					    htmls+='<span class="description">' + fcwrittendate + '</span></div>';
					    //댓글 내용
					    htmls+='<div class="oldReplyText col-lg-11">' + this.FCCONTENT + '</div><br/></div>';
					    
					    
					    if($(this).is('#replyStop')) {
					    	return false;
					    }

	                });	//each end
			}
			$(".repliesDiv").html(htmls);
            }	   // Ajax success end
		});	// Ajax end
	}
</script>
<script>
//     $(document).ready(function () {
//         var articleNo = "${fview.detail.FBNO}";  // 현재 게시글 번호
//         // 댓글 저장 버튼 클릭 이벤트
//         $(".replyAddBtn").on("click", function () {
//             // 입력 form 선택자
//             var replyTextObj = $("#newReplyText");
//             var replyText = replyTextObj.val();
//             var replyValue = {};
//             replyValue.fbNo = articleNo;
//             replyValue.fcContent = replyText;
//             console.dir(replyValue);
//             // 댓글 입력처리 수행
//             $.ajax({
//                 type: "post",
//                 url: "/board/freecommentwriteImpl/",
//                 data: replyValue,
//                 success: function (result) {
//                     console.log("result : " + result);
//                     if (result == 1) {
//                         alert("댓글이 등록되었습니다.");
//                         showReplyList();
//                         replyPageNum = 1;  // 페이지 1로 초기화
//                         replyTextObj.val("");   // 댓글 입력창 공백처리
//                     }
//                 }
//             });
//         });
//         // 댓글 수정을 위해 modal창에 선택한 댓글의 값들을 세팅
//         $(".repliesDiv").on("click", ".replyDiv", function (event) {
//             var reply = $(this);
//             $(".replyNo").val(reply.attr("data-replyNo"));
//             $("#replyText").val(reply.find(".oldReplyText").text());
// //             console.dir($(".replyNo").val(reply.attr("data-replyNo")));
// //             console.dir($("#replyText").val(reply.find(".oldReplyText").text()));
//         });
//         // modal 창의 댓글 수정버튼 클릭 이벤트
//         $(".modalModBtn").on("click", function () {
//             var replyNo = $(".replyNo").val();
//             var replyText = $("#replyText").val();
//             var url = "${pageContext.request.contextPath}/board/updateReply";
//             console.dir(replyNo);
//             console.dir(replyText);
//             console.dir(url)
//             console.dir(JSON.stringify({
//             	replyNo : replyNo
//                 , replyText: replyText
//             }));
//             $.ajax({
//                 type: "put",
//                 url: url,
//                 headers: {
//                     "Content-Type": "application/json",
//                     "X-HTTP-Method-Override": "PUT"
//                 },
//                 dataType: "text",
//                 data: JSON.stringify({
//                 	replyNo : replyNo
//                     , replyText: replyText
//                 }),
//                 success: function (result) {
//                     console.log("result : " + result);
//                     if (result == 1) {
//                         alert("댓글이 수정되었습니다.");
//                         showReplyList();
//                         $("#modModal").modal("hide"); // modal 창 닫기
//                     }
//                 }
//             })
//         });
        // modal 창의 댓글 삭제버튼 클릭 이벤트
        $(".modalDelBtn").on("click", function () {
            var replyNo = $(".replyNo").val();
            var url = "${pageContext.request.contextPath}/admin/boards/freeBoard/deleteReply";
            console.dir(replyNo);
            console.dir(url);
            $.ajax({
                type: "put",
                url: url,
                headers: {
                    "Content-Type": "application/json",
                    "X-HTTP-Method-Override": "put"
                },
                dataType: "text",
                data: JSON.stringify({
                	replyNo : replyNo
                }),
                success: function (result) {
                    console.log("result : " + result);
                    if (result == 1) {
                        alert("댓글이 삭제되었습니다.");
                        showReplyList();
                        $("#delModal").modal("hide"); // modal 창 닫기
                    }
                }
            });
        });
    });
</script>

<c:import url="/WEB-INF/views/board/boardfooter.jsp" />    



