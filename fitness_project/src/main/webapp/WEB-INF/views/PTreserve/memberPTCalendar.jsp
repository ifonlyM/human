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
                        <h1 class="page-title">PT 예약 현황</h1>
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
    <jsp:include page="../PTreserve/reserveManageModal.jsp"/>
    
    <!-- 풀캘린더 커스텀 & 예약 조회,취소 구현 -->
    <script>
    	
       	// ready
        $(function(){
        	var $body = $("body");
        	var $html = $("html");
        	var $modal = $("#tModal");
        	var $calendar = $("#calendar");

            //달력 날짜 선택시 색깔 변경  ========================================================================
            //$(".fc-highlight").css("background","#c5f016")
            //-> 라이브러리 기본 우선순위에 밀려나기때문에 이벤트위임처리를 하던가
            //   css속성을 줄때 기존css 선택자보다 부모 레벨 선택자부터 시작해서 속성을 부여해준다.
            /* ======================================================================================= */
            
            // 트레이너의 예약 일정에 따른 캘린더 날짜 배경색 변경 관련 스크립트 ================================================
            /* 페이지 입장시 또는 캘린더의 month 변경시 : 
 			       1.트레이너 id와 month를 이용해 해당month에 예약된 데이터를 day별 리스트로 가져오기
 			       2.예약 가능한 시간대가 없으면 해당 day의 배경색을 변경 -> *다른 아이디어 :예약이 차있는 만큼 배경색에 그라디언트를 줘보자
 			       3.예약 불가능한 시간대의 조건
 			       	3-1. day별 리스트의 length가 max인 경우 (reserved = max)
 			       	3-2. day별 리스트의 length가 max는 아니지만 예약 가능한 시간대가  아닌경우 (reserved + timeover = max)
            		3-3. 예약 가능한 시간대가 모두 지난경우(timeover = max)
	        ========================================================================================== */
	        drawsDayGridByReservedDays();
            
	        function drawsDayGridByReservedDays() {
	        	
            	var url = contextPath + "/PTreserve/getUserReservedListByDay";
            	$.ajax(url, {
            		type : "POST",
            		data : JSON.stringify({
            				"userId": "${pinfo.userid}",
            				"year_month": calendar.getDate().getFullYear()+"-"+leftPad(calendar.getDate().getMonth()+1)
            			   }),
            		contentType : "application/json; charset=utf-8",
            		dataType : "json",
            		success : function(reservedLinkedHashMap) {
            			
            			console.log("seccess!!! getTrainerReservedListByDay");
            			console.log("${pinfo.userid} 회원의 이번달 일별 예약 시간대 리스트 :", reservedLinkedHashMap);
            			
            			// 해당 유저의 일별 예약 시간대 리스트 맵 key: 일자, value: 예약 시간대 리스트
            			var map = reservedLinkedHashMap; 
            			
            			// :not에 선택자를 여러개 쓸때는 의도하는 대로 구하기 위해서 선택자의 순서를 주의할것 
            			// 이번달만 선택
        				var dayGrids = $calendar.find(".fc-daygrid-day:not(.fc-day-other)");
            			
            			// 날짜 별로 예약이 있는날은 배경 색상을 그린다.
            			for(var day in map){
            				
            				// 서버에서 가져온 예약이 존재하는 날짜와 캘린더의 날짜를 매치시켜 예약이 있는 날은 
            				for(var i in dayGrids) {
            					
            					var matchGrid = dayGrids.eq(i);
            					
            					// 예약이 있는 날과 캘린더의 날짜를 매치
            					if(Number(day) == matchGrid.find(".fc-daygrid-day-number").text()){
            						
            						// 예약되어 있는 날은 배경색을 변경
            						matchGrid.css({"background" : "#b9e118"});
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
            		
            		drawsDayGridByReservedDays();
	            	
	            	$(".fc-day-other").css({
						"background" : "none",
	            		"background-color" : "RGB(230, 230, 230)"
	            	});
	            	
            	}
	            fcMonth = calendar.getDate().getMonth();
            });
            
         	// Cell 클릭시 테두리 생성 및 select-cell 클래스 추가
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
            // 마우스 클릭의 이벤트 순서   mousedown -> mouseup -> click
            
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
				var url = contextPath + "/PTreserve/getUserReservedTimeBy";
				$.ajax(url,{
					type : "POST",
					data : JSON.stringify({
						"userId" : "${pinfo.userid}",
						"reserveDate" : dayGrid.data("date")
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
						
					}
				});
            }
            
            // 모달 내 예약 시간 버튼 클릭시 상세정보 노출
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
    				$modal.find(".tfoot-title").text(input.attr("data-time")+" 시 예약을 선택했습니다.");
    				return;
    			}
            	
            	//data()로 값 가져올시 버그발생
            	//console.log($modal.data("date"), leftPad(input.data("time")));
            	//console.log($modal.attr("data-date"), leftPad(input.attr("data-time")));
            	
            	// 예약시간 버튼 클릭시 서버와 통신하여 상세 정보 open
            	var url = contextPath + "/PTreserve/getUserReserveDetailBy";
            	$.ajax(url,{
            		type : "POST",
            		data : JSON.stringify({
            			"userId" : "${pinfo.userid}",
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
            						"파트너 : "+detailData.trainerId+"<br>"+
            						"예약 날짜 : "+year+"년 "+month+"월 "+day+"일"+"<br>"+
            						"시작 시간 : "+detailData.startTime+"시"+
            						endTimeStr
            				)
            				.removeClass("hide");
            			// 모달 하단에 몇시 예약건을 선택했는지 display
                    	$modal.find(".tfoot-title").text(input.attr("data-time")+" 시 예약을 선택했습니다.");
            		},
            		error : function(){
            			alert("※상세 데이터를 가져오는데 실패 했습니다!※");
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
        			
        			// transition-duration 값을 milliseconds로 변경하여 setTime과  시간 동기화
        		}, css_seconds_to_milliSeconds($modal.css("transition-duration")));
        	}
        	
   	    	// END of MODAL script ==============================================================================
            
        });/* End of Ready  */
    </script>
</body>
</html>