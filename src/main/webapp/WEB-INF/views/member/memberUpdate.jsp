<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보 수정</title>

<link href="/resources/css/updateForm.css" rel="stylesheet" />
<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


<script type="text/javascript">

function execPostCode() {
	new daum.Postcode({
		oncomplete : function(data) {
			// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

			// 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
			// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
			var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
			var extraRoadAddr = ''; // 도로명 조합형 주소 변수

			// 법정동명이 있을 경우 추가한다. (법정리는 제외)
			// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
			if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
				extraRoadAddr += data.bname;
			}
			// 건물명이 있고, 공동주택일 경우 추가한다.
			if (data.buildingName !== '' && data.apartment === 'Y') {
				extraRoadAddr += (extraRoadAddr !== '' ? ', '
						+ data.buildingName : data.buildingName);
			}
			// 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
			if (extraRoadAddr !== '') {
				extraRoadAddr = ' (' + extraRoadAddr + ')';
			}
			// 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
			if (fullRoadAddr !== '') {
				fullRoadAddr += extraRoadAddr;
			}

			// 우편번호와 주소 정보를 해당 필드에 넣는다.
			console.log(data.zonecode);
			console.log(fullRoadAddr);

			$("[id=addr1]").val(data.zonecode);
			$("[id=addr2]").val(fullRoadAddr);

			/* document.getElementById('signUpUserPostNo').value = data.zonecode; //5자리 새우편번호 사용
			document.getElementById('signUpUserCompanyAddress').value = fullRoadAddr;
			document.getElementById('signUpUserCompanyAddressDetail').value = data.jibunAddress; */
		}
	}).open();
}
	
	$(function(){
		$("#pwChange").hide();
			$("#pwChangeBtn").click(function(){
				confirm("비밀번호를 변경하시겠습니까?");
				if(confirm == 1) {
					$("#pwChange").show();
					}


				})
		});
		
	
	// 비밀번호 확인
	$(function(){
		$("#joinForm").submit(function(){
			if($("#pw").val() !== $("#pw2").val()){
				alert("비밀번호가 다릅니다.");
				$("#pw").val("").focus();
				$("#pw2").val("");
				return false;
			}else if ($("#pw").val().length < 8) {
				alert("비밀번호는 8자 이상으로 설정해야 합니다.");
				$("#pw").val("").focus();
				return false;
			}else if($.trim($("#pw").val()) !== $("#pw").val() || $.trim($("#email").val()) !== $("#email").val() || $.trim($("#id").val()) !== $("#id").val()){
				alert("공백은 입력이 불가능합니다.");
				return false;
			}
		});			
		$("#ExInfo").hide();
		
		$("#ExInfoBtn").click(function(){
			$("#ExInfo").show();
			$("#Info").hide();

			});

	});
</script>


