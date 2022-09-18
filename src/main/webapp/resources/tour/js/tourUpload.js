/**
 * 이미지 첨부파일 등록
 */

$(function(){
	
	var formObj = $("form[role='form']");
	$("button[type='submit']").on("click", function(e){
		// alert("submit");
		// 서브밋 이벤트 무시 - 진행은 계속 시킨다.
		e.preventDefault();

		console.log("submit click");

		var str = "";
		$(".uploadResult ul li").each(function(i, obj){ //li 태그 foreach -> li tag 안에 data-filename='data' 형식으로 있다.
			var jobj = $(obj);
			console.log(jobj);
			console.log(jobj.data("filename")); // li안에 data-filename='파일명'

			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
		}); // foreach문의 끝 - 추가한 input 태그 작성

		formObj.append(str).submit(); // 작성된 input 태그를 추가하고 서버에 전송한다.
		
	});

	// 올릴 수 없는 파일의 종류 정규표현식
	// 대소문자 구분하지 않음 설정 "i" -> 정규표현식에 해당되는 것만 작성하는 경우 /(.*?)\.(exe|sh|zip|alz)$/i
	// 이미지 파일 : jpg, JPG, Jpg
	// 이미지인 경우 - 섬네일 파일을 따로 만든다. - 이미지에 판단과 섬네일 만드는 작업 JAVA(Controller)에서 한다.
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$", "i"); 
	// 현재 보이고 있는 페이지에서의 한개의 파일 용량 제한.
	var maxSize = 5242800; //5MB

	// 파일에 대한 데이터 유효성 함수.
	function checkExtension(fileName, fileSize){
		// 파일 사이즈 검사
		if(fileSize > maxSize){
			alert("파일 사이즈 초과");
			return false;
		}
		// 파일의 종류 검사
		if(regex.test(fileName)){
			alert("해당 종류의 파일은 업로드할 수 없습니다.");
			return false;
		}

		return true;
	}

	// 파일 선택이 되면 값이 변하는 change (파일 올리기 버튼 대신)이벤트 처
	$("input[type='file']").on("change", function(e){
		console.log("파일 첨부가 되었다.");
		// return false;
		// formData -> 사용 안함
		var formData = new FormData();
		console.log(formData);
		// input태그에서 name이 uploadFile인 것을 선택  -> inputFile은 여러개
		var inputFile = $("input[name='uploadFile']");
		console.log(inputFile);
		// inputFile[0] -> 제일 처음 것 선택하고 파일들을 꺼내 온다.
		var files = inputFile[0].files;
		console.log(files);

		// files를 formData에 한개 씩 꺼내서 추가
		for(var i = 0 ; i < files.length ; i ++){

			// 파일 체크를 한다. - 사이즈, 종류
			if(!checkExtension(files[i].name, files[i].size)){
				return false;
			};
			
			formData.append("uploadFile", files[i]);
		}

		// 서버에 데이터 넘겨서 처리하기
		$.ajax({
			url : "/uploadAjaxAction",
			processData : false,
			contentType : false,
			data:formData,
			type:'POST',
			dataType:"json",
			success: function(result){ // json 데이터로 result가 넘어온다. - 여기서의 result를 list이다.
				console.log("업로드한 파일의 정보 - result :" + JSON.stringify(result));
				// 업로드된 파일명 화면 표시
				showUploadFile(result);
				// input 태그의 값을 없애자.
				// $(".uploadDiv input").val("");
				// 교재는 첨부파일의 div객체 복사해 놨다가 처리가 다 끝나면 원래대로 복사해 둔것은 보이것곳으로 복원 복사시킨다.
			}
		}); // ajax 의 끝
		
	}); //  파일 선택이 되면 값이 변하는 change 이벤트의 끝


	
	// 파일명 리스트를 보여줄 ul 태그 선택
	var uploadResult = $(".uploadResult ul");

	// 파일명을 보여줄 함수
	function showUploadFile(list){
		// ul tag 비우기
		// uploadResult.empty();
		
		var str = "";
		// list를 데이터가 있는 만큼 반복 처리한다. foreach : each()
		// each(function(index, dto))
		$(list).each(function(i, obj){
			var fileCallPath = "";
			str += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid
				 +"' data-filename='" + obj.fileName + "' data-type='"+obj.image+"'>";
			str += "<div>";
			if(!obj.image){
				//이미지가 아닌 경우의 내용
				// 다운로드 받을 파일 정보를 만든다.(조립)
				fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" +obj.fileName);
				str += "<a href='/download?fileName="+fileCallPath+"'>";
				str += "<span class='glyphicon glyphicon-floppy-open'></span> " 
					+ obj.fileName;
				str += "</a>"
			} else {
				// 이미지인 경우의 내용
				// 불러올 파일 정보를 만든다.(조립)
				fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" +obj.fileName);
				// s_ 가 없는 원래 이미지 파일
				var originPath = obj.uploadPath + "\\" + obj.uuid + "_" +obj.fileName;

				// \\ -> \ 로 변환되어 처리된다. \\ ==> / 로 변환시키자.
				originPath = originPath.replace(new RegExp(/\\/g), "/");

				// javascript:showImage() -> javascript tag 바로 아래 showImage()를 찾는다.
				str += "<a href=\"javascript:showImage(\'" + originPath + "\')\">";
				str += "<img src='/display?fileName=" + fileCallPath + "'style='max-width:100px;'>";
				str += "</a>"
			} // if else의 끝
			str += "<span class=\'deleteX\' data-file=\'" + fileCallPath + "\' data-type=\'" + (obj.image?"image":"file") + "\'>";
			str += " x ";
			str += "</span>";
			str += "</div>";
			str += "</li>";
		}); // foreach의 끝

		// ul tag에 추가
		uploadResult.append(str);
	} // 파일명을 보여줄 함수의 끝
	
	// 파일 삭제 이벤트 - 이벤트는 JS에 의해서 나중에 만들어진 객체 : 그래서 반드시 on 함수를 사용.
	// $(html.body에 존재하는 객체 선택).on(이벤트, 앞에 선택된 객체 안에서 찾을 객체, 실행함수())
	$(".uploadResult").on("click", ".deleteX", function(e){
		// alert("파일 삭제");
		var deleteX = $(this);
		// 서버에 넘겨 줄 데이터 수집
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile + " - " + type);

		$.ajax({
			url : '/deleteFile', // 호출 URL
			data : {fileName : targetFile, type : type}, // 삭제를 위한 정보
			dataType : 'text', // 서버에서 결과로 전달되는 데이터 형식
			type : 'POST', // 전달 방식
			success : function(result){ // 서버의 처리가 성공하면 실행되는 함수.
				alert(result);
				deleteX.closest("li").remove();
				// alert(deleteX.prop('tagName'));
			}
		});
	});// 파일 삭제 이벤트의 끝

	
	
	
}); // $(function(){}) 의 끝