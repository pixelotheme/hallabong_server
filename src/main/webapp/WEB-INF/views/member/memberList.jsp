<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pageObject" tagdir="/WEB-INF/tags" %>  

<!DOCTYPE html>
<html>
<head>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<meta charset="UTF-8">
<title>회원 리스트</title>
  
<style type="text/css">
.dataRow:hover{
	cursor: pointer;
	background: #eee;
}
</style>

<script type="text/javascript">
// 객체 선택에 문제가 있다. 아래 Document가 다 로딩이 되면 실행되는 스크립트 작성
// jquery -> $(function(){처리문 만들기;}) = jquery(function(){처리문 만들기;})
$(function(){ // jquery에서 익명함수를 전달해서 저장해놨다가 Document가 로딩이 다되면 호출해서 처리해준다.
	$(".gradeModifyBtn").click(function(){
		// alert("등급변경 버튼 클릭");
		// id 찾기와 셋팅
		var id = $(this).closest(".dataRow").find(".id").text();
		$("#formId").val(id);
		// 등급번호 찾기와 셋팅
		var gradeNo = $(this).closest(".dataRow").find(".gradeNo").text();
		// alert(gradeNo);
		$(".formGradeNo").val([gradeNo]);
	});

	$("#formGradeModifyBtn").click(function(){

		var gradeNo = $(".gradeNo:checked").val();

		})
		
	
	
	//
	$(".dataRow").click(function(){
		var id = $(this).find(".id").text();
// 		// 페이지 정보 붙이기
		var query = ${(empty pageObject)?"''":"'&page=" += pageObject.page
				+= "&perPageNum=" += pageObject.perPageNum += "'"};
		location = "view.do?id=" + id;
		
	});

	
});
</script>

</head>
<body>
<div class="container">
<h1>회원 리스트</h1>
<table class="table">
	<!-- 제목 -->
	<thead>
		<tr>
			<th>회원 번호</th>
			<th>아이디</th>
			<th>이름</th>
			<th>연락처</th>
			<th>등급번호</th>
			<th>등급이름</th>
		</tr>
	</thead>
	<tbody>
		<!-- 데이터가 있는 만큼 반복이 되어 지는 시작 부분 -->
		<c:forEach items="${list }" var="vo">
		<tr class="dataRow">
			<td class="memberNo">${vo.memberNo }</td>
			<td class="id">${vo.id }</td>
			<td>${vo.name }</td>
			<td>${vo.tel }</td>
			<td class="gradeNo">${vo.gradeNo }</td>
			<td>${vo.gradeName }
				<c:if test="${vo.id != login.id }">
					<!-- 내 계정이 아니면 변경버튼이 나타난다. -->
					<button class="gradeModifyBtn" 
						data-toggle="modal" data-target="#myModal">변경</button>
				</c:if>
			</td>
		</tr>
		</c:forEach>
		<!-- 데이터가 있는 만큼 반복이 되어 지는 끝 부분  !-->
	</tbody>
</table>
		<pageObject:pageNav listURI="memberList.do" pageObject="${pageObject }" />
</div>


<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">등급 수정</h4>
      </div>
      <div class="modal-body">
        <p>
        	<form action="gradeModify.do" method="post" id="gradeModifyForm">
        		<div class="form-group">
        			<label for="id">아이디</label>
        			<input name="id" id="formId" readonly="readonly" class="form-control"/>
        		</div>
        		<div>
        			<div><label>등급</label></div>
        			<label class="radio-inline">
        				<input type="radio" name="gradeNo" value="1"
        				 class="formGradeNo">일반</label>
        			<label class="radio-inline">
        				<input type="radio" name="gradeNo" value="2"
        				 class="formGradeNo">탈퇴</label>
        			<label class="radio-inline">
        				<input type="radio" name="gradeNo" value="3"
        				 class="formGradeNo">휴면</label>
					<label class="radio-inline">
						<input type="radio" name="gradeNo" value="9"
						 class="formGradeNo">관리자</label>
        		</div>
        	</form>
        </p>
      </div>
      <div class="modal-footer">
        <button type="submit" class="btn btn-default" id="formGradeModifyBtn">변경</button>
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
      </div>
    </div>

  </div>
  
</div>

</body>
</html>