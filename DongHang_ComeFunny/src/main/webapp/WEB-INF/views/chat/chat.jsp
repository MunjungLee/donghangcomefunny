<%@page import="com.DongHang_ComeFunny.www.model.vo.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.net.InetAddress" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<head>
   <% User user = (User)session.getAttribute("logInInfo"); %>
   
   <!-- styles.css -->
   <link rel="stylesheet" href="<%=request.getContextPath() %>/resources/css/community/styles.css" />
   
   <!-- jQuery -->
   <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
   
   <!-- 부트스트랩 -->
   <!-- 합쳐지고 최소화된 최신 CSS -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
   <!-- 부가적인 테마 -->
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
   <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
   
   <!-- fontawesome 아이콘 -->
   <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.2/css/all.css" integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr" crossorigin="anonymous">
   
   <!-- semantic ui -->
   <%-- <link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/resources/css/semantic/semantic.min.css"> --%>
   <%-- <script src="<%=request.getContextPath() %>/resources/css/semantic/semantic.min.js"></script> --%>
   
   <meta name="viewport" content="width=device-width, initial-scale=1.0">
   <meta charset="UTF-8">
    <title>동행 :: 실시간채팅</title>
    <!-- Bootstrap core CSS -->
      <%InetAddress inet= InetAddress.getLocalHost();%>
 
 
</head>
<body>
   
<c:import url="/WEB-INF/views/board/boardheader.jsp" />
<div style="margin:auto; width:1003px; height: 670px;border:1px solid black;" >    


    <div style="margin:auto">
    <div style="float:left;">   
          <span>접속자 : </span>
          <span id="userCnt">0</span>
          <span> 명</span>
          <div id = "chatUser" style = "overflow-x:hidden;  overflow-y:auto; width:200px; height: 600px;border-style:solid; border-width:1px 0px; border-color:black; background-color : white"></div>        
       </div>
       <div style="float:left;">
       <span>채팅방</span>
          <div id = "chatroom" style = "overflow-x:auto;  overflow-y:auto; width:800px; height: 600px; border-style:solid; border-width:1px 0px 1px 1px; border-color:black; background-color : white"></div>
          <input onKeyUp="javascript:abba()" type = "text" id = "message" style = "margin-top:10px;height : 30px; width : 640px" placeholder="내용을 입력하세요" autofocus>
          
          <button style="height:30px; width:50px; border:0;border-radius:5px; background-color:rgb(63,86,113);; color:white;" id = "send">전송</button>
          <span style="margin-left:10px;"id = "counter">0 / 100자</span>
       </div>
    </div>
</div>
<c:import url="/WEB-INF/views/board/boardfooter.jsp" />    
</body>

    <script>


    $(document).keydown(function(event){

         if(event.keyCode == 13){

          send();

         }

       });
           
        function abba() {
          var length = document.getElementById("message").value.length;
          document.getElementById("counter").innerHTML = length + " / 100자";
          if (length >= 100) {
             document.getElementById("counter").innerHTML = "100 / 100자";
          }
       };
        connect();
        document.getElementById("send").addEventListener("click",function(){
            send();
        })
        function connect(){
           webSocket = new WebSocket("ws://"+"<%=inet.getHostAddress()%>"+":"+"<%=request.getServerPort()%>"+"/chat/websocket");
            
            webSocket.onopen = onOpen;
            webSocket.onclose = onClose;
            webSocket.onmessage = onMessage;
        }
        function disconnect(){            
            webSocket.close();
        }
        function send(){
           
            msg = document.getElementById("message").value;
            if(msg=="" || msg==null){
               alert("메시지를 작성해 주세요!")
               document.getElementById("message").value= ""; 
               return
            }
            if(msg.length > 101){
               alert("100자 이내로 작성해 주세요!")
               document.getElementById("message").value= ""; 
               return
            }
            chatroom = document.getElementById("chatroom");
            
              var time = getTimeStamp();
                
            webSocket.send("<span style='text-align:right; padding:3px 5px; border-radius:5px; background-color:rgb(237,237,237)'class='chat'>" + msg + "</span><div style='margin-top:3px;'class='chat-info chat-box'>"+ time +"</div></div>"); 
            
            document.getElementById("message").value = "";
            document.getElementById("counter").innerHTML = "0 / 100자";
            data = "<br><br><div class='chat-box' style='display:inline-block; margin-right:20px; float:right;'><span  class='mychat' style='float:right; border-radius:5px;padding:3px 5px; background-color:rgb(63,86,113); color:white;'>" + msg + "</span><br><div class='tests' style='float:right;'class='chat-info chat-box''>"+time+"</div></div>"
            chatroom.innerHTML = chatroom.innerHTML + "<br>" + data;
        }
        function onOpen(){

           webSocket.send("<%= user.getUserId()%>" + "_"+ "님이 입장하셨습니다.</div>");           
        }
        function onMessage(e){
            data = e.data;
            
            if(data.indexOf("_")!= -1){
               var res = data.substring(0,data.indexOf("_"))
               var reData = data.substring(data.indexOf("_")+1)
               if (res =="userId"){
                  var uId = data.substring(data.indexOf("_")+1)
                  var uIdArr = uId.split(",")
                  chatUser = document.getElementById("chatUser");
                  chatUser.innerHTML ="";
                  userCnt = document.getElementById("userCnt");
                  userCnt.innerHTML =uIdArr.length;
                  for (var i in uIdArr)
                  {
                    chatUser.innerHTML =chatUser.innerHTML + uIdArr[i]+"<br>";
                  }
               }else{
                  
                  if(res.indexOf("-")!= -1){
                        
                        if(res.substring(0,res.indexOf("-")) =="id"){
                           var id = res.substring(res.indexOf("-")+1)
                           chatroom = document.getElementById("chatroom");
                             chatroom.innerHTML = chatroom.innerHTML + "<br><div style='margin-left:20px;'><div style='margin-bottom:3px;'>" + id + "</div>" + reData;
                        }
                           
                     }
                  else{chatroom.innerHTML = chatroom.innerHTML + "<br>" + res + "<br>" + reData;
                  
                  }
                    }
            }else{
            
            chatroom = document.getElementById("chatroom");
            chatroom.innerHTML = chatroom.innerHTML + "<br>" + data;
            }
        }
        function onClose(){
 
        }

        function getTimeStamp() {
          var d = new Date();
          var s =
            leadingZeros(d.getFullYear(), 4) +"년 "+
            leadingZeros(d.getMonth() + 1, 2) +"월 "+
            leadingZeros(d.getDate(), 2) +"일 "+
            leadingZeros(d.getHours(), 2)+ ':' +
            leadingZeros(d.getMinutes(), 2);
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

    </script>