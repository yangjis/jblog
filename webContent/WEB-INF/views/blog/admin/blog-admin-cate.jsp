<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>JBlog</title>
<link href="${pageContext.request.contextPath }/assets/css/jblog.css"
	rel="stylesheet" type="text/css">
<script type="text/javascript"
	src="${pageContext.request.contextPath }/assets/js/jquery/jquery-1.12.4.js"></script>



</head>

<body>
	<div id="wrap">

		<!-- 개인블로그 해더 -->
		<jsp:include page="/WEB-INF/views/includes/blog-header.jsp"></jsp:include>

		<div id="content">
			<ul id="admin-menu" class="clearfix">
				<li class="tabbtn"><a
					href="${pageContext.request.contextPath }/${sessionScope.authUser.id}/admin/basic">기본설정</a></li>
				<li class="tabbtn selected"><a href="#">카테고리</a></li>
				<li class="tabbtn"><a
					href="${pageContext.request.contextPath }/${sessionScope.authUser.id}/admin/writeForm">글작성</a></li>
			</ul>
			<!-- //admin-menu -->

			<div id="admin-content">

				<table id="admin-cate-list">
					<colgroup>
						<col style="width: 50px;">
						<col style="width: 200px;">
						<col style="width: 100px;">
						<col>
						<col style="width: 50px;">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>카테고리명</th>
							<th>포스트 수</th>
							<th>설명</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody id="cateList">
						<!-- 리스트 영역 -->
						<c:forEach var="vo" items="${requestScope.cataList}"
							varStatus="status">

							<tr>
								<td>${vo.cateNo}</td>
								<td>${vo.cateName}</td>
								<td>${vo.postNumber }</td>
								<td>${vo.description }</td>
								<td class='text-center'><img class="btnCateDel"
									src="${pageContext.request.contextPath}/assets/images/delete.jpg"
									data-no="${vo.cateNo }"></td>
							</tr>
						</c:forEach>

					</tbody>
				</table>

				<table id="admin-cate-add">
					<colgroup>
						<col style="width: 100px;">
						<col style="">
					</colgroup>
					<tr>
						<td class="t">카테고리명</td>
						<td><input type="text" name="cateName" value=""></td>
					</tr>
					<tr>
						<td class="t">설명</td>
						<td><input type="text" name="description"></td>
					</tr>
				</table>

				<div id="btnArea">
					<button id="btnAddCate" class="btn_l" type="submit">카테고리추가</button>
				</div>

			</div>
			<!-- //admin-content -->
		</div>
		<!-- //content -->

		<jsp:include page="/WEB-INF/views/includes/blog-footer.jsp"></jsp:include>
		<!-- 개인블로그 푸터 -->



	</div>
	<!-- //wrap -->
</body>
<script type="text/javascript">
	$("#btnAddCate").on("click", function(){
		console.log("버튼을 눌렀는감?");		
		var cateName =  $("input[name=cateName]").val();
		var description =  $("input[name=description]").val();
		var id = "${sessionScope.authUser.id}";
		
		var cateVo = {cateName: cateName, 
					  description: description, 
					  id: id};
		
		 $.ajax({
			
			url : "${pageContext.request.contextPath }/api/cateInsert",		
			type : "post",
			contentType : "application/json",
			data : JSON.stringify(cateVo),
			dataType : "json",
			success : function(cateVo){
				var str = "";
				
				str += "<tr>";
				str += "<td>"+cateVo.cateNo+"</td>";
				str += "<td>"+cateVo.cateName+"</td>";
				str += "<td>"+cateVo.postNumber+"</td>";
				str += "<td>"+cateVo.description+"</td>";
				str += "<td class='text-center'><img class='btnCateDel' src='";
			    str += "${pageContext.request.contextPath}/assets/images/delete.jpg' data-no='"+cateVo.cateNo+"'></td></tr>";
			    
			    $("input[name=cateName]").val("");
			    $("input[name=description]").val("");
			    
				$("#cateList").prepend(str);	
				
			},
			error : function(XHR, status, error) {
				console.error(status + " : " + error);
			}
		}); 
	});
	
	
	$("#cateList").on("click","td img", function(){
		console.log("삭제하려는가?");
		var $this = $(this);
		var cateNo = $this.data("no");
		var id = "${sessionScope.authUser.id}";
		
		console.log(cateNo);
		console.log(id);
		var cateVo = {cateNo: cateNo,
					  id: id}
		$.ajax({
					url : "${pageContext.request.contextPath }/api/cateDelete",		
					type : "post",
					contentType : "application/json",
					data : JSON.stringify(cateVo),
					dataType : "json",
					success : function(result){
						
						if(result == 0){
							alert("삭제할 수 없습니다.");
						}else{
							var tr = $this.parent().parent();
							tr.remove();
						}
						
					},
					error : function(XHR, status, error) {
						console.error(status + " : " + error);
					}
		});   
		
	});
</script>



</html>