<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<sec:csrfMetaTags />
	<style>

    </style>
<jsp:include page="../includes/head.jsp" />
</head>

<body>
 <a href="../common/joinUs"></a>
    <div class="page-header">
    <jsp:include page="../includes/header.jsp" />
       
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">Error</h1>
                        <h2 style="color: white"><c:out value="${SPRING_SECURITY_403_EXCEPTION.getMessage() }"/></h2>
                        <h2 style="color: white"><c:out value="${msg}"/></h2>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <div class="container">
	        <div>
	       		<button id="backspace" style="border: hidden">
	       			<a class="btn btn-primary btn-sm" href="../common/index">뒤로가기</a>
	       		</button>
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
