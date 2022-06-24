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
	<link href="${pageContext.request.contextPath}/resources/css/reserveModal.css" rel="stylesheet">
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
        body .fc .fc-daygrid-day.fc-day-today , body .fc .fc-daygrid-day.fc-day-future {
        	/* border-color: rgb(221, 221, 221); */
        }
        
        /* 과거, 이번달이 아닌 날짜 배경색 지정 */
        body .fc .fc-daygrid-day.fc-day-past,
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
        #EX_possibleCell .rect { background: var(--possible-color); }
        #EX_impossibleCell .rect { background: var(--impossible-color); }
        
        #manual > ul {
         	padding: 0; 
         	margin: 50px 0 0;
         	color: red;
         	list-style: none;
         }
			
		.buttons button { margin: 30px;}  
		
		.tModal-tbody input {
			border : none;
		}
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
                dayMaxEvents: true // allow "more" link when too many events
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
                        <h1 class="page-title"><c:out value="${param.trainerName}"/> 트레이너 PT 예약</h1>
                        <p>원하시는 날짜를 선택후, 팝업창에서 시간을 선택해주세요</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1 class="text-center">PT-예약날짜 선택</h1>
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
            	<div id="EX_possibleCell">
            		<div class="rect"></div>
            		<div class="explain">: 예약가능</div>
            	</div>
            	<div id="EX_impossibleCell">
            		<div class="rect"></div>
            		<div class="explain">: 예약불가</div>
            	</div>
				<ul>
					<li>예약취소시 예약일 7일 이내의 취소건은 PT횟수가 차감됩니다. </li>
					<li>PT예약일 NoShow에 관한건은 환불처리 되지않고 PT횟수가 차감됩니다. </li>
				</ul>
            </div>
            <div class="buttons text-center">
	            <button type="button" class="btn btn-primary" onclick="history.back()">뒤로가기</button>
    	        <button class="btn btn-default btn-myCalendar">내 예약정보 확인</button>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp"/>
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>

    <jsp:include page="../includes/foot.jsp"/>
    
    <!-- modal  -->
    <jsp:include page="../PTreserve/timegrid.jsp"/>
    
    <!-- 풀캘린더 커스텀 & 예약 기능 구현 -->
    <script>
    	function reserveVo(){
    		this.trainerId = "${param.trainerId}";
    		this.memberId = "${pinfo.userid}";
    		this.reserveDate = "";
    		this.startTime = "";
    		this.endTime = "";
    	}
       	var reserve = new reserveVo(); 
    	
       	// ready
        $(function(){
        	var $body = $("body");
        	var $html = $("html");
        	var $modal = $("#tModal");
        	var $calendar = $("#calendar");

            //달력 날짜 선택시 색깔 변경 
            //$(".fc-highlight").css("background","#c5f016")
            //-> 라이브러리 기본 우선순위에 밀려나기때문에 이벤트위임처리를 하던가
            //   css속성을 줄때 기존css 선택자보다 부모 레벨 선택자부터 시작해서 속성을 부여해준다.
            /* =====================================================================================  */
            
            // 트레이너의 예약 일정에 따른 캘린더 날짜 배경색 변경 관련 스크립트 =======================================================
            /* 페이지 입장시 또는 캘린더의 month 변경시 : 
 			       1.트레이너 id와 month를 이용해 해당month에 예약된 데이터를 day별 리스트로 가져오기
 			       2.예약 가능한 시간대가 없으면 해당 day의 배경색을 변경 -> *다른 아이디어 :예약이 차있는 만큼 배경색에 그라디언트를 줘보자
 			       3.예약 불가능한 시간대의 조건
 			       	3-1. day별 리스트의 length가 max인 경우 (reserved = max)
 			       	3-2. day별 리스트의 length가 max는 아니지만 예약 가능한 시간대가  아닌경우 (reserved + timeover = max)
            		3-3. 예약 가능한 시간대가 모두 지난경우(timeover = max)
	        */
	        drawsDayGridStackByReservedDays();
            
	        function drawsDayGridStackByReservedDays() {
            	var url = contextPath + "/PTreserve/getTrainerReservedListByDay";
            	$.ajax(url, {
            		type : "POST",
            		data : JSON.stringify({
            				"trainerId": "${param.trainerId}",
            				"year_month": calendar.getDate().getFullYear()+"-"+leftPad(calendar.getDate().getMonth()+1),
            				"today": leftPad(calendar.getDate().getDate())
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
            			
            			// 예약 버튼들
            			var reserveInputs = $modal.find(".tModal-tbody input"); 
            			var validAllTimeLength = reserveInputs.length; // 예약가능 시간대 갯수
            			
            			// 현재 시간
            			var nowHour = new Date().getHours();
            			
            			// 날짜 별로 예약이 얼마나 차있는지 캘린더 daygrid의 배경색에 스택효과를 주는건 어떨까..?
            			for(var day in map){
            				// :not에 선택자를 여러개 쓸때는 의도하는 대로 구하기 위해서 선택자의 순서를 주의할것 
            				// 이번달에 예약가능한 캘린더 일자들
            				var dayGrids = $calendar.find(".fc-daygrid-day:not(.fc-day-other, .fc-day-past)");
            				
            				// 서버에서 가져온 예약이 존재하는 날짜와 캘린더의 날짜를 매치시켜 예약갯수에따라 배경색 스택 적용하기
            				for(var i in dayGrids) {
            					var matchGrid = dayGrids.eq(i);
            					
            					// 예약이 있는 날과 캘린더의 날짜를 매치
            					console.log(day);
            					if(Number(day) == matchGrid.find(".fc-daygrid-day-number").text()){
            						var percent = 0;
            						
            						// 오늘의 경우 예약 불가능한 모든 시간대 까지계산한다.
            						if(matchGrid.hasClass("fc-day-today")){
            							var invalidReservedTimeCnt = 0; // 시간이 지나 계산이 불필요한 예약 시간대 갯수
            							var pastTimeLength = nowHour - reserveInputs.eq(0).data("time"); // 지나간 모든 예약가능 시간대 갯수
            							
            							// 현재시간을 기준으로 이미 지난 시간들의 갯수 구하기
            							for(var j in map[day]){
            								var reserveTime = map[day][j];
            								if(reserveTime <= nowHour){
            									invalidReservedTimeCnt += 1;
            								}
            							}
            							/* console.log("예약 가능한 시간대 총 갯수 : ", map[day]);
            							console.log("시간이 지나 계산이 불필요한 예약 시간대 갯수 : ", invalidReservedTimeCnt);
            							console.log("현재 시간 기준 지나간 예약 시간대 갯수 : ", pastTimeLength); */
            							
            							// 예약된 시간대들을 기준으로 이미 지난 시간들은 빼주고, 총 예약가능 시간대 갯수에서 이미 지난 시간은 더해준다. 
            							percent = 
            								(map[day].length - invalidReservedTimeCnt + pastTimeLength) / validAllTimeLength;
            							percent = percent * 100;
            						}
            						else {
            							percent = (map[day].length / validAllTimeLength) * 100;            							
            						}
            						
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
            			console.log("fail!!! getTrainerReservedListByDay");
            		}
            	});
            } // End of drawsDayGridStackByReservedDays()==========================================================
            
            // 풀 캘린더의 .fc-toolbar-title 에 변화가 감지되면 다시 drawsDayGridStackByReservedDays() 실행
            // *change, on change 이벤트 모두 작동 안함
            var fcMonth = calendar.getDate().getMonth();
            $calendar.click(function(){
            	changedFcMonth = calendar.getDate().getMonth();
            	// 캘린더 월 변경시 
            	if(fcMonth != changedFcMonth){
            		$(".fc-daygrid-day:not(.fc-day-other, .fc-day-past)")
            			.css({
            				"background" : "none"
            		});
            		
	            	drawsDayGridStackByReservedDays();
	            	
	            	$(".fc-day-other").css({
						"background" : "none",
	            		"background-color" : "RGB(230, 230, 230)"
	            	});
	            	
	            	fcMonth = calendar.getDate().getMonth();
            	}
            });
            	
            	
            // 모달 open 관련 스크립트 ===================================================================================
            // 마우스 클릭의 이벤트 순서   mousedown -> mouseup -> click
            
           	// 모달 on/off 애니메이션 시간
            var animTime = 300;
           	var modalWidth = 0;
           	
           	// 시간선택시 모달창에 표시
           	$modal.find(".tModal-tbody").on("click", "input", function(e){
           		reserve.startTime = $(this).val();
           		$modal.find(".tModal-h4").text("선택 시간 : " + reserve.startTime);
           	});
           	
            // cell이외의 요소에 mousedown시 cell의 모든 추가요소 제거
            // click으로 처리할시 event.target에 body가 잡힐때가 있어서 mousedown으로 변경
            $html.on("mousedown", "body", function(e) {
            	var name = event.target.className;
            	//우클릭인 경우 실행안함
            	if(isRightButton(e)) return;
            	//모달에서는 실행 x
        		if(name.indexOf("tModal") == 0) return;
            	
            	// 캘린더 샐영역이 아닌경우(샐영역내 모든 요소의 className에는 fc-daygrid-day 가 포함돼있음 )
            	// !name 클래스 이름 없는경우
            	if(!name || (name.indexOf("fc-daygrid-day") == -1)){
            		$("div.fc-daygrid-day-frame").css("box-shadow", "none");
            		$("td.fc-daygrid-day").removeClass("select-cell");
            	}
            })
        	
        	// Cell 클릭시 테두리 생성 및 select-cell 클래스 추가
       		$calendar.on("click", "td.fc-daygrid-day", function() {
       			var $this = $(this);
       			
				$("div.fc-daygrid-day-frame").css("box-shadow", "none");
				$this.children("div").css("box-shadow", "0 0 0 2px var(--select-color) inset");
				
				$("td.fc-daygrid-day").removeClass("select-cell");
				$this.addClass("select-cell");			
   	    	});
            
        	// 선택된 캘린더 셀의 mousedown이벤트시 모달 켜짐
        	$calendar.on("mousedown", "td.fc-daygrid-day", function(e) {
				// 우클린인 경우 실행안함	        		
        		if(isRightButton(e)) return;
				
				var dayGrid = $(this);

				// 과거의 경우 모달 안켜지게
				if(dayGrid.hasClass("fc-day-past")){
					alert("지난 날은 예약 불가능합니다.");
					return;
				}

        		// 선택한 셀인경우 모달 켜짐
				if(dayGrid.hasClass("select-cell")) {
					var nowHour = new Date().getHours(); 
					var nowMin = new Date().getMinutes();
					var timeInputs = $modal.find(".tModal-tbody").find("input"); // 예약시간 버튼
						
					//선택한 날짜 모달 타이틀에 출력 & reserveVo date set
					reserve.reserveDate = dayGrid.data("date");
					$modal
						.find(".tModal-title>h2")
							.html("${param.trainerName} 트레이너 예약<br>" + reserve.reserveDate).end()
						// 모달 오픈시 css visibility, opacity 속성을 사용해 fadeIn 연출
						.addClass("open-modal")
						// 현재 시간,분 출력
						.find(".tModal-thead>tr>td").text("현재 "+nowHour+"시 "+nowMin+"분 입니다.");
					
	   	    		// 모달 켜졌을때 background body스크롤 막기 & 스크롤 넓이만큼 padding-right
					var onScrollBodyWidth = $body.width() ;
					$body
						.addClass("hide-scroll")
						.css("padding-right", window.innerWidth - onScrollBodyWidth);
					
					// 당일 예약 불가능한 시간대 버튼 비활성화 
					if(dayGrid.hasClass("fc-day-today")) {
						for(var i = 0; i < timeInputs.length; i++) {
							var ti = timeInputs.eq(i);
							if(nowHour >= ti.attr("data-time")) {
								disabledInput(ti, "timeover");
							}
						}
					}
					
					// 이미 예약되어있는 시간대는 예약 불가능
					//(서버에 해당날짜,트레이너id를 이용해 데이터들을 조회 하고 해당하는 시간대들과 예약시간 버튼과 매치시켜서 비활성화)
					var url = contextPath + "/PTreserve/getTrainerReservedTime";
					$.ajax(url,{
						type: "POST",
						data: JSON.stringify(reserve),
						contentType: "application/json; charset=utf-8",
						dataType: "JSON",
						success: function(reservedList) {
							for(var i in reservedList) {
								var ti = timeInputs.end().find('input[data-time='+reservedList[i]+']');
								if(ti.hasClass("btn-default")){
									disabledInput(ti, "reserved");									
								}
							}
						},
						error : function(){
							alert("fail!!! get Trainer Reserved Time ");
						}
					});
				}
   	    	});
        	
        	// 모달 예약버튼 비활성화
        	function disabledInput(input, reason) {
        		input
	        		.removeClass("btn-default")
					.addClass("btn-secondary btn-disabled")
					.prop("disabled", true);
        		
        		if(reason === "timeover"){
					input.attr("title", "지난 시간은 예약불가 입니다.");        			
        		}
        		else if(reason === "reserved"){
        			input.attr("title", "이미 예약 되어 있습니다.")
        		}
        		
        	}
        	
        	// 모달 close시 처리 함수 =============================================================================
        	function closeModal(isReserve) {
        		
       			// 예약 취소로 모달을 종료하는 경우 
        		if(!isReserve){
        			// 임시 저장된 예약 날짜,시간 데이터 비우기
           			reserve.reserveDate = "";
            		reserve.startTime = "";
        		}
        		
       			// 모달 종료시 visibility, opacity 속성을 사용해 fadeOut 연출
   	    		$modal.removeClass("open-modal");
   	    		
       			//모달 fadeOut 끝난뒤 모달 초기화 및 백그라운드 스크롤 복귀
        		setTimeout(function() {
        			// 모달 초기화
        			$modal
        				.find(".tModal-h4").text("예약시간을 선택해 주세요.").end()
        				.find(".tModal-tbody")
        					.find("input")
        						.removeClass("btn-secondary btn-disabled")
        						.addClass("btn-default")
        						.prop("disabled", false)
        						.attr("title", "예약가능");
        			
        			// 백그라운드 스크롤 복귀
        			$body
        				.removeClass("hide-scroll")
        				.css("padding-right", "0");
        			
        			// transition-duration 값을 milliseconds로 변경하여 setTime과  시간 동기화
        		}, css_seconds_to_milliSeconds($modal.css("transition-duration")));
        	}
        	
        	// 모달 선택 버튼 클릭시 예약데이터 전송
        	$modal.find(".modal-select").mousedown(function(){
        		if(!reserve.reserveDate) {
            		alert("예약 날짜를 선택해주세요!");
            	}
            	else if(!reserve.startTime) {
            		alert("예약 시간을 선택해주세요!");
            	}
            	else if(!reserve.trainerId) {
        			alert("트레이너 정보가 없습니다. 트레이너를 다시 선택해주세요.");
        			location.href = contextPath + "/PTreserve/trainers";
        		}
            	else if(!confirm(
            			"예약정보를 확인 해주세요.\n"+
            			"담당 트레이너 : " + "${param.trainerName}\n"+
            			"예약 날짜 : " + reserve.reserveDate + "\n"+
            			"예약 시간 : " + reserve.startTime + "\n"
            			)){
            		alert("예약을 취소했습니다.");
            	}
            	else {
            		// 예약 데이터 전송
            		var url = contextPath + "/PTreserve/reservePT";
                	$.ajax(url, {
                		type : "POST",
                		data : JSON.stringify(reserve),
                		contentType : 'application/json; charset=utf-8',
                		dataType : "text",
                		success : function(result) {
                			alert(result);
                			drawsDayGridStackByReservedDays(); // 예약 성공후 캘린더에 예약 현황 스택 그리기
                		},
                		error : function() {
                			alert("failed reservePT ajax communication");
                		}
                	});
            	}        		
        		closeModal(false);
        	});
   	    	
        	// 모달 close 구현
   	    	$modal
   	    		// 취소 버튼 마우스다운시 모달 꺼짐
   	    		.find(".modal-close").mousedown(function() {
   	    			closeModal(false);
   	    		})
   	    		.end()
        		// 외부 마우스다운 이벤트시 꺼짐
   	    		.mousedown(function(e) {
   	        		//모달에서는 실행 x
   	        		if(e.target.className.indexOf("overlay") >= 0)
   						closeModal(false);
   	        		else
   	        			return;
   	        	});
   	    	// END of MODAL script ==============================================================================
            
            // 내 예약 페이지로 이동
            $(".btn-myCalendar").click(function(){
            	
            });
            
        });// END of Ready
    </script>
</body>
</html>
