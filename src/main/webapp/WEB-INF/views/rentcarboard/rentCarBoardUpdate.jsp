<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!-- <script -->
<!-- 	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->
<title>렌트카 등록</title>
<style type="text/css">
.row{
	display: grid;
}
</style>

<script type="text/javascript" src="/resources/rentCar/regEx.js"></script>
<script type="text/javascript" src="/resources/rentCar/form.js"></script>


<script>

var loginId = "${login.id}";
$(function(){
	$("#cancelBtn").on("click",function(){
		location='/rentcarboard/rentCarBoardView.do?carNo=${param.carNo}&carInfoNo=${param.carInfoNo }&companyNo=${param.companyNo }&page=${param.page}&perPageNum=${param.perPageNum}&key=${param.key}&word=${param.word}';
		
		});
})
</script>
<script type="text/javascript" src="/resources/rentCar/rentCarJS/rentcarboard/updateFunc.js"></script>
<script type="text/javascript" src="/resources/rentCar/rentCarJS/rentcarboard/updateEvent.js"></script>


</head>
<body>
	<div class="container">
		<h2>렌트카 수정</h2>
		<form method="post" id="actionForm">
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="perPageNum" value="${param.perPageNum}">		
	
			<input type="hidden" value="${varsVO.carNo }">
			<!-- /.row -->
			<div class="row">
				<!-- /.col-lg-12 차량 정보 표시 -->
				<div class="col-lg-12">
					<div class="panel panel-default row">
						<!-- 테이블의 소제목 -->
						<div class="panel-heading">등록할 회사, 차량</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
							<div>
							회사
								<select class="form-control" name="companyNo" id="selectCompany">
										<option>회사 선택</option>
									<c:forEach items="${companys }" var="company">
										<option value="${company.companyNo }" data-id="${company.id }" ${(carsVO.companyNo == company.companyNo)? 'selected':''} >${company.companyName }</option>
									</c:forEach>
								</select>
										차량
								<select name="carInfoNo" class="form-control">
									<c:forEach items="${allCarBasicInfo }" var="carBasicInfo">
										<option value="${carBasicInfo.carInfoNo }">
										${carBasicInfo.carName }, 
										${carBasicInfo.carTypes }, 
										${carBasicInfo.carFuel},
										${carBasicInfo.carCapacity }
										</option>
									</c:forEach>
								</select>
							
							
							</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 차량 정보 표시 -->
			</div>
			<!--/. row -->			
			
			
			<!-- /.row 렌터카 정보 입력 -->
			<div class="row">
				<!-- /.col-lg-12 차량 정보 표시 -->
				<div class="col-lg-12">
					<div class="panel panel-default row">
						<!-- 테이블의 소제목 -->
						<div class="panel-heading">렌터카 정보 입력</div>
						<!-- /.panel-heading -->
						<div class="panel-body form-group">
							<div>
								<label for="price">가격</label> <input class="form-control" id="price" value="<fmt:formatNumber value='${carsVO.price }' pattern='#,###'/>"/>
							</div>
							<div>
							변속기
								<select class="form-control" name="gearbox">
									<option value="수동" ${(carsVO.gearbox == '수동')? 'selected':''}>수동</option>
									<option value="자동" ${(carsVO.gearbox == '자동')? 'selected':''}>자동</option>
								</select>
							</div>
							<div>
								<!-- yyyy-MM -->
								<label for="modelYears">연식</label> 
