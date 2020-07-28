<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBlog</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>
<link href="${pageContext.request.contextPath }/assets/css/jblog.css" rel="stylesheet" type="text/css">

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
							<li><a href="${pageContext.request.contextPath}/${blogVo.id}?cateNo=${cateVo.cateNo}&pg=1">${cateVo.cateName}</a></li>
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
				<!-- 댓글등록하는 테이블 -->
	            <c:if test="${authUser.id != null && postVo.postNo != 0}">
	               <div  class="reply">
	                     <table style="width: 100%;height: 40px;">
	                     <colgroup>
	                        <col style="">
	                        <col style="width: 80%;">
	                        <col style="">
	                     </colgroup>
	                     
	                        <tr>
	                           <td> 
	                           ${userName}
	                           </td>
	                           <td>
	                           <input type="text" style="width: 100%;height: 80%;" id ="cmtContent" name="cmtContent" value="">
	                           <td>
	                           <td><input type="button" style="width: 90%; height: 80%;" value="댓글등록" id="btnReply"></td>
	                        </tr>
	                     </table>
	               </div>
	            </c:if>
	            
	            <!-- 댓글리스트 -->
	            <table style="width: 100%;height: 40px;">
		            <colgroup>
		               <col style="">
		               <col style="width: 70%;">
		               <col style="">
		               <col style="">
		            </colgroup>
		            <tbody id = "commentList">
		            </tbody>
				</table>		               	
						
				<c:if test="${postVo.postNo == 0}">
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
						<c:forEach items="${postMap.postList}" var="postVo" >
							<tr>
								<c:if test="${empty param.pg }">
								<td class="text-left"><a href="${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}&pg=1">${postVo.postTitle}</a></td>
								</c:if>
								
								<c:if test="${!empty param.pg }">
								<td class="text-left"><a href="${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}&pg=${param.pg}">${postVo.postTitle}</a></td>
								</c:if>
								<td class="text-right">${postVo.regDate}</td>
							</tr>
						</c:forEach>
						
					</table>
						<c:if test="${postMap.pg.pre eq true}">
						<a href = "${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}&pg=${postMap.pg.page_Start-1}">◀</a>
						</c:if>
					
						<c:forEach var="pg" begin="${ postMap.pg.page_Start}" end="${postMap.pg.page_End}">
							<a href = "${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}&pg=${pg}">${pg }</a>
						</c:forEach>
						
						<c:if test="${postMap.pg.next eq true}">
						<a href = "${pageContext.request.contextPath}/${blogVo.id}?cateNo=${postVo.cateNo}&postNo=${postVo.postNo}&pg=${postMap.pg.page_End + 1}">▶</a>
						</c:if>
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

<script type="text/javascript">
	$(document).ready(function(){
		
		 fetchList();
	});
	
	$("#commentList").on("click","img.btnCateDel", function(){
		console.log("삭제하려는가?");
		var $this = $(this);
		var cmtNo = $this.data("cmtno");
		
		console.log(cmtNo);
		
		$.ajax({
			
			url : "${pageContext.request.contextPath }/api/commentsDel",		
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(cmtNo),
			dataType : "json",
			success : function(list){
				console.log("성공");
				var tr = $this.parent().parent();			
				tr.remove();
				
				/*성공시 처리해야될 코드 작성*/
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	});
	
	function fetchList(){
		var postNo = ${postVo.postNo};
		var postVo = {postNo: postNo};
		var uNo = "${authUser.userNo}";
		
		$.ajax({
			url : "${pageContext.request.contextPath }/api/commentsList",		
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(postVo),
			dataType : "json",
			success : function(list){

				for(var i = 0; i <= list.length; i++){
					
					var str = "";
					str += "<tr>";
					str += "<td>";
					str += list[i].userName;
					str += "</td>";
					str += "<td>";
					str += list[i].cmtContent;
					str += "</td>";
					str += "<td>";
					str += list[i].regDate;
					str += "</td>";
					str += "<td>";
					
					if(list[i].userNo == uNo){
						str += "<img src ='";
						str += "${pageContext.request.contextPath}";
						str += "/assets/images/delete.jpg'  data-cmtno='"+list[i].cmtNo+"' class='btnCateDel'>";
					}
					str += "</td>";					
					str += "</tr>";
					
					$("#commentList").prepend(str);
				}
				
				
				
				/*성공시 처리해야될 코드 작성*/
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		});
	};


	$("#btnReply").on("click", function(){
	    var cmtContent = $("#cmtContent").val();
	    var postNo = ${postVo.postNo };
	    var userNo = "${sessionScope.authUser.userNo}";
	    
	    var comentsVo ={cmtContent: cmtContent,
	                	postNo: postNo,
	                	userNo: userNo}
	    
	    $.ajax({
	       
	       url : "${pageContext.request.contextPath }/api/commentsInsert",      
	       type : "post",
	       contentType : "application/json",
	       data : JSON.stringify(comentsVo),
	       dataType : "json",
	       success : function(cmt){
	           var str = "";
	          
	          str += "<tr>";
	          str += "<td>"+cmt.userName+"</td>";
	          str += "<td>"+cmt.cmtContent+"</td>";
	          str += "<td>"+cmt.regDate;
	          str += "</td>";
	          str += "<td>";
	          str += "<img class='btnCateDel' src='";
	          str += "${pageContext.request.contextPath}/assets/images/delete.jpg' data-cmtno='"+cmt.cmtNo+"'>";
	          str += "</td></tr>";
	           
	          $("input[name='cmtContent']").val("");
	           
	          $("#commentList").prepend(str);    
	          
	       },
	       error : function(XHR, status, error) {
	          console.error(status + " : " + error);
	       }
	    }); 
	 });
	
	
	 

</script>

</html>