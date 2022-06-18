<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property='principal.member' var="pinfo"/>
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
        body .fc .fc-daygrid-day.fc-day-today > div{ border:2px solid var(--today-color); }
        body .fc .fc-daygrid-day.fc-day-today , body .fc .fc-daygrid-day.fc-day-future {
        	border-color: rgb(221, 221, 221);
        }
        
        /* 과거날짜 배경색 지정 */
        body .fc .fc-daygrid-day.fc-day-past {
        	background-color: RGB(220, 220, 220);
        	border: gray 1px solid;
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
    </style>

    <!-- FullCalendar -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.css">
    <script src="https://cdn.jsdelivr.net/npm/fullcalendar@5.9.0/main.min.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            var calendarEl = document.getElementById('calendar');

            var calendar = new FullCalendar.Calendar(calendarEl, {
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
    	        <button class="btn btn-default reserve">예약하기</button>
            </div>
        </div>
    </div>
    
    <jsp:include page="../includes/footer.jsp"/>
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>

    <jsp:include page="../includes/foot.jsp"/>
    
    <!-- modal  -->
    <jsp:include page="../PTreserve/timegrid.jsp"/>
    
    <!-- FullCalendar Custom & timegridModal Control -->
    <script>
    	// csrf 토큰을 미리 설정
    	var csrfHeader = $("meta[name='_csrf_header']").attr("content")
		var csrfToken = $("meta[name='_csrf']").attr("content");
		if(csrfHeader && csrfToken){
			$(document).ajaxSend(function(e, xhr) {
				xhr.setRequestHeader(csrfHeader, csrfToken);
			});
		}
    	// contextPath
    	var contextPath = "${pageContext.request.contextPath}";
    	
    	// body의 초기 높이 저장
    	var originHeight = document.body.scrollHeight;
    	
    	function reserveVo(){
    		this.trainerId = "${param.trainerId}";
    		this.memberId = "${pinfo.userid}";
    		this.reserveDate = "";
    		this.startTime = "";
    		this.endTime = "";
    	}
       	var reserve = new reserveVo(); 
    	
        $(function(){
        	var $body = $("body");
        	var $html = $("html");
        	var $modal = $("#tModal");
        	var $calendar = $("#calendar");
        	
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

            //달력 날짜 선택시 색깔 변경 
            //$(".fc-highlight").css("background","#c5f016")
            //-> 라이브러리 기본 우선순위에 밀려나기때문에 이벤트위임처리를 하던가
            //   css속성을 줄때 기존css 선택자보다 부모 레벨 선택자부터 시작해서 속성을 부여해준다.
            /* =====================================================================================  */
	        
            
            //모달 open 관련 스크립트==============================================================================
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
					//선택한 날짜 모달 타이틀에 출력 & reserveVo date set
					reserve.reserveDate = dayGrid.data("date");						
					$modal
						.find(".tModal-h2")
							.html("${param.trainerName} 트레이너 예약<br>" + reserve.reserveDate).end()
						// 모달 오픈시 visibility, opacity 속성을 사용해 fadeIn 연출
						.addClass("open-modal");
					
	   	    		// 모달 켜졌을때 body스크롤 막기 & 스크롤 넓이만큼 padding-right
					var onScrollBodyWidth = $body.width() ;
					$body
						.addClass("hide-scroll")
						.css("padding-right", window.innerWidth - onScrollBodyWidth);
				}
   	    	});
        	
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
   	    		
       			//모달 fadeOut 끝난뒤
        		setTimeout(function() {
        			$modal.find(".tModal-h4").text("예약시간을 선택해 주세요.");
        			$body
        				.removeClass("hide-scroll")
        				.css("padding-right", "0");
        		}, css_seconds_to_milliSeconds($modal.css("transition-duration")));
        	}
        	
        	// 모달 선택 버튼 클릭시 예약정보 텍스트 화면에 출력
        	$modal.find(".modal-select").mousedown(function(){
        		closeModal(true);
        		alert(
       				"예약정보를 확인 해주세요.\n"+
           			"담당 트레이너 : " + "${param.trainerName}\n"+
           			"예약 날짜 : " + reserve.reserveDate + "\n"+
           			"예약 시간 : " + reserve.startTime + "\n"
            	);
        	});
   	    	
   	    	// 모달 취소 버튼 클릭시 모달 꺼짐
   	    	$modal.find(".modal-close").mousedown(function() {
   	    		closeModal(false);
   	    	})
        	
        	// 모달 외부 마우스다운 이벤트시 꺼짐
        	$modal.mousedown(function(e) {
        		//모달에서는 실행 x
        		if(e.target.className.indexOf("overlay") >= 0)
					closeModal(false);
        		else
        			return;
        	});
   	    	// END of MODAL script ==============================================================================
            
            // PT 예약하기
            $(".reserve").click(function(){
            	if(!reserve.reserveDate) {
            		alert("예약 날짜를 선택해주세요!");
            	}
            	else if(!reserve.startTime) {
            		alert("예약 시간을 선택해주세요!");
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
            		var url = contextPath = "/PTreserve/reservePT";
                	$.ajax(url, {
                		type : "POST",
                		data : JSON.stringify(reserve),
                		contentType : 'application/json; charset=utf-8',
                		dataType : "text",
                		success : function(result) {
                			alert(result);
                		},
                		error : function() {
                			alert("failed reservePT ajax communication");
                		}
                	});
            	}
            });
            
        });// END of Ready
    </script>
</body>
</html>
