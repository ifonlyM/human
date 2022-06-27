<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">

<head>
<sec:csrfMetaTags />
	<style>
        .btn {padding-bottom: 35px;}

    </style>
<jsp:include page="../includes/head.jsp" />
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
</head>

<body>
    <div class="page-header">
    <jsp:include page="../includes/header.jsp" />
       
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">아이디입력</h1>
                        <p>
                       		아이디를 입력해주세요
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="container">
        <div class="row">
            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                <h1 class="mb60">아이디 입력</h1>
            </div>
        </div>
            <div class="row">
                <div class="col-lg-8 col-md-8 col-sm-6 col-xs-12">
                    <!-- <form class="checkIn" method="post"></form> -->
                        <div class="row">
                            <!-- Textarea -->
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <!-- Text input 아이디-->
                                <div class="form-group">
                                    <label class=" control-label" for="id">ID :</label>
                                    <input id="id_input" name="userId" type="text" class="form-control">
                                    <span id="id_check"></span>
                                    <!-- required 나중에 붙이기 -->
                                </div>
                            </div>
                            <sec:csrfInput/>
                            <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                                <!-- Button -->
                                <div class="form-group">
                                    <a href="${pageContext.request.contextPath}/common/memberModify" class="btn btn-default">다음</a>
                                </div>
                            </div>
                        </div>
                    
                </div>
            </div>
        </div>
    </div>
    <div class="map" id="map"></div>
 
    <jsp:include page="../includes/footer.jsp" />
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>
    <jsp:include page="../includes/foot.jsp" />
	<!-- <script type="text/javascript">
	window.Kakao.init("e59ff1ffd80d084ac77b713f9eab5ae7");
	  function loginWithKakao() {
		 window.Kakao.Auth.login({
	      success: function(authObj) {
	        alert(JSON.stringify(authObj))
	      },
	      fail: function(err) {
	        alert(JSON.stringify(err))
	      },
	    })
	  }
	</script> -->
<script>
	var csrfHeader = $("meta[name='_csrf_header']").attr("content")
	var csrfToken = $("meta[name='_csrf']").attr("content");
	if(csrfHeader && csrfToken){
		$(document).ajaxSend(function(e, xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		});
	}
	
	$(document).ready(function(){
	    	var isInvalid_ID = false;
	    	var isDblCheck_ID = false;
	    	
		    // 아이디 중복검사
		    $('#id_input').blur(function() {
		    	var inputId = $("#id_input").val();
		    	
		    	if(!inputId){
		    		$("#id_check").text("아이디를 입력해주세요.");
		    		isInvalid_ID = false;
		    		return;
		    	}
		    	
		    	if(!isInvalid_ID) return;
		    	var url = "${pageContext.request.contextPath}/common/idChk";
		    	$.ajax(url, {
		    		
		    		type : "post",
		    		data : inputId,
		    		contentType : "application/text; charset=utf-8", // 보내는 데이터 설정
		    		dataType : "json", // 반환받을 데이터 타입
		    		success : function(result) {
						if(!result){ // 중복아닌 아이디일 경우 -> 없는 아이디입니다.
							$("#id_check").text("");
							$("#id_check").text("없는 아이디 입니다.");
							isDblCheck_ID = true;
						} else { // 중복인 아이디일 경우 
							$("#id_check").text("");
							$("#id_check").text("아이디가 일치합니다");
							isDblCheck_ID = false;
						}
					},
					error : function(request, status, error){
						alert("failed ajax idcheck");
					}
					
		    	});// End of idChk ajax
		    	
		    }); // End of #id_input blur event
		    
	 }); // End of Ready
</script>

<!-- 
   <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e59ff1ffd80d084ac77b713f9eab5ae7"></script>
	<script>
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

	</script> -->
</body>

</html>
