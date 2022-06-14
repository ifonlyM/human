<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<sec:authentication property='principal.member' var="pinfo"/>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="../includes/head.jsp"/>
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
        body .fc .fc-daygrid-day.fc-day-today { background-color: transparent; }
        body .fc .fc-daygrid-day.fc-day-today > div{ border:2px solid var(--today-color); }
        
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
		
		@keyframes fadein {
			from { opacity:0; }
			to { opacity:1; }
		} 
		
		@keyframes fadeout {
			from { opacity:1; }
			to { opacity:0; }
		}
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
    	// body의 초기 높이 저장
    	var originHeight = document.body.scrollHeight;
    	
    	// 스크롤바를 제외한 화면의 너비
    	var originWidth = document.documentElement.clientWidth;
    	
    	
    
        $(function(){
        	
        	function reserveVo(){
        		this.trainerName = "${param.trainerName}";
        		this.trainerId = "${param.trainerId}";
        		this.memberId = "${pinfo.userid}";
        		this.date = "";
        		this.startTime = "";
        		this.endTime = "";
        	}
        	
        	var reserve = new reserveVo(); 
        	
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
	        
            
            //모달 open 관련 스크립트
            // 마우스 클릭의 이벤트 순서   mousedown -> mouseup -> click
            {
            	// 모달 on/off 애니메이션 시간
	            var animTime = 300;
            	var modalWidth = 0;
            	
            	// 시간선택시 모달창에 표시
            	$(".tModal-tbody").on("click", "input", function(e){
            		reserve.startTime = $(this).val();
            		$(".tModal-h4").text("선택 시간 : " + reserve.startTime);
            	});
            	
	            // cell이외의 요소에 mousedown시 cell의 모든 추가요소 제거
	            // click으로 처리할시 event.target에 body가 잡힐때가 있어서 mousedown으로 변경
	            $("html").on("mousedown", "body", function(e) {
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
	       		$("#calendar").on("click", "td.fc-daygrid-day", function() {
	       			
					$("div.fc-daygrid-day-frame").css("box-shadow", "none");
	   	    		$(this).children("div").css("box-shadow", "0 0 0 2px var(--select-color) inset");
					
					$("td.fc-daygrid-day").removeClass("select-cell");
					$(this).addClass("select-cell");			
	   	    	});
	            
	        	// 선택된 캘린더 셀의 mousedown이벤트시 모달 켜짐
	        	$("#calendar").on("mousedown", "td.fc-daygrid-day", function(e) {
					// 우클린인 경우 실행안함	        		
	        		if(isRightButton(e)) return;

	        		// 선택한 셀인경우 모달 켜짐
					if($(this).hasClass("select-cell")) {
						//선택한 날짜 모달 타이틀에 출력 & reserveVo date set
						reserve.date = $(this).data("date");						
						$(".tModal-h2").html("${param.trainerName} 트레이너 예약<br>" + reserve.date);
						
						// 모달 켜짐과 애니메이션 실행
		   	    		$("#tModal.tModal-overlay").css({"display":"flex", "animation":"fadein "+ animTime + "ms"});
		   	    		
		   	    		// 모달창이 켜지면 백그라운드의 스크롤 막기
		   	    		$("body").css({"overflow":"hidden", "height":"100%"});
						
		   	    		// 스크롤의 width값만큼 body에 패딩값을 줘서 body너비에 변동이 없게함
		   	    		var curWidth = document.documentElement.clientWidth;
		   	    		$("body").css("padding-right", curWidth-originWidth);
		   	    		
		   	    		//모달 테이블 너비를 모달타이틀 너비보다 조금더 넓게
			        	$(".tModal-input").css("width", $(".tModal-h2").width());
					}
	   	    	});// END of 모달 open
	        	
	        	// 모달 close시 처리 함수
	        	function closeModal() {
	   	    		// 모달 꺼지는 애니메이션
	        		$("#tModal.tModal-overlay").css({"animation":"fadeout "+ animTime + "ms"});
        			//모달 애니가 끝난뒤
	        		setTimeout(function() {
	        			// 모달 끔
	        			$("#tModal.tModal-overlay").css({"display":"none"});
	        			// 모달 백그라운의 변경된 css 복구
	        			$("body").css({"overflow":"auto", "padding-right":"0"});	
	        			// 모달 선택시간 버튼및 출력문 초기화
	        			$(".tModal-h4").text("예약시간을 선택해 주세요.");
	        			$(".tModal-input").css("width", 100);
	        			
	        		}, animTime);
	        	}
	        	
	        	// 모달 외부 마우스다운 이벤트시 꺼짐
	        	$("#tModal.tModal-overlay").mousedown(function(e) {
	        		// 모달윈도우 외부 클릭시 꺼짐
	        		if(e.target.className.indexOf("overlay") >= 0) {
	        			closeModal();
	        			return;
	        		}
	        		//모달에서는 실행 x
	        		else if(e.target.className.indexOf("tModal") >= 0) {
						return;
	        		}
					closeModal();
	        	});
	        	
            }// END of MODAL script
            
            
            $(".reserve").click(function(){
            	alert(JSON.stringify(reserve));
            });
            console.log(JSON.stringify("${pageContext.request.session.getAttribute('trainers')}"));
            
        });// END of Ready
    </script>
</body>
</html>
