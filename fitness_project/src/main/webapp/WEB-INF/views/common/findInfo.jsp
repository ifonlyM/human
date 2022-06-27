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
						<h1 class="page-title">비밀번호 재설정</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="content">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
					<h1 class="mb60">비밀번호 재설정</h1>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
					<div class="row">
						<!-- Textarea -->
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<!-- Text input 아이디-->
							<div class="form-group">
								<label class=" control-label" for="id">ID :</label>
								<input id="id-input" name="userid" type="text" class="form-control" placeholder="사용할 아이디를 입력해 주세요" autocomplete="off">
								<span id="id-check"></span>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<!-- Text input 비밀번호-->
							<div class="form-group">
								<label class=" control-label" for="password">PassWord :</label>
								<input id="pw-input" name="userpw" type="password" class="form-control">
								<span id="pw-check"></span>
							</div>
							<div class="form-group">
								<label class=" control-label" for="password">Check your Password :</label> 
								<input id="pwck-input" name="pwck-input" type="password" class="form-control">
								<span id="pwck-check"></span>
							</div>
						</div>
						<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
							<!-- Button -->
							<div class="join-button">
								<button id="btn-setpw" name="singlebutton" class="btn btn-default">비밀번호 변경</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="map" id="map"></div>
	<div class="tiny-footer">
		<div class="container">
			<div class="row"></div>
		</div>
	</div>
	<jsp:include page="../includes/footer.jsp" />
	<!-- back to top icon -->
	<a href="#0" class="cd-top" title="Go to top">Top</a>
	<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
	<jsp:include page="../includes/foot.jsp" />
	
	<!-- 토큰 -->
	<script>
	 	var csrfHeader = $("meta[name='_csrf_header']").attr("content")
		var csrfToken = $("meta[name='_csrf']").attr("content");
	 	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	 	var contextPath = "${pageContext.request.contextPath}";
	 	
		if(csrfHeader && csrfToken){
			$(document).ajaxSend(function(e, xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			});
		}
    
	    $(function(){
	    	// form태그 사용시 태그안에 csrf 토큰 추가
			//$("#join_form").append("<input type='hidden' name='"+csrfParameter+"' value='"+csrfToken+"'/>");
	    	
		   	$("#btn-setpw").click(function(){
		   		if(!validId($("#id-input").val())){
		   			alert("아이디 검사에 실패했습니다.");
		   			return;
		   		}
		   		
		   		if(!pwDoubleCheck()){
		   			alert("입력한 비밀번호가 일치 하지 않습니다!!!");
					return;		   			
		   		}
		   		
		   		// 비밀번호 변경 비동기통신
		   		var url = contextPath + "/common/setpw";
		   		$.ajax(url, {
		   			type : "post",
		   			data : JSON.stringify({
		   				"userid" : $("#id-input").val(),
		   				"userpw" : $("#pw-input").val()
		   			}),
		   			contentType : "application/json; charset=utf-8",
		   			dataType : "text",
		   			success : function(result){
		   				alert("비밀번호 변경 완료");
		   				location.href = contextPath + "/common/login";
		   			},
		   			error : function (){
		   				alert("faill setpw ajax!!!")
		   			}
		   		});
		   		
		   	});
		   	
		   //존재하는 id인지 검사
		   	function validId(inputId){
		   		var url = contextPath + "/common/idCheck"
		   		$.ajax(url, {
		   			type : "post",
		   			data : inputId,
		   			contentType : "application/text; charset=utf-8",
		   			dataType : "json",
		   			success : function(result){
						if(result < 1){
							alert("존재하지 않는 ID 입니다.");
							return false;
						}
						else {
							return true;
						}
		   				
		   			},
		   			error : function(){
		   				alert("validId Check ajax error!!!");
		   				return false;
		   			}
		   		});
		   		return true;
		   	}
			
		 	// 비밀번호 더블체크
		   	function pwDoubleCheck(){
		   		var pwInput = $("#pw-input");
		   		var pwckInput = $("#pwck-input");
		   		
		   		if(pwInput.val() == "" || pwckInput.val() == ""){
		   			alert("비밀번호를 입력해주세요");
		   			return false;
		   		}
		   		else if(pwInput.val() != pwckInput.val()){
		   			return false;
		   		}
		   		else {
		   			return true;
		   		}
		   	}
		   	
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
