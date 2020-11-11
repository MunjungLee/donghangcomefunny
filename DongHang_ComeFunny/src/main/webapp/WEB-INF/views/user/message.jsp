<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
</head>
<body>
<form method="post" id="smsForm">
<table border = "1" align="right" width = "300" height = "200" >
 
<tr>
<td>
<center>
<br>
<span style="color: green; font-weight: bold;">SMS 전송 (문자보내기)</span>
 </center>
    <ul>
      <li>보낼사람 : <input type="text" name="from" placeholder=" 전화번호 입력 ( '-' 포함 )"/></li><br>
      <li>내용 : <textarea name="text" placeholder=" 보낼 내용 입력 "></textarea>    </li><br>
      <center>
      <input type="button" onclick="sendSMS('sendSms')" value="전송하기" /><br>
      </center>
    </ul>
 
    </td>
    </tr>
    </table>
  </form>
 
  <script>
    function sendSMS(pageName){
 
        console.log("문자를 전송합니다.");
        $("#smsForm").attr("action", pageName); //위에 있는 폼태그를 컨트롤러로 전송한다.
        $("#smsForm").submit();
    }
  </script>

</body>
</html>