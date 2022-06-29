<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<html lang="ko">

<head>
<sec:csrfMetaTags />
<style>
.id_check_1 {
	color: blue;
	display: none;
}

.id_check_2 {
	color: red;
	display: none;
}

.final_pwck_re1 {
	color: green;
	display: none;
}

.final_pwck_re2 {
	color: red;
	display: none;
}
</style>

<jsp:include page="../includes/head.jsp" />

</head>

<body>
	<div class="page-header">
		<jsp:include page="../includes/header.jsp" />
		<div class="container">
			<div class="row">
				<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
					<div class="page-caption pinside40">
						<h1 class="page-title">회원가입</h1>
						<p>회원가입시에 'admin'문자를 포함하여 ID를 입력하면 관리자 권한이 부여됩니다.</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<h1 class="mb60">회원가입</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
					<form id="join_form" method="post">
						<div class="row">
							<!-- Textarea -->
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<!-- Text input 아이디-->
								<div class="form-group">
									<label class=" control-label" for="id">ID :</label>
									 <input id="id_input" name="userid" type="text" class="form-control" placeholder="회원가입시에 'admin'문자를 포함하여 ID를 입력하면 관리자 권한이 부여됩니다." autocomplete="off">
										<span id="id_check"></span>
									<!-- required 나중에 붙이기 -->
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<!-- Text input 비밀번호-->
								<div class="form-group">
									<label class=" control-label" for="password">PassWord :</label>
									<input id="pw_input" name="userpw" type="password" class="form-control">
									<span id="pw_check"></span>
									<!-- required 나중에 붙이기 -->
								</div>
								<div class="form-group">
									<label class=" control-label" for="password">Check your
										Password :</label> <input id="pwck_input" name="pwck_input" type="password" class="form-control">
										<span id="pwck_check"></span>
									<!-- required 나중에 붙이기 -->
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<label class=" control-label" for="gender">Gender :</label>
								<div class="form-group">
									<input type="radio" name="gender" value="M" checked>M
									<input type="radio" name="gender" value="F">F
								</div>
							</div>
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<!-- Text input 이름-->
								<div class="form-group">
									<label class=" control-label" for="name">Name :</label> 
									<input id="name_input" name="userName" type="text" class="form-control" placeholder="이름을 입력해주세요">
										<span id="nm_check"></span>
									<!-- required 나중에 붙이기 -->
									<!-- <span class="final_name">이름을 입력해주세요</span> -->
								</div>
							</div>
							<!-- Text input-->
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class=" control-label" for="email">E-mail :</label>
									<!-- <button id="singlebutton" name="singlebutton" class="btn btn-primary btn-sm">이메일 인증</button> -->
									<input id="email_input" name="email" type="text"
										class="form-control" placeholder="aaaa@bbbb.com">
										<span id="email_check"></span>
									<!-- required 나중에 붙이기 -->
									<!-- <span class="final_email">이메일을 입력해주세요</span> -->
								</div>
							</div>
							<!-- Text input-->
							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<div class="form-group">
									<label class="control-label" for="receiveRn">Phone :</label>
									
									<input id="receiveRn" name="phone" type="text" class="form-control" placeholder="01012345678">
									<button type="button" id="sendRn" name="singlebutton" class="btn btn-primary btn-sm">인증번호 발송</button>
									<span id="noHi"></span>
									
									<input id="inputRn" name="Rn_chk" type="text" class="form-control" placeholder="인증번호 입력" style="margin-top:20px">
									<button type="button" id="checkRn" name="singlebutton" class="btn btn-primary btn-sm">인증번호 확인</button>
									<span id="numCheck"></span>
									
									<!-- required 나중에 붙이기 -->
									<!-- <span class="final_phone">전화번호를 입력해주세요</span> -->
								</div>
							</div>

							<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
								<!-- Button -->
								<div class="join_button">
									<sec:csrfInput/>
									<input type="hidden" name="category" value="1">
									<button id="btn-join" name="singlebutton" class="btn btn-default">Submit</button>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="map" id="map"></div>
	<div class="tiny-footer">
	</div>
	<jsp:include page="../includes/footer.jsp" />
	<!-- back to top icon -->
	<a href="#0" class="cd-top" title="Go to top">Top</a>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<jsp:include page="../includes/foot.jsp" />
	
	<script>
 	var csrfHeader = $("meta[name='_csrf_header']").attr("content")
	var csrfToken = $("meta[name='_csrf']").attr("content");
 	console.log(csrfHeader);
 	console.log(csrfToken	);
	if(csrfHeader && csrfToken){
		$(document).ajaxSend(function(e, xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		});
	}
    /*  회원가입 */
    $(document).ready(function(){
    	var isInvalid_ID = false;
    	var isDblCheck_ID = false;
    	var isInvalid_PW = false;
    	var isDblCheck_PW = false;
    	var isInvalid_NM = false;
    	var isInvalid_EM = false; 
    	var isInvalid_PH = false; // x
    	var isReceive = false;
    	var isPhoneChecked = false;
    	
	    // 아이디 중복검사
	    $('#id_input').blur(function() {
	    	var inputId = $("#id_input").val();
	    	
	    	if(!inputId){
	    		$("#id_check").text("아이디를 입력해주세요.");
	    		isInvalid_ID = false;
	    		return;
	    	}
	    	
	    	if(!isInvalid_ID) return;
	    	var url = "${pageContext.request.contextPath}/common/idCheck";
	    	$.ajax(url, {
	    		type : "post",
	    		data : inputId,
	    		contentType : "application/text; charset=utf-8", // 보내는 데이터 설정
	    		dataType : "json", // 반환받을 데이터 타입
	    		/* beforeSend : function(xhr) {
	    			xhr.setRequestHeader(csrfHeader, csrfToken);
	    		}, */
	    		success : function(result) {
					if(!result){ // 중복아닌 아이디일 경우
						$("#id_check").text("");
						$("#id_check").text("사용가능한 아이디입니다.");
						isDblCheck_ID = true;
					} else { // 중복인 아이디일 경우
						$("#id_check").text("");
						$("#id_check").text("중복된 아이디입니다.");
						isDblCheck_ID = false;
					}
				},
				error : function(request, status, error){
					alert("failed ajax idcheck");
				}
	    	});
	    	
	    });
	    
	    /* 아이디 유효성 검사 아이디 입력란에서 키업 이벤트마다 적용시키기*/
	    $("#id_input").keyup(function() {
    	  	invalidID($(this));
	    });
	    
		$("#id_input").focus(function() {
			invalidID($(this));
		});
	    
	    function invalidID(target){
	    	// 정규표현식을 이용해서 영어 소문자만, 첫글자 숫자제외 시키기
    	  	var idReg = /^[a-z]+[a-z0-9]{5,19}$/g;
        	if(!idReg.test(target.val())) {
	            $("#id_check").text("아이디는 영문자로 시작하는 6~20자 영문자 또는 숫자이어야 합니다.");
	            isInvalid_ID = false;
        	}
        	else {
        		$("#id_check").text("");
        		isInvalid_ID = true;
        	}
	    }
	  
	    
	    /* 비밀번호 유효성 검사 */
	    $("#pw_input").keyup(function() {
    	  	invalidPW($(this));
	    });
	    $("#pw_input").blur(function() {
	    	invalidPW($(this));
	    });
	    function invalidPW(target) {
	    	if(!/^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{10,}$/.test(target.val())){
    			$("#pw_check").text('숫자와 영문자 조합으로 10~15자리를 사용해야 합니다.');
    			isInvalid_PW = false;
    			drawPWCK();
    		}
	    	else {
    			$("#pw_check").text('사용가능한 비밀번호 입니다.');
    			isInvalid_PW = true;
    			drawPWCK();
	    	}
	    }
	    drawPWCK();
	    function drawPWCK() {
	    	if(isInvalid_PW){
				$("#pwck_input").closest("div").css("display", "block");
			}
			else {
				$("#pwck_input").closest("div").hide();
				$("#pwck_input").val("");
			}
	    }
	    /* 비밀번호 확인 일치 유효성 검사 */
	   	$("#pwck_input").keyup(function() {
	   		if($("#pw_input").val() === $(this).val()){
	   			$("#pwck_check").text("확인되었습니다.");
	   			isDblCheck_PW = true;
	   		}
	   		else {
	   			$("#pwck_check").text("다시확인해주세요.");
	   			isDblCheck_PW = false;
	   		}
	   	});
	    
	    
	    /* 이름 유효성 검사 */
	    $("#name_input").keyup(function() {
	    	if($("#name_input").val().search(/\s/) != -1 ){  /* -1 true */ 
	    		$("#nm_check").text("문자에 공백이 포함되어 있습니다.");
	    		isInvalid_NM = false;
	    	}
	    	else {
	    		isInvalid_NM = true;
	    	}
	    })
	    
	    /* 이메일 유효성 검사 */
	   	var ec = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	   	$("#email_input").keyup(function() {
	    	if($("#email_input").val().match(ec) != null ){
	    		$("#email_check").text("올바른 이메일 형식입니다..");
	    		isInvalid_EM = true;
	    	}else {
	    		$("#email_check").text("이메일 형식이 올바르지 않습니다.");
	    		isInvalid_EM = false;
	    	}
	    });
	    
	    /* 휴대폰 번호 유효성 검사 */ 
	    $("#receiveRn").keyup(function() {
	     var ph = /(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/g;
	    	if($("#receiveRn").val().match(ph) != -1 ){
	    		$("#noHi").text(" 특수문자 빼고 입력해주세요.")
	    		isInvalid_PH = false;
	    	}else {
	    		$("#noHi").text("인증번호 발송을 눌러주세요.")
	    		isInvalid_PH = true;
	    	}
		});
	    
	    // 휴대폰 인증번호 클릭시 인증api이용 문자메세지 전송.
	    var checkNum = "";
	    $("#sendRn").click(function() {
	    	var url = "${pageContext.request.contextPath}" + "/common/sendSMS";
	    	$.ajax(url , {
	    		type: "POST",
	    		data: $("#receiveRn").val(),
	    		contentType : "application/text; charset=utf-8",
	    		dataType : "json",
	    		success : function(num) {
	    			//alert("sendSMS success");
	    			
					checkNum = num;		
					console.log(checkNum);
					alert("인증번호: "+checkNum);
					isReceive = true;
	    		},
	    		error : function() {
	    			alert("sendSMS error");
	    			isReceive = false;
	    		}
	    	})
	    	
	    });
	    
	    
	    // 휴대폰 인증번호 확인
	    $("#checkRn").click(function() {
	    	if(isReceive){
	    		
	    		if($("#inputRn").val() == checkNum){
	    			$("#numCheck").text("인증이 완료되었습니다.");
		    		alert("인증이 완료되었습니다.");
		    		isPhoneChecked = true;
		    	}
	    		else{
	    			$("#numCheck").text("인증번호를 다시확인 해주세요.");
	    			alert("인증번호가 틀렸습니다.");
	    			isPhoneChecked = false;
	    		}
	    	}
	    	else {
    			$("#numCheck").text("인증번호 발송버튼을 눌러주세요.");
	    		alert("인증번호 발송버튼을 눌러주세요.");
	    		isPhoneChecked = false;
	    	}
	    });
	    
	    // 회원가입 버튼 클릭
	    $("#btn-join").click(function(e) {
	    	e.preventDefault();
	    	alert("회원가입 버튼작동");
	    	 
	    	 if(isInvalid_ID && isDblCheck_ID && 
    	 		isInvalid_PW && isDblCheck_PW &&
    	 		isInvalid_NM && isPhoneChecked && isInvalid_EM){
	    	
	    		 $("#join_form").submit();
	    	 }
	    	 else if(!isInvalid_ID){
	    		 alert("error : 입력된 아이디를 다시 확인해주세요.");
	    	 }
	    	 else if(!isDblCheck_ID){
	    		 alert("error : 중복되는 아이디 입니다.")
	    	 }
	    	 else if(!isInvalid_PW){
	    		 alert("error : 유효하지 않은 비밀번호 입니다.");
	    	 }
	    	 else if(!isDblCheck_PW){
	    		 alert("error : 확인용 비밀번호와 입력한 비밀번호가 일치하지 않습니다.")
	    	 }
	    	 else if(!isInvalid_NM){
	    		 alert("error : NAME 입력란에 공백이 포함되어 있습니다.");
	    	 }
	    	 else if(!isInvalid_EM){
	    		 alert("error : 이메일 형식이 올바르지 않습니다.")
	    	 }
	    	 else if(!isPhoneChecked){
	    		 alert("error : 휴대폰 인증이 완료되지 않았습니다.");
	    	 }
	    	
	    });
    });
   																	
    </script>
	<!--   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e59ff1ffd80d084ac77b713f9eab5ae7"></script>
	<script>
	// 지도 
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.51832913075534, 126.90641754572093),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
         mapOption = { 
        center: new kakao.maps.LatLng(37.51832913075534, 126.90641754572093), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

    var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

    // 지도를 클릭한 위치에 표출할 마커입니다
    var marker = new kakao.maps.Marker({ 
        // 지도 중심좌표에 마커를 생성합니다 
        position: map.getCenter() 
    }); 
    // 지도에 마커를 표시합니다
    marker.setMap(map); 

	</script>-->
</body>

</html>
