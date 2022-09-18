<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>
 <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
    
<meta charset="UTF-8">
	<title>호텔 정보</title>
<style type="text/css">
  .img{
    position: relative;                                                           
    height: 50vh;
    background-size: cover;
  }
  .img-cover{
     position: absolute;
     height: 100%;
     width: 100%;
     background-size: cover;                                                              
  }

</style>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>


<script type="text/javascript" src="/resources/reply/js/reply.js"></script>
<script type="text/javascript" src="/resources/reply/js/replyFunc.js"></script>
<script type="text/javascript" src="/resources/reply/js/replyEvent.js"></script>

<script type="text/javascript">
//jqeury() - html 문서가 로딩이 되면 함수를 호출해서 처리
$(function() {
	$("#updateBtn").click(function(){
		location = "update.do?no=${vo.no}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}";
	});
	
	$("#deleteBtn").on("click", function(){
		if(confirm("정말 삭제하시겠니까?"))
			location = "delete.do?no=${vo.no}&perPageNum=${param.perPageNum}";
	});
	
	$("#listBtn").click(function(){
		location = "list.do?page=" + "${param.page}"
		+ "&perPageNum=" + "${param.perPageNum}"
		+ "&key=" + "${param.key}"
		+ "&word=" + "${param.word}";
	});
});
</script>
</head>
<body>
	<input type="hidden" id="no" data-no="${vo.no }">
	<div class="container">
	<div class="container">
		<div class="img" style="background-image: url('${vo.fileName}');">
	        <h4>
	        </h4>        
	        
	        <div class="img-cover"></div>
		</div>
	</div>
	<h2>${vo.name }</h2>
	<h1></h1>
	<hr style="border:solid; color= silver">
	
	<div class="container">		
		<div class="container">
			
			<p>호텔명 : ${vo.name }</p>
			<p>주소 : ${vo.bus_address }</p>
			<p>전화번호 : ${vo.bus_tel }</p>
			<p>메일 : ${vo.bus_mail }</p>
			<p>소개글:${vo.content }</p>		
			<a href="/room/list.do?no=${vo.no }"><img src="/upload/business/h.001.png" width = "30" alt="객실 보러가기">
			</a>
		</div>		
	</div>

		<!-- 그 외 기능 버튼 위치 -->
<div class="row">
		<div class="col-md-4" style="padding: 20px;">
			<div class="btn-group">
		<c:if test="${!empty login && login.gradeNo == 9 }"> <!-- 관리자 계정일때 수정, 삭제 표시 --> 
			<button type = "button" id="updateBtn" class="btn-default">수정</button>
			<button type = "button" id="deleteBtn" class="btn-default">삭제</button>
		</c:if> 
			<button type = "button" id="listBtn" class="btn-default">리스트</button>
			</div>
			</div>
			</div>
			
<%-- 					<c:if test="${!empty login && login.gradeNo == 9 }"> <!-- 관리자 계정일때 수정, 삭제 표시 --> --%>
<%-- 			<%@include file="../room/room.jsp" %>  --%>
<%-- 				</c:if> --%>
		
<%-- 			<%@include file="../room/list.jsp" %> --%>
	</div>
</body>
</html>