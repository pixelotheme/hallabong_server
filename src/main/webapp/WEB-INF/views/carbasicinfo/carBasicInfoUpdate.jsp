<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
            	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>
<!DOCTYPE html>
<html>
<head>
<title>차량 기본정보</title>

<meta charset="UTF-8">
<!--    <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!--   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!--   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!--   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<!-- 정규표현식 -->
<script type="text/javascript" src="/resources/rentCar/regEx.js"></script>
<script type="text/javascript" src="/resources/rentCar/form.js"></script>

<script type="text/javascript">
var loginGradeNo = "${login.gradeNo}";
var perPageNum = "${param.perPageNum}";
$(function(){
	$("#cancelBtn").on("click",function(){
		location='/carbasicinfo/carBasicInfoView.do?carInfoNo=${param.carInfoNo}&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}';
		
		});
})
</script>
<script type="text/javascript" src="/resources/rentCar/rentCarJS/carbasicinfo/updateFunc.js"></script>
<script type="text/javascript" src="/resources/rentCar/rentCarJS/carbasicinfo/updateEvent.js"></script>

</head>


<body>
	<div class="container">
	<h2>차량 기본정보 수정</h2>
		<form  method="post" id="actionForm" enctype="multipart/form-data">
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="perPageNum" value="${param.perPageNum}">				
			<div class="form-group">
				<!--  for 는 id 와 연결된다   name은 vo 변수명과 같아야한다-->
				<label for="carName">차 이름</label>
				<input name="carName" id="carName" class="form-control" required="required" value="${CarBasicInfo.carName }">
			</div>		
			
			<div>
			차종
				<select name="carTypes" class="form-control">
					<option value="소형" ${(CarBasicInfo.carTypes == '소형')? 'selected':''}>소형</option>
					<option value="중형"${(CarBasicInfo.carTypes == '중형')? 'selected':''}>중형</option>
					<option value="고급"${(CarBasicInfo.carTypes == '고급')? 'selected':''}>고급</option>
					<option value="suv/승합"${(CarBasicInfo.carTypes == 'suv/승합')? 'selected':''}>suv/승합</option>
					<option value="수입"${(CarBasicInfo.carTypes == '수입')? 'selected':''}>수입</option>
				</select>
			</div>
			
			<div class="form-group">
				<label for="carCapacity">차량 정원</label>
				<input id="carCapacity" class="form-control" required="required" value="${CarBasicInfo.carCapacity }명">
			</div>		
			<div>
				연료
				<select name="carFuel" class="form-control">
					<option value="휘발유"${(CarBasicInfo.carTypes == '휘발유')? 'selected':''}>휘발유</option>
					<option value="경유"${(CarBasicInfo.carTypes == '경유')? 'selected':''}>경유</option>
					<option value="LPG"${(CarBasicInfo.carTypes == 'LPG')? 'selected':''}>LPG</option>
					<option value="전기"${(CarBasicInfo.carTypes == '전기')? 'selected':''}>전기</option>
					<option value="하이브리드"${(CarBasicInfo.carTypes == '하이브리드')? 'selected':''}>하이브리드</option>
				</select>
			</div>

			
<!-- 			<div> -->
<!-- 				<label for="uploadFile">사진</label>  -->
<!-- 				<input type="file" name="uploadFile" multiple="multiple" > -->
<!-- 			</div> -->
			
			<div>
				<label for="license">사진</label> 
				<input type="file" name="uploadFile" class="btn btn-default">
			</div>
			
			<div>
			
			<label>기존 이미지</label>
			
				<img alt="차량 이미지가 없습니다" src="/upload/rentcarboard/${carFileUploadVO.realSavePath}/s_${carFileUploadVO.fileName}" width="100px">
				<c:if test="${!empty carFileUploadVO.orgFileName}">
				<p>${carFileUploadVO.orgFileName }</p>
				</c:if>

				<c:if test="${!empty carFileUploadVO.orgFileName }">
				<input name="del" value="${carFileUploadVO.fileName }" type="hidden" >
				</c:if>
			</div>
			
			
			
			<div>
				<button type="button" class="btn btn-default" id="submitBtn">수정</button>
				<button type="reset" class="btn btn-default">새로입력</button>
				<button type="button" id="cancelBtn" class="btn btn-default">취소</button>
			</div>
		
		</form>
		
		
		
	</div>
</body>
</html>