/** 
 *  2021-12-17 문현석
 *  트레이너 슬라이드 자바스크립트 구현부
 */

$(function() {
	var csrfHeader = $("meta[name='_csrf_header']").attr("content");
	var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content");
	
	var contextPath = sessionStorage.getItem("contextPath");
	var positions = [];
	var currPos = 0;
	
	// 트레이너들과 경력들을 맵형태로 가져옴 ==========================================================
	var url = contextPath + "/PTreserve/getTrainers";
	$.ajax( url, {
		type: "POST",
		dataType : "JSON",
		beforeSend: function(xhr){
		     xhr.setRequestHeader(csrfHeader, csrfToken);   
		},
		success : function(careers) {
			// 서버에서 가져온 Map<String(json), List<careerVo>> 정보를 이용해 html작성
			for(var trainer in careers) {
				var t = JSON.parse(trainer); // json 문자열(memberVo)을 js Object로 변경
				
				trainerCard(t, careers[trainer]);
			}
			
			//트레이너 정보 갯수만큼 슬라이드 부모영역의 넓이를 지정
			$("#trainers-sl").css("width", "calc(100% * " + $(".card-section").length + ")");
			
			//트레이너 수 만큼 슬라이드 포이션 지정
			setPositions();
			
			//초기 슬라이드 포지션 0으로 지정
			currPos = 0;
			console.log(positions);
			
			//슬라이드 인덱스 설정
			slideIndex($(".card-section").length);
			//slideIndex 초기 색깔 지정
    		$("#trainers-index li").eq(currPos).css("background-color", "#c5f016");
			console.log($("#trainers-index li").eq(currPos));
		},
		error:function(request,status,error){
	        alert("code = "+ request.status + " message = " + request.responseText + " error = " + error); // 실패 시 처리
	    }
	});
	
	// 브라우저크기가 변할때마다 포지션 재 지정
	$(window).resize(function() {
		setPositions();
		console.log("resize");
	});
	
	//트레이너 갯수만큼 슬라이드 포지션배열을 지정
	function setPositions() {
		var temp = [];
		for(var i = 0; i < $(".card-section").length; i++) {
			temp.push(i * -$(".card-section").width());
		}
		positions = temp;
	}
	
	// 슬라이드 다음 버튼 클릭 이벤트
	$(".btn-next").click(function(){
		// 현재 index색깔은 다시 흰색으로 만들어주기
    	$("#trainers-index li").eq(currPos).css("background-color", "white");
		
		currPos++;
		// 슬라이드 최대범위 넘어갔을시 위치 0으로 지정
		if(currPos >= $(".card-section").length) {
			currPos = 0;
			// 슬라이드 애니메이션 처리
    		$("#trainers-sl").animate({left: positions[currPos]}, 500);
    		
    		//slideIndex 색깔변경 처리
    		$("#trainers-index li").eq(currPos).css("background-color", "#c5f016");
		}
		else {
    		$("#trainers-sl").animate({left: positions[currPos]}, 500);
    		
    		//slideIndex 색깔변경 처리
    		$("#trainers-index li").eq(currPos).css("background-color", "#c5f016");
		}
	});
	
	// 슬라이드 이전 버튼 클릭 이벤트
	$(".btn-prev").click(function(){
		// 현재 index색깔은 다시 흰색으로 만들어주기
    	$("#trainers-index li").eq(currPos).css("background-color", "white");
		
		currPos--;
		if(currPos < 0) {
			currPos = $(".card-section").length -1;
    		$("#trainers-sl").animate({left: positions[currPos]}, 500);
    		
    		//slideIndex 색깔변경 처리
    		$("#trainers-index li").eq(currPos).css("background-color", "#c5f016");
		}
		else {
    		$("#trainers-sl").animate({left: positions[currPos]}, 500);
    		
    		//slideIndex 색깔변경 처리
    		$("#trainers-index li").eq(currPos).css("background-color", "#c5f016");
		}
	});
	
	// trainers-index
	function slideIndex(slideLength) {
		var str = "";
		for(var i = 0; i < slideLength; i++) {
			str += "<li></li>";
		}
		$("#trainers-index").append(str);
	}
	
	// trainer card DOM
	function trainerCard(trainer, careers) {
	   var str = "";
	   str += '<div class="space-medium section-color card-section">';
	   str += '<div class="container">';
	   str += '<div class="trainers-card">';
	   str += '<div class="trainers-photo">';
	   str += '<img src="'+contextPath+'/resources/images/'+ trainer.userName +'.jpg">';
	   str += '</div>';
	   str += '<div class="trainers-explain-odd">';
	   str += '<h2 class="trainers-name text-white">'+ trainer.userName +' 트레이너</h2>';
	   str += '<h4 class="text-white awards-career"> Awards & Career</h4>';
	   str += '<ul class="trainers-career">';
	   for(var i in careers) {
		   if(!careers[i].careerName) continue;
		   if(careers[i].startDate && careers[i].endDate){
			   str += '<li>' + careers[i].careerName + '</li>' + '<p class="career-p">' + careers[i].startDate + ' ~ ' + careers[i].endDate + '</p>';
		   }
		   else {
			   str += '<li style="margin-bottom: 10px">' + careers[i].careerName + '</li>';
		   }
	   }
	   str += '</ul>';
	   str += '<div class="trainers-comments">';
	   str += '<h5 class="text-white">Comments</h5>';
	   
	   // 최근 작성된 코멘트를 출력하고 작성된 코멘트가 없다면 '친절하게 확실하게!' 출력.
	   var comment = "";
	   for(var i in careers) {
		   if(careers[i].comments)	{
			   comment = careers[i].comments;
		   }
	   }
	   if(comment){
		   str += '<p>' + comment +'</p>';
	   }
	   else {
		   str += '<p>친절하게 확실하게!</p>';
	   }
	   
	   str += '</div>';
	   str += '</div>';
	   str += '<div class="trainers-choice">';
	   str += '<form method="post" action="'+contextPath+'/PTreserve/calendar">';
	   str += '<input type="hidden" name="trainerName" value="'+ trainer.userName +'"/>';
	   str += '<input type="hidden" name="trainerId" value="'+ trainer.userid +'"/>';
	   str += '<button type="submit" class="btn btn-default btn-reserve">PT 예약하기</button>';
	   str += '<input type="hidden" name="'+csrfParameter+'" value="'+ csrfToken+'"/>';
	   str += '</form>';
	   str += '</div>';
	   str += '</div><!--  END of trainers-card -->';
	   str += '</div>';
	   str += '</div> <!-- END of card-section  -->';
	   $("#trainers-sl").append(str);
	} // END of trainerCard
	
	$("body").on("click", ".btn-reserve", function() {
//		console.log($(this).data("trainer"));
		// 해당 트레이너의 예약 페이지로 이동
		//location.href = contextPath + "/PTreserve/calendar?trainerName=" + $(this).data("trainer");
//		location.href = "/PTreserve/calendar?trainerName=" + $(this).data("trainer");
		console.log("${_csrf.parameterName}");
	});
}); // END of Ready