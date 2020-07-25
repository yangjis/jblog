<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBlog</title>
<link href="${pageContext.request.contextPath }/assets/css/jblog.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>

</head>

<body>
	<div id="wrap">

		<!-- 개인블로그 해더 -->
		<jsp:include page="/WEB-INF/views/includes/blog-header.jsp"></jsp:include>
		
		<div id="content" class="clearfix">
			<div id="profilecate_area">
				<div id="profile">
					<c:if test="${blogVo.logoFile == 'default'}">
						<img id="proImg" src="${pageContext.request.contextPath}/assets/images/spring-logo.jpg">
					</c:if>
					<c:if test="${blogVo.logoFile != 'default'}">
						<img id="proImg" src="${pageContext.request.contextPath}/upload/${requestScope.blogVo.logoFile}">
					</c:if>
					<div id="nick">${requestScope.userName}(${requestScope.blogVo.id})님</div>
				</div>
				<div id="cate">
					<div class="text-left">
						<strong>카테고리</strong>
					</div>
					<ul id="cateList" class="text-left">
						<c:forEach items="${cateList}" var="cateVo">
							<li><a href="${pageContext.request.contextPath}/${blogVo.id}?cateNo=${cateVo.cateNo}">${cateVo.cateName}</a></li>
						</c:forEach>
					</ul>
				</div>
			</div>
			<!-- profilecate_area -->
			
			<div id="post_area">
				<c:if test="${not empty postVo}">
					<div id="postBox" class="clearfix">
							<div id="postTitle" class="text-left"><strong>${postVo.postTitle}</strong></div>
							<div id="postDate" class="text-left"><strong>${postVo.regDate}</strong></div>
							<div id="postNick">래미(iremys)님</div>
					</div>
					<!-- //postBox -->
				
					<div id="post" >
						${fn:replace(postVo.postContent, newLine, "<br>") }
					</div>
					<!-- //post -->
				</c:if>
				
				<c:if test="${empty postVo}">
					<div id="postBox" class="clearfix">
							<div id="postTitle" class="text-left"><strong>등록된 글이 없습니다.</strong></div>
							<div id="postDate" class="text-left"><strong></strong></div>
							<div id="postNick"></div>
					</div>
					<!-- //postBox -->
				
					<div id="post" >
					</div>
					<!-- //post -->
				</c:if>
				
				<div id="list">
					<div id="listTitle" class="text-left"><strong>카테고리의 글</strong></div>
					<table>
						<colgroup>
							<col style="">
							<col style="width: 20%;">
						</colgroup>
						<c:forEach items="${postList}" var="postVo">
							<tr>
								<td class="text-left"><a href="${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}">${postVo.postTitle}</a></td>
								<td class="text-right">${postVo.regDate}</td>
							</tr>
						</c:forEach>
					</table>
				</div>
				<!-- //list -->
			</div>
			<!-- //post_area -->
			
		</div>	
		<!-- //content -->
		<div class=></div>
		<jsp:include page="/WEB-INF/views/includes/blog-footer.jsp"></jsp:include>
		
	
	
	</div>
	<!-- //wrap -->
</body>

</html>