</head>
<body>
	<!-- header -->
		<!-- wrapper -->
		<div id="wrapper">

			<!-- content-->
			<div id="content">

	<form action="memberUpdate.do" id="memberUpdate" method="post">


				<div>
					<h3 class="join_title">
						<label for="id">아이디</label>
					</h3>
					<span class="box int_id" style="background:#eee;"> <input type="text" id="id"
						name="id" class="int" maxlength="20" pattern = "[A-za-z0-9]{5,20}" value="${vo.id }" readonly style="background:#eee;">
					</span> 
				</div>
			
			<div>
				<a class="btn btn-success" id="pwChangeBtn">비밀번호 변경</a>
			</div>
				<div id="pwChange">
				<div>
					<h3 class="join_title">
						<label for="pswd1">비밀번호</label>
					</h3>
					<span class="box int_pass"> <input type="password" id="pw1"
						name="pw" class="int" maxlength="20" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" required="required" readonly style="background:#eee;"> <span id="alertTxt">사용불가</span>
						<img src="/resources/image/m_icon_pass.png" id="pswd1_img1"
						class="pswdImg" >
					</span> 
					<span class="error_next_box"></span>
				</div>

				<div>
					<h3 class="join_title">
						<label for="pswd2">비밀번호 재확인</label>
					</h3>
					<span class="box int_pass_check"> <input type="password"
						id="pw2" name="pw2" class="int" maxlength="20" pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{8,16}$" required="required" readonly style="background:#eee;"> <img
						src="/resources/image/m_icon_check_disable.png" id="pswd2_img1"
						class="pswdImg">
					</span> 
					<span class="error_next_box"></span>
				</div>
			</div>

				<div>
					<h3 class="join_title">
						<label for="name">이름</label>
					</h3>
					<span class="box int_name"> <input type="text" id="name"
						name="name" class="int" maxlength="20" required="required" value="${vo.name }">
					</span> 
					<span class="error_next_box"></span>
				</div>
				
				
				<div>
					<h3 class="join_title">
						<label for="birth">생년월일</label>
					</h3>
					<span class="box int_birth" style="background:#eee;"> <fmt:formatDate value="${vo.birth }"/>
					</span> 
					<span class="error_next_box"></span>
				</div>
				
				
				<div>
					<h3 class="join_title">
						<label for="gender">성별</label>
					</h3>
					<span class="box gender_code"> <input type="text" id="gender"
						name="gender" class="int" value="${vo.gender }">
					</span> 
					<span class="error_next_box">필수 정보입니다.</span>
				</div>
				<div>
					<h3 class="join_title">
						<label for="email">이메일</label>
					</h3>
					<span class="box int_email" style="background:#eee;"> <input type="text" id="email" name="email"
						class="int" maxlength="100" pattern = [a-z0-9]{2,}@[a-z0-9-]{2,}\.[a-z0-9]{2,} required="required" value="${vo.email }" readonly style="background:#eee;">
					</span> 
				</div>
				<div>
					<h3 class="join_title">
						<label for="phoneNo">휴대전화</label>
					</h3>
					<span class="box int_mobile"> <input type="tel" id="mobile" name="tel"
						class="int" maxlength="16" placeholder="- 없이 숫자만 입력해주세요." pattern="([01]{2})([01679]{1})([0-9]{3,4})([0-9]{4})" required="required" value="${vo.tel }">
					</span> 
					<span class="error_next_box"></span>
			
				</div>
				
				<div id="Info">
				<a class="btn btn-success" id="ExInfoBtn"> 추가정보 입력 </a>
						<br>			
					<strong>추가 정보 입력시 10,000원 상당의 쿠폰을 드립니다.</strong>
				</div>
					
			<div id ="ExInfo">
					<div>
					<label for="address">주소</label><br>
					<span class="post int_mobile"> <input
						class="int" style="width: 40%; display: inline; background:#eee;"
						placeholder="우편번호" name="zonecode" id="addr1" type="text"
						readonly="readonly" > 
					<button type="button" class="btn btn-default"
						onclick="execPostCode();" style="padding: 14px 12px; margin-left: 170px; margin-top: -52px; border-radius: 1px;">
						<i class="fa fa-search"></i> 우편번호 찾기
					</button>
					</span>
				</div>
				<div>
					<span class="postbox int_mobile"><input class="int" placeholder="도로명 주소"
						name="address" id="addr2" type="text" readonly="readonly"  style="background:#eee;" value="${vo.address }" /> </span>
				</div>
				<div>
					<span class="postboxtext int_mobile"> 
					<input class="int" placeholder="상세주소" name="address" id="addr3" type="text" /> </span>
				</div>
				
				<div>
					<label for="hobby">취미</label><br>
					<span class="box int_hobby"> <input type="text" id="hobby"
						name="hobby" class="int" maxlength="20">
					</span> 
					<span class="error_next_box"></span>
				</div>
								
				
				<div>
					<label for="license">운전 면허 종류</label>
					<span class="box int_license" >
						<input name="license" type="radio" value="1종 보통" name="license"> 1종 보통
						<input name="license" type="radio" value="1종 대형" name="license"> 1종 대형
						<input name="license" type="radio" value="2종 오토" name="license" checked="checked"> 2종 오토 
						<input name="license" type="radio" value="2종 수동" name="license"> 2종 수동
						<input name="license" type="radio" value="2종 소형" name="license"> 2종 소형			
						<input name="license" type="radio" value="2종 원동기" name="license"> 2종 원동기			
					</span> 
					<span class="error_next_box"></span>							
				</div>
		</div>			
					<div class="btn_area">
					<button id="btnJoin">
						<span>수정하기</span>
					</button>
				</div>		
	</form>

			</div>
			<!-- content-->

		</div>
		<!-- wrapper -->
<script src="/resources/js/main.js"></script>
</body>
</html>