<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authorize access="isAuthenticated()">
	<sec:authentication property='principal.member' var="pinfo"/>
</sec:authorize>

<!DOCTYPE html>
<html lang="ko">
<head>
	<sec:csrfMetaTags/>
	<jsp:include page="../includes/head.jsp"/>
	<link href="${pageContext.request.contextPath}/resources/css/reserveManageModal.css" rel="stylesheet">
    <!-- 외부 라이브러리 커스텀할때 important로 변경해도 괜찮은지? 
         =>안됨 한단계 위 레벨 선택자를 사용 --> 
    <style>
    	:root {
    		--select-color: #5bff00;
    		--today-color: #ffcf00;
    		--possible-color: blue;
    		--impossible-color: gray;
    	}
        
        /* 사용자가 선택한 날짜 테두리 색상지정  */
        body .fc .fc-highlight{
            background-color: transparent;
            border: 2px solid var(--select-color);
        }
        
        /* 오늘날짜 테두리 색상지정  */
        body .fc .fc-daygrid-day.fc-day-today {
        	background-color: transparent; 
        }
        body .fc .fc-daygrid-day.fc-day-today > div{
        	border:2px solid var(--today-color); 
        }
        
        body .fc .fc-daygrid-day.fc-day-today , 
        body .fc .fc-daygrid-day.fc-day-future {
        	/* border-color: rgb(221, 221, 221); */
        }
        
        /* 이번달이 아닌 날짜 배경색 지정 */
        body .fc .fc-daygrid-day.fc-day-other {
        	background-color: RGB(230, 230, 230);
        	border-color: rgb(221, 221, 221);
        }
        
        .page-header {
        	background: url("${pageContext.request.contextPath }/resources/images/pt_headerBack.png") no-repeat center;
        	background-size: cover;
        	margin:0;
        	min-height: 450px;
        }
        
        body .page-caption {
        	margin-top: 150px;
        	margin-bottom: 0;
        	background-color: #262626;
        }
        
        body .page-title {
        	color: #fff;
    		font-size: 33px;
    		margin: 20px 0px;
        }
        
        .scroll-off {
        	overflow: hidden;
        	height: 100%;
        }
        
        .scroll-on{
        	
        }
        
        body h1 { 
       		margin-top: 50px;
        	margin-bottom: 50px; 
       	}
       	
       	.calendar-section {
       		padding: 20px 0;
       		margin: 50px 0;
       	}
        
        .calendar-container { 
        	background: white;
        	border-radius: 5px;	
        	padding: 30px;
        }
        
        #manual {
        	margin: 50px 0;
        	min-height: 200px;
        }
        
        #manual > div {
        	margin: 10px 0;
        }
        
        .rect {
        	display:table-cell;
        	width: 50px;
        	height: 30px;
        }
        
        .explain {
        	display: table-cell;
        	vertical-align: middle;
        	padding-left: 10px;
        }
        
        #Ex_selectCell .rect { border: 2px solid var(--select-color); }
        #EX_todayCell .rect { border: 2px solid var(--today-color); }
        #Ex_reservedCell .rect { background: #b9e118;}
        
        #manual > ul {
         	padding: 0; 
         	margin: 50px 0 0;
         	color: red;
         	list-style: none;
         }
			
		.buttons button { margin: 30px;}  
    </style>

    <!-- FullCalendar cdn -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script>
    <script>
	 	// contextPath
		var contextPath = "${pageContext.request.contextPath}";	
	 	// csrf 토큰을 미리 설정
		var csrfHeader = $("meta[name='_csrf_header']").attr("content")
		var csrfToken = $("meta[name='_csrf']").attr("content");
		if(csrfHeader && csrfToken){
			$(document).ajaxSend(function(e, xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			});
		}
		
		var calendar = "";
    
    	// 캘린더 초기설정
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            calendar = new FullCalendar.Calendar(calendarEl, {
                // stickyHeaderDates: false,
                height: 'auto',
                // initialDate: '2020-09-12',
                initialDate: new Date(),
                editable: true,
                selectable: false,
                businessHours: false,
                dayMaxEvents: true, // allow "more" link when too many events
            	titleFormat: {
            	    year: 'numeric',
            		month: '2-digit'
            	}
            });
            calendar.render();
            
         	// 페이지 헤더바의 높이를 구해서 풀캘린더 sticky header에 적응시키는 과정
        	var headerHeight = $(".header").css("height");
            $(".fc-scrollgrid thead td").css("top", headerHeight);
        	
            //브라우저 크기가 바뀌어도 fc-header의 sticky 포지션 변경이 일어나게 할려면?
            $(window).resize(function(){
                headerHeight = $(".header").css("height");
                $(".fc-scrollgrid thead td").css("top", headerHeight);
            });
        	
        	
        	// 풀캘린더 헤더의 요일명을 영어 -> 한글로 교체, 색상번경
       		$(".fc-col-header")
       			.find(".fc-day-sun div a").text("일").end()
       			.find(".fc-day-mon div a").text("월").end()
       			.find(".fc-day-tue div a").text("화").end()
       			.find(".fc-day-wed div a").text("수").end()
       			.find(".fc-day-thu div a").text("목").end()
       			.find(".fc-day-fri div a").text("금").end()
       			.find(".fc-day-sat div a").text("토").end()
       			.find(".fc-col-header-cell").css("background-color","#454545").end()
       			.find("a").css("color","whitesmoke");
        });
    </script>
