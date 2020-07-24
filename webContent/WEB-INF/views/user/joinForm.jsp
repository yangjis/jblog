<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBlog</title>
<link href="${pageContext.request.contextPath }/assets/css/jblog.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>

</head>
<body>
	<div id="center-content">
		<jsp:include page="/WEB-INF/views/includes/main-header.jsp"></jsp:include>
		<!-- 메인 해더 -->
	

		<div>		
			<form id="joinForm" method="post" action="${pageContext.request.contextPath}/user/join">
				<table>
			      	<colgroup>
						<col style="width: 100px;">
						<col style="width: 170px;">
						<col style="">
					</colgroup>
		      		<tr>
		      			<td><label for="txtId">아이디</label></td>
		      			<td><input id="txtId" type="text" name="id"></td>
		      			<td><button id="btnIdCheck" type="button">아이디체크</button></td>
		      		</tr>
		      		<tr>
		      			<td></td>
		      			<td id="tdMsg" colspan="2" ></td>
		      		</tr> 
		      		<tr>
		      			<td><label for="txtPassword">패스워드</label> </td>
		      			<td><input id="txtPassword" type="password" name="password"  value=""></td>   
		      			<td></td>  			
		      		</tr> 
		      		<tr>
		      			<td><label for="txtUserName">이름</label> </td>
		      			<td><input id="txtUserName" type="text" name="userName"  value=""></td>   
		      			<td></td>  			
		      		</tr>  
		      		<tr>
		      			<td><span>약관동의</span> </td>
		      			<td colspan="3">
		      				<input id="chkAgree" type="checkbox" name="agree" value="y">
		      				<label for="chkAgree">서비스 약관에 동의합니다.</label>
		      			</td>   
		      		</tr>   		
		      	</table>
	      		<div id="btnArea">
					<button id="btnJoin" class="btn" type="submit" >회원가입</button>
				</div>
	      		
			</form>
			
		</div>
		
		<jsp:include page="/WEB-INF/views/includes/main-footer.jsp"></jsp:include>
		<!-- 메인 푸터  자리-->
		
	</div>

</body>
<script type="text/javascript">
$("#btnIdCheck").on("click", function(){
	
	var uId = $("#txtId").val();
	console.log(uId);
	var userInfo = {userId: uId};
	$.ajax({
		
		url : "${pageContext.request.contextPath }/api/idcheck", 		
		type : "post",
		//contentType : "application/json",
		data : {userId: uId},
		dataType : "json",
		success : function(result){
			/*성공시 처리해야될 코드 작성*/
			console.log(result);
			if(result == true){
				$("#tdMsg").text("사용할 수 있는 아이디입니다.");
			}else{
				$("#tdMsg").text("다른 아이디로 가입해 주세요.");
			}
		},
		error : function(XHR, status, error) {
			console.error(status + " : " + error);
			console.log("아이디 체크 실패");
		}
	});
	
});
</script>


</html>