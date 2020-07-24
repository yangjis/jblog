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
		<!--메인 해더 자리 -->
		
		
		<form id="search-form">
			<fieldset>
				<input type="text" name="keyword" >
				<button id="btnSearch" type="submit" >검색</button>
			</fieldset>
			
			<fieldset>
				<label for="rdo-title">블로그 제목</label> 
				<input id="rdo-title" type="radio" name="kwdOpt" value="optTitle" > 
				
				<label for="rdo-userName">블로거 이름</label> 
				<input id="rdo-userName"" type="radio" name="kwdOpt" value="optName" > 
			</fieldset>
		</form>
		
		<div id="resultList">
			
			
		</div>
		<jsp:include page="/WEB-INF/views/includes/main-footer.jsp"></jsp:include>
		<!-- 메인 푸터  자리-->
	
	
	</div>
	<!-- //center-content -->
</body>
</html>