</head>
<body>
    <div class="page-header">
        <jsp:include page="../includes/header.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">트레이너 PT 예약 현황</h1>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1 class="text-center">PT 예약을 조회,취소 할 수 있습니다.</h1>
    <div class="space-medium section-color calendar-section">
        <div class="container calendar-container">
            <div id="calendar"></div>
            <div id="manual">
            	<p>MANUAL</p>
            	<div id="Ex_selectCell">
            		<div class="rect"></div>
            		<div class="explain">: 선택한 날짜</div>
            	</div>
            	<div id="EX_todayCell">
            		<div class="rect"></div>
            		<div class="explain">: 오늘</div>
            	</div>
            	<div id="Ex_reservedCell">
            		<div class="rect"></div>
            		<div class="explain">: 예약 있는날</div>
            	</div>
            </div>
            <div class="buttons text-center">
	            <button type="button" class="btn btn-primary" onclick="history.back()">뒤로가기</button>
    	        <button class="btn btn-default" onclick="location.href='${pageContext.request.contextPath}/common/index'">홈으로 이동</button>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp"/>
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>

    <jsp:include page="../includes/foot.jsp"/>
    
    <!-- modal  -->
    <jsp:include page="../PTreserve/reserveManageModal.jsp"/>
    
    <!-- 풀캘린더 커스텀 & 예약 조회,취소 구현 -->
    <script>
    	
       	// ready
        $(function(){
        	var $body = $("body");
        	var $html = $("html");
        	var $modal = $("#tModal");
        	var $calendar = $("#calendar");
        	var validTimeLength = 12;

        	drawsDayGridStackByReservedDays();
        	
			function drawsDayGridStackByReservedDays() {
            	var url = contextPath + "/PTreserve/getTrainerReservedListByDay";
            	$.ajax(url, {
            		type : "POST",
            		data : JSON.stringify({
            				"trainerId": "${pinfo.userid}",
            				"year_month": calendar.getDate().getFullYear()+"-"+leftPad(calendar.getDate().getMonth()+1)
            			   }),
            		contentType : "application/json; charset=utf-8",
            		dataType : "json",
            		success : function(reservedLinkedHashMap) {
            			console.log("seccess!!! getTrainerReservedListByDay");
            			console.log("${param.trainerName} 트레이너 이번달 일별 예약 시간대 리스트 :", reservedLinkedHashMap);
            			// 해당 트레이너의 일별 예약 시간대 리스트 맵 key: 일자, value: 예약 시간대 리스트
            			var map = reservedLinkedHashMap; 
            			if(!map) {
            				console.log("map null");
            				return;
            			}
            			
            			// 현재 시간
            			var nowHour = new Date().getHours();
            			
        				// 이번달 캘린더 cell 가져오고 백그라운드 초기화
            			// :not에 선택자를 여러개 쓸때는 의도하는 대로 구하기 위해서 선택자의 순서를 주의할것 
        				var dayGrids = $calendar.find(".fc-daygrid-day:not(.fc-day-other)");
            			dayGrids.css({"background" : "none"});
            			
            			for(var day in map){
            				
            				// 서버에서 가져온 예약이 존재하는 날짜와 캘린더의 날짜를 매치시켜 예약갯수에따라 배경색 스택 적용하기
            				for(var i in dayGrids) {
            					var matchGrid = dayGrids.eq(i);
            					
            					// 예약이 있는 날과 캘린더의 날짜를 매치
            					if(Number(day) == matchGrid.find(".fc-daygrid-day-number").text()){
           							var	percent = (map[day].length / validTimeLength) * 100;            							
            						
            						// 배경의 그라디언트를 이용해 스택효과를 내보았음
            						matchGrid
            							.css({
	            							"background" : "linear-gradient(to top, #b9e118 "+percent+"%, white "+percent+"%)"
            							});
            					}
            				}
            			}
            		},
            		error : function(){
            			alert("fail!!! drawsDayGridStackByReservedDays()");
            		}
            	});
            } // End of drawsDayGridStackByReservedDays()==========================================================
            
            // 풀 캘린더의 .fc-toolbar-title 에 변화가 감지되면 다시 drawsDayGridStackByReservedDays() 실행
            // *change, on change 이벤트 모두 작동 안함, 직접 calendar의 month데이터 변화를 감지하는 코드로 변경
            var fcMonth = calendar.getDate().getMonth();
            $calendar.click(function(){
            	changedFcMonth = calendar.getDate().getMonth();
            	// 캘린더 월 변경시 
            	if(fcMonth != changedFcMonth){
            		$(".fc-daygrid-day:not(.fc-day-other)")
            			.css({
            				"background" : "none"
            		});
            		
            		drawsDayGridStackByReservedDays();
	            	
	            	$(".fc-day-other").css({
						"background" : "none",
	            		"background-color" : "RGB(230, 230, 230)"
	            	});
	            	
            	}
	            fcMonth = calendar.getDate().getMonth();
            });
            
         	// Cell 클릭시 테두리 생성 및 select-cell 클래스 추가 =========================================
        	// 화면에서 보여지고있는 다음달,이전달 Cell 클릭시 해당하는 달로 페이지 이동
       		$calendar.on("click", "td.fc-daygrid-day", function() {
       			var dayGrid = $(this);
       			
       			if(dayGrid.hasClass("fc-day-other")){
	       			// 이번달 페이지에서 다음,이전 달 날짜를 클릭했을땐 다음,이전 페이지로 이동
					var viewMonth = calendar.getDate().getMonth() + 1;
					var [year, month, day] = dayGrid.data("date").split("-");
					var selectMonth = Number(month);
					
					// 보여지고 있는 달보다 선택한 그리드의 달이 높은경우 (다음달로 이동)
					if(viewMonth < selectMonth){
	       				$(".fc-next-button").click();
					}
					// 보여지고 있는 달보다 선택한 그리드의 달이 낮은경우 (이전달로 이동)
					else if(viewMonth > selectMonth){
						$(".fc-prev-button").click();
					}
       			}
       			
				$("div.fc-daygrid-day-frame").css("box-shadow", "none");
				dayGrid.children("div").css("box-shadow", "0 0 0 2px var(--select-color) inset");
				
				$("td.fc-daygrid-day").removeClass("select-cell");
				dayGrid.addClass("select-cell");			
   	    	});
            	
            	
            // 모달  관련 스크립트 ===================================================================================
           	
            // 선택한 cell을 한번더 클릭시 모달 open =====================================================
            $calendar.on("mousedown", "td.fc-daygrid-day", function(e) {
				// 우클린인 경우 실행안함	        		
        		if(isRightButton(e)) return;
				
				var dayGrid = $(this);
				
				if(dayGrid.hasClass("select-cell")){
					openModal(dayGrid);
				}
           	});
            
            // 모달 open 처리 함수
            function openModal(dayGrid) {
				var [year, month, day] = dayGrid.attr("data-date").split("-");
				// 모달 open및 선택한 날짜 정보로 modal업데이트
				$modal
					.addClass("open-modal")
					.find(".tModal-title>h2").text(year+"년 "+month+"월 "+day+"일").end()
					.find(".tModal-thead>tr>td").text("${pinfo.userName}"+"님의 예약 정보입니다.").end()
					.attr("data-date", dayGrid.attr("data-date"));
				
        		// 모달 켜졌을때 background body스크롤 막기 & 스크롤 넓이만큼 padding-right
				var onScrollBodyWidth = $body.width() ;
				$body
					.addClass("hide-scroll")
					.css("padding-right", window.innerWidth - onScrollBodyWidth);
				
				// 선택한 날짜의 예약 데이터를 불러와 '상세 예약 정보 보기' 버튼 활성화
				var url = contextPath + "/PTreserve/getTrainerReservedTimeBy";
				$.ajax(url,{
					type : "POST",
					data : JSON.stringify({
						"trainerId" : "${pinfo.userid}",
						"reserveDate" : dayGrid.attr("data-date")
					}),
					contentType : "application/json; charset=utf-8",
					dataType : "json",
					success : function(userReservedTimeList){
						var list = userReservedTimeList;
						
						var appendStr = "";
						for(var i in list){
							appendStr += "<tr class='tbody-tRow'><td>";
							appendStr += "<input type='button' value='"+leftPad(list[i])+":00' class='tModal-input btn-default' data-time='"+list[i]+"'>";
							appendStr += "<div class='reserveDetail hide'></div>";
							appendStr += "</td></tr>";
						}
						$modal.find(".tModal-tbody").append(appendStr);
					},
					error : function (){
						alert("예약 시간 데이터를 가져오는데 실패했습니다.");
					}
				});
            }
            
            // 모달 내 예약 시간 버튼 클릭이벤트 ==========================================================
            $modal.on("click", ".tModal-input", function(){
            	var input = $(this);
            	var reserveDetail = input.next();
            	
            	// 같은 버튼 한번더 누르면 상세정보 가리기
            	if(reserveDetail.hasClass("hide")==false){
            		reserveDetail.addClass("hide");
            		$modal.find(".tfoot-title").text("선택한 예약을 취소할 수 있습니다.");
           			return;
            	}
            	// 이미 데이터가 존재하면 기존 데이터를사용
            	else if(reserveDetail.html() != ""){
    				$modal.find(".reserveDetail").addClass("hide");
    				reserveDetail.removeClass("hide");
    				$modal
    					.find(".tfoot-title")
	            			.text(input.attr("data-time")+" 시 예약을 선택했습니다.").end()
	            		.find(".tbody-tRow input").removeClass("select-input");
	    			input.addClass("select-input");
    				return;
    			}
            	
            	//data()로 값 가져올시 버그발생
            	//console.log($modal.data("date"), leftPad(input.data("time")));
            	//console.log($modal.attr("data-date"), leftPad(input.attr("data-time")));
            	
            	// 예약시간 버튼 클릭시 서버와 통신하여 상세 정보 open
            	var url = contextPath + "/PTreserve/getTrainerReserveDetailBy";
            	$.ajax(url,{
            		type : "POST",
            		data : JSON.stringify({
            			"trainerId" : "${pinfo.userid}",
            			"reserveDate" : $modal.attr("data-date"),
            			"reserveTime" : leftPad(input.attr("data-time"))
            		}),
            		contentType : "application/json; charset=utf-8",
            		dataType : "json",
            		success : function(detailData){
            			console.log(detailData);
            			
            			var [year, month, day] = detailData.reserveDate.split("-");
            			$modal.find(".reserveDetail").addClass("hide");
            			
            			var endTimeStr = "";
            			if(detailData.endTime) 
            				endTimeStr = "<br>종료 시간 : "+detailData.endTime+"시";
            			
            			reserveDetail
            				.html(
            						"예약번호 : "+leftPad(detailData.rno)+"<br>"+
            						"파트너 : "+detailData.memberId+"<br>"+
            						"예약 날짜 : "+year+"년 "+month+"월 "+day+"일"+"<br>"+
            						"시작 시간 : "+detailData.startTime+"시"+
            						endTimeStr
            				)
            				.removeClass("hide")
            				.attr("data-detail", JSON.stringify(detailData));
            			
            			// 모달 하단에 몇시 예약건을 선택했는지 display, 선택한 input만 select-input 클래스 부여
                    	$modal
                    		.find(".tfoot-title")
                    			.text(input.attr("data-time")+" 시 예약을 선택했습니다.").end()
                    		.find(".tbody-tRow input").removeClass("select-input");
            			input.addClass("select-input");
            		
            		},
            		error : function(){
            			alert("※상세 데이터를 가져오는데 실패 했습니다!※");
            		}
            	});
            	
            }); // End of 예약시간 클릭 이벤트 =======================================================
            
            	
            // 예약 취소 버튼 클릭 이벤트 ===============================================================
            $modal.find(".modal-reserve-cancle").click(function(){
            	var currDetail = $modal.find(".tbody-tRow .select-input").next().attr("data-detail");
				
            	if(!currDetail){
					alert("예약 취소를 위해서 시간을 선택해주세요.");
					return;
            	}
            	else {
	            	currDetail = JSON.parse(currDetail);
            	}
				
				var url = contextPath + "/PTreserve/reserveCancle";
				$.ajax(url, {
					type : "POST",
					data : JSON.stringify(currDetail),
					contentType : "application/json; charset=utf-8",
					dataType : "text",
					success : function(msg){
						alert(msg);
						// 예약  취소했던 버튼 삭제
						$modal.find(".select-input").closest(".tbody-tRow").remove();
						
						// 하단 메세지 변경
						$modal.find(".tfoot-title").text("선택한 예약을 취소할 수 있습니다.");
						
					},
					error : function(){
						alert("예약취소에 문제가 발생했습니다.\n잠시후 다시 시도해주세요.");
					}
				});
				
            });
            
        	// 모달 close 이벤트
   	    	$modal
   	    		// 취소 버튼 마우스다운시 모달 꺼짐
   	    		.find(".modal-close").mousedown(function() {
   	    			closeModal();
   	    		})
   	    		.end()
        		// 외부 마우스다운 이벤트시 꺼짐
   	    		.mousedown(function(e) {
   	        		//모달에서는 실행 x
   	        		if(e.target.className.indexOf("overlay") >= 0)
   						closeModal();
   	        		else
   	        			return;
   	        	});
        	
   	  		// 모달 close시 처리 함수 =============================================================================
        	function closeModal() {
       			// 모달 종료시 visibility, opacity 속성을 사용해 fadeOut 연출
   	    		$modal.removeClass("open-modal");
       			
       			//모달 fadeOut 끝난뒤 모달 초기화 및 백그라운드 스크롤 복귀
        		setTimeout(function() {
        			// 백그라운드 스크롤 복귀
        			$body
        				.removeClass("hide-scroll")
        				.css("padding-right", "0");
        			
        			// 모달의 임시 생성된 요소 제거 및 초기화
        			$modal
        				.find(".tbody-tRow").remove().end()
        				.find(".tfoot-title").text("선택한 예약을 취소할 수 있습니다.");
        			
        			// 캘린더의 예약 현황 업데이트
    				drawsDayGridStackByReservedDays();
        			
        			// transition-duration 값을 milliseconds로 변경하여 setTime과  시간 동기화
        		}, css_seconds_to_milliSeconds($modal.css("transition-duration")));
        	}
   	    	// END of MODAL script ==============================================================================
            
        });/* End of Ready  */
    </script>
</body>
</html>