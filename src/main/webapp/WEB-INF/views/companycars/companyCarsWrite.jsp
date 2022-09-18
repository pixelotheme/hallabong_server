<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
	<%@ taglib prefix="pageNav" tagdir="/WEB-INF/tags" %>


<!DOCTYPE html>
<html>
<head>

<title>렌트카 등록</title>
<meta charset="UTF-8">
<!-- <meta name="viewport" content="width=device-width, initial-scale=1"> -->
<!-- <link rel="stylesheet" -->
<!-- 	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"> -->
<!-- <script -->
<!-- 	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script> -->
<!-- <script -->
<!-- 	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script> -->

<style type="text/css">
.row{
	display: grid;
}
</style>


	
<script type="text/javascript" src="/resources/rentCar/rentCarJS/companycars/write.js"></script>

</head>
<body>
	<div class="container">
		<h2>번호판 등록</h2>
			
			<!-- 현재 보고있는  차량 의 번호판 목록 (같은회사의) ajax로 불러와 데이터 저장해둔뒤 넘어가는 데이터와 비교 
			
			-->
			
			<!-- 방금 등록한 차번호 -->
			<form action="" method="post" id="actionForm">
				<input type="hidden" name="carNo" value="${param.carNo }">
				<input type="hidden" name="companyNo" value="${param.companyNo}">
				<input type="hidden" name="carInfoNo" value="${param.carInfoNo}">

			<!-- /.row -->
			<div class="row">
				<!-- /.col-lg-12 차량 정보 표시 -->
				<div class="col-lg-12">
					<div class="panel panel-default row">
						<!-- 테이블의 소제목 -->
						<div class="panel-heading">번호판 등록
						<button id="licensePlatePlusbtn" type="button" class="btn btn-default">번호판 입력 추가</button>
						</div>
						<!-- /.panel-heading -->
						<div class="panel-body">
						
							<div id="licensePlateDiv" >
								<div>
									<label for="licensePlate">번호판</label> 
									<input name="licensePlate" id="licensePlate" class="form-control licensePlate">
								</div>
							
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
				<button type="button" id="resetBtn" class="btn btn-default">새로입력</button>
				<button type="button" id="cancelBtn" class="btn btn-default">취소</button>
			</div>
			</form>
			
			
			
			
		<!-- 


			 -->






	</div>
</body>
</html>