<!-- 								<input class="form-control" name="modelYears" -->
<%-- 									id="modelYears" value="${carsVO.modelYears }" /> --%>
									<input onKeyup="inputYMDNumber(this);" name="modelYears" id="modelYears" value="${carsVO.modelYears }" placeholder="yyyy-MM" style="text-align:center;" class="form-control"/>
							</div>
							<div>
							보험
								<select class="form-control" name="insuranceType">
									<option value="자차미포함" ${(carsVO.insuranceType == '자차미포함')? 'selected':''}>자차미포함</option>
									<option value="일반자차포함" ${(carsVO.insuranceType == '일반자차포함')? 'selected':''}>일반자차포함</option>
									<option value="고급자차포함" ${(carsVO.insuranceType == '고급자차포함')? 'selected':''}>고급자차포함</option>
								</select>
							</div>
							<div>
								<!-- 숫자만 -->
								<label for="rentAge">대여가능 나이</label> <input class="form-control" 
									id="rentAge" value="${carsVO.rentAge }살"/>
							</div>
				
							<div>
								<!-- 숫자만 -->
								<label for="rentExperience">대여가능 운전 경력</label> <input class="form-control"
									 id="rentExperience"  value="${carsVO.rentExperience }년"/>
							</div>
							<div>
								<label for="license">면허</label> <input class="form-control"
									name="license" id="license" value="${carsVO.license }"/>
							</div>
							<div>
								<label for="insuranceInfo">보험내용</label>
								<textarea class="form-control" rows="10" name="insuranceInfo" id="insuranceInfo">${carsVO.insuranceInfo }</textarea>
							</div>
							<div>
								<label for="rentCarNote">참고사항</label>
								<textarea class="form-control" rows="10" name="rentCarNote" id="rentCarNote">${carsVO.rentCarNote }</textarea>
							</div>
							<div>
								<label for="cancelAndRefund">취소/환불규정</label>
								<textarea class="form-control" rows="10" name="cancelAndRefund" id="cancelAndRefund">${carsVO.cancelAndRefund }</textarea>
							</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 차량 정보 표시 -->
			</div>
			<!--/. row -->	
			
			<!-- /.row 렌터카 옵션 입력 -->
			<div class="row">
				<!-- /.col-lg-12 차량 정보 표시 -->
				<div class="col-lg-12">
					<div class="panel panel-default row">
						<!-- 테이블의 소제목 -->
						<div class="panel-heading">렌터카 옵션 선택</div>
						<!-- /.panel-heading -->
						<div class="panel-body form-group">						
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="smoking" value="금연차량" ${(carOptionVO.smoking == '금연차량')? 'checked':''}>금연차량
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="navigation"value="네비게이션" ${(carOptionVO.navigation == '네비게이션')? 'checked':''}>네비게이션
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="blackbox"value="블랙박스"${(carOptionVO.blackbox == '블랙박스')? 'checked':''}>블랙박스
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="rearCamera"value="후방카메라"${(carOptionVO.rearCamera == '후방카메라')? 'checked':''}>후방카메라
									</label>
								</div>
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="frontSensor"value="전방센서"${(carOptionVO.frontSensor == '전방센서')? 'checked':''}>전방센서
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="rearSensor"value="후방센서"${(carOptionVO.rearSensor == '후방센서')? 'checked':''}>후방센서
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="sunroof"value="썬루프"${(carOptionVO.sunroof == '썬루프')? 'checked':''}>썬루프
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="bluetooth"value="블루투스"${(carOptionVO.bluetooth == '블루투스')? 'checked':''}>블루투스
									</label>
								</div>
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="heatingSheet"value="열선시트"${(carOptionVO.heatingSheet == '열선시트')? 'checked':''}>열선시트
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="heatingHandle"value="열선핸들"${(carOptionVO.heatingHandle == '열선핸들')? 'checked':''}>열선핸들
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="leatherSheet"value="가죽시트" ${(carOptionVO.leatherSheet == '가죽시트')? 'checked':''}>가죽시트
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="ventilationSheet"value="통풍시트" ${(carOptionVO.ventilationSheet == '통풍시트')? 'checked':''}>통풍시트
									</label>
								</div>
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="carSeatPay"value="카시트(유료)" ${(carOptionVO.carSeatPay == '카시트(유료)')? 'checked':''}>카시트(유료)
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="carSeatFree"value="카시트(무료)" ${(carOptionVO.carSeatFree == '카시트(무료)')? 'checked':''}>카시트(무료)
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="driverAirbag"value="운전석에어백" ${(carOptionVO.driverAirbag == '운전석에어백')? 'checked':''}>운전석에어백
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="passengerAirbag"value="조수석에어백" ${(carOptionVO.passengerAirbag == '조수석에어백')? 'checked':''}>조수석에어백
									</label>
								</div>
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="fourWheel"value="4륜구동" ${(carOptionVO.fourWheel == '4륜구동')? 'checked':''}>4륜구동
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="smartKey"value="스마트키" ${(carOptionVO.smartKey == '스마트키')? 'checked':''}>스마트키
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="rearAutomaticDoor"value="뒷자석자동문" ${(carOptionVO.rearAutomaticDoor == '뒷자석자동문')? 'checked':''}>뒷자석자동문
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="freeCharge"value="전기충전무료" ${(carOptionVO.freeCharge == '전기충전무료')? 'checked':''}>전기충전무료
									</label>
								</div>
								<div>
									<label class="checkbox-inline">
									<input type="checkbox" name="usb"value="usb" ${(carOptionVO.usb == 'usb')? 'checked':''}>USB
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="aux"value="aux" ${(carOptionVO.aux == 'aux')? 'checked':''}>AUX
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="dmb"value="dmb" ${(carOptionVO.dmb == 'dmb')? 'checked':''}>DMB
									</label>
									<label class="checkbox-inline">
									<input type="checkbox" name="camping"value="캠핑카" ${(carOptionVO.camping == '캠핑카')? 'checked':''}>캠핑카
									</label>
								</div>
						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
				</div>
				<!-- /.col-lg-12 차량 정보 표시 -->
			</div>
			<!--/. row -->
							
			
			<div>
				<button type="button" id="submitBtn" class="btn btn-default">등록</button>
				<button type="reset" class="btn btn-default">새로입력</button>
				<button type="button" id="cancelBtn" class="btn btn-default">취소</button>
			</div>
		</form>



	</div>
</body>
</html>