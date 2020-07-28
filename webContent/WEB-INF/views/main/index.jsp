<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBlog</title>

<script type="text/javascript" src="/jblog/assets/js/jquery/jquery-1.12.4.js"></script>
<link href="${pageContext.request.contextPath }/assets/css/jblog.css" rel="stylesheet" type="text/css">

</head>
<body>
	<div id="center-content">
		<jsp:include page="/WEB-INF/views/includes/main-header.jsp"></jsp:include>
		<!--메인 해더 자리 -->
		<div id="search-form">
			<fieldset>
				<input type="text" name="keyword" id="keyword">
				<button id="btnSearch" type="button" >검색</button>
			</fieldset>
			
			<fieldset>
				<label for="rdo-title">블로그 제목</label> 
				<input id="rdo-title" type="radio" name="kwdOpt" value="optTitle" checked = "checked" > 
				
				<label for="rdo-userName">블로거 이름</label> 
				<input id="rdo-userName" type="radio" name="kwdOpt" value="optName" > 
			</fieldset>
		</div>
		<div>
			<table >
				<colgroup>
					<col style="width: 30%;">
					<col style="width: 45%;">
					<col style="width: 20%;">
					<col style="width: 15%;">
				</colgroup>
				<tbody id="resultList">
					
				</tbody>
			</table>
			
		</div>
		<jsp:include page="/WEB-INF/views/includes/main-footer.jsp"></jsp:include>
		<!-- 메인 푸터  자리-->
	
	
	</div>
	<!-- //center-content -->
</body>
<script type="text/javascript">
	$("#btnSearch").on("click", function(){
		
		var keyword = $("#keyword").val();
		var radio = $('input[name="kwdOpt"]').val();
		
		$("#resultList *").empty();
		
		$.ajax({
			
			url : "${pageContext.request.contextPath }/api/search", 		
			type : "post",
			//contentType : "application/json",
			data : {keyword:keyword, 
					radio:radio},
			dataType : "json",
			success : function(result){
				/*성공시 처리해야될 코드 작성*/
				console.log("성공이야");
				
				
				for(var i =0; i <= result.length; i++){
					var str = "";
					
					str += "<hr>";
					str += "<tr><td>";
					str += "<a href='${pageContext.request.contextPath}/";
					str += result[i].id;
					str += "?pg=1'>";
					if("default"==result[i].logoFile ){
					str +="<img style='width: 100px;' src='${pageContext.request.contextPath}/assets/images/spring-logo.jpg'>";
					}else{
					str += "<img style='width: 100px;' src='${pageContext.request.contextPath}/upload/";
					str += result[i].logoFile+"'></a>";
					}
					str += "</td>";
					str += "<td>"
					str += result[i].blogTitle;
					str += "</td>";
					str += "<td>";
					str += result[i].userName+"("+result[i].id+")";
					str += "</td>";	
					str += "<td>";
					str += result[i].joinDate;
					str += "</td>";
					str += "</tr>";

					$("#resultList").prepend(str);
					$("#keyword").val("");
				}
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});

</script>

</html>