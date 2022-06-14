<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html lang="ko">
<head>
	<sec:csrfMetaTags/>
	<jsp:include page="../includes/head.jsp"/>
	<style>
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
        
        body > h1 {
        	margin-top: 50px;
        	margin-bottom: 50px;
        }
        
        .card-section{
        	margin: 50px 0 0;
        	padding: 40px 0;
        }
        
        body .container {
        	padding: 0 100px;
        }
        
        #career-inputs {
        	list-style: none;
        	padding: 0;
        }
        
        thead { color: whitesmoke;}
        label { color: whitesmoke;}
        
        table td {
        	padding-right: 10px;
        	padding-bottom: 10px;
        	background-clip: content-box; /* 패딩영역 제외하고 background속성 적용시키기  */
        	/* background-color: gray; */
        }
        table thead td { padding: 0;}
        table tfoot label { margin: 0;}
        
        .add-career-inputs { padding: 5px 20px; }
        .edit-career, .edited-career, .edit-cancel, .delete-career { padding: 5px 17px;}
        .buttons { text-align: center; margin-bottom: 50px;}
        .buttons button { margin: 20px;}
        
	</style>
</head>
<body>
    <div class="page-header">
        <jsp:include page="../includes/header.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">트레이너 경력 작성 및 관리</h1>
                        <p>트레이너를 선택하고 진행해주세요</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1 class="text-center">트레이너 경력 작성 및 관리</h1>
    <div class="space-medium section-color card-section">
        <div class="container">
        	<label for="trainer-select">트레이너 선택</label><br>
            <select name="trainers" id="trainer-select">
            	<option value="default">--트레이너 선택--</option>
            	<c:forEach items="${list}" var="trainer">
            	<option value="${trainer.userid}">${trainer.userName}</option>
            	</c:forEach>
            </select>
            <hr>
            <!-- 작성된 경력 사항이 있다면 출력하기  -->
            <table id="career-edits">
            	<thead>
            		<tr>
            			<td>경력</td>
            			<td>경력 시작일</td>
            			<td>경력 종료일</td>
            		</tr>
            	</thead>
            	<tbody>
            		<tr>
            			<td><input type="text" class="career-name" size="50" maxlength="50"  disabled></td>
            			<td><input type="date" class="career-startdate"  disabled></td>
            			<td><input type="date" class="career-enddate"  disabled></td>
            			<td class="edit-btn-cell"><button class="btn btn-secondary btn-sm edit-career" title="수정"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td>
            			<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm edited-career" title="저장"><i class="fa fa-floppy-o" aria-hidden="true"></i></button></td>
            			<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm delete-career" title="삭제"><i class="fa fa-trash-o" aria-hidden="true"></i></button></td>
						<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm edit-cancel" title="취소"><i class="fa fa-times" aria-hidden="true"></i></button></td>
            		</tr>
           		</tbody>
            	<tfoot>
            		<tr>
	            		<td>
	            			<label for="last-comments">저장된 COMMENT</label><br>
            				<input type="text" id="last-comments" size="50" maxlength="50" disabled>
	            		</td>
            		</tr>
            	</tfoot>
            </table>
            <hr>
            
            <table id="career-inputs">
            	<thead>
            		<tr>
            			<td>경력 작성</td>
            			<td>경력 시작일</td>
            			<td>경력 종료일</td>
            		</tr>
            	</thead>
            	<tbody>
	            	<tr>
	            		<td><input type="text" class="career-name" size="50" maxlength="50"></td>
	            		<td><input type="date" class="career-startdate"></td>
	            		<td><input type="date" class="career-enddate"></td>
	            		<td><button type="button" class="btn btn-secondary btn-sm add-career-inputs" title="추가">+</button></td>
	            	</tr>
            	</tbody>
            	<tfoot>
            		<tr>
	            		<td>
	            			<label for="comments">새로운 COMMENT 작성</label><br>
            				<input type="text" id="comments" size="50" maxlength="50">
	            		</td>
            		</tr>
            	</tfoot>
            </table>
            
        </div>
    </div>
    <form>
    <div class="buttons">
    	<button type="button" class="btn btn-warning" style="padding: 20px 5px">모든경력 삭제</button>
    	<button type="button" class="btn btn-secondary" onclick="history.back()">뒤로가기</button>
        <button type="submit" class="btn btn-default save-btn">작성하기</button>
    </div>
    </form>
    <jsp:include page="../includes/footer.jsp"/>
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>
    <jsp:include page="../includes/foot.jsp"/>
    <script>
    var csrfHeader = $("meta[name='_csrf_header']").attr("content")
	var csrfToken = $("meta[name='_csrf']").attr("content");
	if(csrfHeader && csrfToken){
		$(document).ajaxSend(function(e, xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		});
	}
	// 커리어 입력시 필요한 커리어 객체(생성자로 사용)
	 var careerVo = function (){ 
			cno				= 0,
			trainerId		= "",
			careerName 		= "",
			startDate		= "",
			endDate			= "",
			comments		= ""
	 };
			
    $(function(){
    	var contextPath = "${pageContext.request.contextPath}";
		var setTrainer = "${pageContext.request.getParameter('setTrainer')}";
		loadCareersBy(setTrainer);
		//history.replaceState({}, null, null);
		
		// 방금 데이터를 저장or수정한 트레이너가 있으면 select에 기본값으로 지정되어있기
		function loadCareersBy(setTrainer) {
			if(!setTrainer) return;
			$("#trainer-select").val(setTrainer);
			getCareers(setTrainer);
		}
		
		// 입력폼 초기화 함수 **************************************************************************************
		function clearInputs() {
			// comment 제거
			$edits.find("tfoot #last-comments").val("");

			// extends tr 제거
			$(".extends-career-edits").remove();
			
			// 기존tr 한줄은 값 비우고 disable만 하기
			$edits.find(".career-name").val("");
			$edits.find(".career-startdate").val("");
			$edits.find(".career-enddate").val("");
			getBackInputForm($edits.find("tr"));
		}
		
		// 경력 수정중 취소시 원본데이터로 돌아가야하는데 원본데이터를 저장하는 역할이 필요 ************************
		function saveInputData(tr) {
			var tempCareer = new careerVo();			
			tempCareer.careerName = tr.find(".career-name").val();
			tempCareer.startDate = tr.find(".career-startdate").val();
			tempCareer.endDate = tr.find(".career-enddate").val();
			return tempCareer;
		}
		
		// 경력 수정, 삭제, 취소후 원본폼으로 돌아가는 함수
		function getBackInputForm(tr) {
			// input disabled 설정
			tr.find(".career-name").attr("disabled", true)
			.end().find(".career-startdate").attr("disabled", true)
			.end().find(".career-enddate").attr("disabled", true);
			
			// 저장, 삭제, 취소버튼 가리기
			tr.find(".extends-cell").css("display", "none");
			
			//수정버튼 보이기
			tr.find(".edit-btn-cell").css("display", "table-cell");
		}
		
		// 수정 버튼 클릭시 해당 라인(tr) 수정폼으로 변경 =======================================================================
		var $edits = $("#career-edits");
		$edits.on("click", ".edit-career", function() {
			// 예외처리
			if($("#trainer-select").val() === "default"){
				alert("트레이너를 먼저 선택해주세요.")
				return;
			}
			// tr태그 가져오기
			var tr = $(this).parents("tr");
			
			// input disalbed 해제
			tr.find(".career-name").attr("disabled", false)
			.end().find(".career-startdate").attr("disabled", false)
			.end().find(".career-enddate").attr("disabled", false);
			
			// 원본 데이터 임시저장
			tr.data("temp", saveInputData(tr));
			
			//수정버튼 가리기
			tr.find(".edit-btn-cell").css("display", "none");
			
			// 저장, 삭제, 취소버튼 보이게하기
			tr.find(".extends-cell").css("display", "table-cell");
		});
		
		// 경력 수정 상태에서 취소x클릭시 원래 정보로 돌아가기 =====================================================
		$edits.on("click", ".edit-cancel", function() {
			var tr = $(this).parents("tr");
			//console.log(tr.data("temp"));
			//console.log(tr.data("temp").careerName); // 임시로 저장한 데이터에 이렇게 접근
			
			//원본 데이터 복구
			tr.find(".career-name").val(tr.data("temp").careerName);
			tr.find(".career-startdate").val(tr.data("temp").startDate);
			tr.find(".career-enddate").val(tr.data("temp").endDate);
			
			// 원본폼으로 input,button태그 변경
			getBackInputForm(tr);
		});
		
		// 경력 수정상태에서 저장클릭시 데이터 저장(update)하기 ===========================================================
		$edits.on("click", ".edited-career", function() {
			var tr = $(this).parents("tr");
			console.log(tr.data("cno"));
			
			var updateCareer = new careerVo();
			updateCareer.cno = tr.data("cno");
			updateCareer.careerName = tr.find(".career-name").val();
			updateCareer.startDate = tr.find(".career-startdate").val();
			updateCareer.endDate = tr.find(".career-enddate").val();
			
			var url = contextPath + "/PTreserve/updateCareer";
			$.ajax( url, {
				type: "POST",
				data: JSON.stringify(updateCareer),
				contentType: 'application/json; charset=utf-8',
				dataType: "text",
				success : function(result) {
					alert(result);
					// 원본폼으로 input,button태그 변경
					getBackInputForm(tr);
				},
				error : function() {
					alert("failed updateCareer ajax communication")
				}
			});
		});
		
		// 경력 수정상태에서 삭제버튼 클릭시 경력 삭제(delete)하기==============================================================
		$edits.on("click", ".delete-career", function() {
			var tr = $(this).parents("tr");
			var cno = tr.data("cno");
			console.log(cno);
			
			var url = contextPath + "/PTreserve/deleteCareer";
			$.ajax( url, {
				type: "POST",
				data: JSON.stringify(cno),
				dataType: "text",
				contentType: 'application/json; charset=utf-8',
				success : function(result) {
					alert(result);
					// 원본폼으로 input,button태그 변경
					getBackInputForm(tr);
					
					// 삭제된 경력란(tr)비활성화 (버튼까지 모두)
					tr.find(".career-name").val("----삭제된 내용입니다----");
					tr.find(".career-startdate").val("");
					tr.find(".career-enddate").val("");
					tr.find(".edit-career").attr("disabled", true);
					
				},
				error : function() {
					alert("failed deleteCareer ajax communication")
				}
			});
		});
		
		// select 변경시 해당 트레이너의 경력가져오기 ===============================================================================
		$(".container").on("change", "#trainer-select", function() {
			// select의 옵션이 --트레이너 선택-- 일경우 모든 입력폼의 데이터 제거
			if($(this).val() === "default") {
				clearInputs();
				return;
			}
			getCareers($(this).val());
		});

		// ajax이용 트레이너id로 커리어 리스트 가져오기 ******************************************************************
		function getCareers(trainerId){ 
			var url = contextPath + "/PTreserve/getCareers";
			$.ajax( url, {
				type: "POST",
				data: trainerId ,
				dataType: "JSON", //성공시 리턴받을 데이터를 JSON으로 받아옴
				contentType: 'application/json; charset=utf=8',
				success:function(data) {
					// 입력폼 초기화					
					clearInputs();
					
					// 가져온 커리어 리스트로 tr태그 작성
					writeCareers(data);
					
					// 트레이너 id로  최근에작성한 코멘트 가져와서 comment란에 출력
					getComments(trainerId);
				}
			});
		}
		
		// ajax에서 얻어온 경력list로 tr태그 작성 ************************************************************************
		// * for getCareers Function
		function writeCareers(list) {
			for(var i in list){
				// careerName이 비어있다면 출력안함
				if(!list[i].careerName) {
					continue;
				}
				
				// 첫번째 vo값은 기존에 있던 tr에 입력
				if(i == 0) {
					$edits.find("tbody tr").data("cno", list[i].cno);
					$edits.find(".career-name").val(list[i].careerName);
					$edits.find(".career-startdate").val(list[i].startDate);
					$edits.find(".career-enddate").val(list[i].endDate);					
					continue;
				}
				
				var str = "";
				str += '<tr class="extends-career-edits" data-cno="'+ list[i].cno +'">';
				str += '<td><input type="text" class="career-name" size="50" maxlength="50" value="'+ list[i].careerName +'"  disabled></td>';
				
				if(!list[i].startDate) {
					str += '<td><input type="date" class="career-startdate" disabled></td>';
				}
				else{
					str += '<td><input type="date" class="career-startdate" value="'+ list[i].startDate + '" disabled></td>';
				}
				
				if(!list[i].endDate) {
					str += '<td><input type="date" class="career-enddate"  disabled></td>';
				}
				else {
					str += '<td><input type="date" class="career-enddate" value="'+ list[i].endDate +'"  disabled></td>';
				}
				
				str +='<td class="edit-btn-cell"><button class="btn btn-secondary btn-sm edit-career" title="수정"><i class="fa fa-pencil-square-o" aria-hidden="true"></i></button></td>';
				str += '<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm edited-career" title="저장"><i class="fa fa-floppy-o" aria-hidden="true"></i></button></td>';
		    	str += '<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm delete-career" title="삭제"><i class="fa fa-trash-o" aria-hidden="true"></i></button></td>';
		    	str += '<td class="extends-cell" style="display: none"><button class="btn btn-secondary btn-sm edit-cancel" title="취소"><i class="fa fa-times" aria-hidden="true"></i></button></td>';
				str +='</tr>';
				$edits.append(str);
			}
		}
		
		// 선택된 트레이너의 마지막 코멘트 가져오기 ================================================================
		function getComments(trainerId) {
			var url = contextPath + "/PTreserve/getComments";
			$.ajax( url, {
				type: "POST",
				dataType: "text",
				data: trainerId,
				contentType: "application/text; charset=utf-8",
				success:function(data) {
					$edits.find("tfoot #last-comments").val(data);
				},
				error: function(){
					console.log("failed getComments ajax");
				}
			});
		}
		
	    // + 버튼 클릭했을때 경력입력라인 한줄더 생성 ===============================================================================
	    var $inputs = $("#career-inputs");	
	    $inputs.on("click", ".add-career-inputs", function(){
	    	var str = "";
	    	str += '<tr class="new-inputs">';
	    	str += '<td><input type="text" class="career-name" size="50" maxlength="50"></td>';
	    	str += '<td><input type="date" class="career-startdate"></td>';
	    	str += '<td><input type="date" class="career-enddate"></td>';
	    	str += '<td><button type="button" class="btn btn-secondary btn-sm add-career-inputs" title="추가">+</button></td>';
	    	str += '</tr>';
	    	
	    	// 원래 + 버튼을 가리기
	    	$(this).hide();
	    	
	    	$inputs.append(str);
	    });
	    
	    // 경력 입력항목 저장 ===========================================================================================================
	    /* $(".save-btn").click(function(e){ */
	    $("form").submit(function(e){
			e.preventDefault();	
	    	if($("#trainer-select").val() === "default"){
	    		alert("트레이너를 먼저 선택 해주세요!!");
	    		return;
	    	}
	    	
	    	// tr태그를 순회하면서  list에 추가
	    	var list = new Array();
	    	var careerInputs = $("#career-inputs tbody tr");
	    	
	    	careerInputs.each(function() {
	    		var vo = new careerVo();
	    		vo.trainerId = $("#trainer-select").val();
	    		vo.careerName = $(this).find(".career-name").val();
	    		vo.startDate = $(this).find(".career-startdate").val();
	    		vo.endDate = $(this).find(".career-enddate").val();
		    	vo.comments = $("#comments").val();
		    	if(vo.careerName) list.push(vo);
		    	else if(vo.comments) list.push(vo);
	    	});
	    	
	    	// career리스트가 1이상일때 db에 저장
	    	if(list.length > 0) {
	    		// 비동기 통신으로 데이터 저장
	    		var url = contextPath + "/PTreserve/careerWrite";
	    		$.ajax(url, {
	    			type:"POST",
	    			data: JSON.stringify(list),
	    			contentType: 'application/json; charset=utf-8',
	    			success:function(trainerId){
						console.log(trainerId);	    				
	    				// controller의 responseBody를 통해 data에 controller반환값을 넘겨줄수있다.
	    				alert("작성완료");
	    				loadCareersBy(trainerId);
	    				
	    				//작성완료후 *************
	    				// 추가생성된 input란 제거
	    				$(".new-inputs").remove();
	    				
	    				// 기본 input란 데이터 비워주기
	    				var defaultTR = $("#career-inputs tbody tr");
	    				defaultTR.find(".career-name").val("");
	    				defaultTR.find(".career-startdate").val("");
	    				defaultTR.find(".career-enddate").val("");
	    				defaultTR.find(".add-career-inputs").css("display", "inline-block");
	    				
	    				// 코멘트란 비워주기
	    				$("#comments").val("");
	    				
	    			},
	    			error:function(){
	    				alert("failed new career insert ajax");
	    			}
	    		});
	    	}
	    	else{
	    		alert("새로 작성된 경력 항목이 없습니다.");
	    	}
	    }); // END of 경력 입력 항목 저장
	    
	    // 선택된 트레이너의 모든 경력 삭제 ===========================================================================================================
	    $(".btn-warning").click(function(e){
	    	if($("#trainer-select").val() === "default"){
	    		alert("트레이너를 먼저 선택 해주세요!!");
	    		return;
	    	}
	    	
	    	if(!confirm("정말 삭제 하시겠습니까?")) return;
	    	console.log($("#trainer-select").val());
	    	
	    	
    		// 비동기 통신으로 데이터 저장
    		var url = contextPath + "/PTreserve/deleteAllCareer";
    		$.ajax(url, {
    			type:"POST",
    			data: $("#trainer-select").val(),
    			contentType: 'application/json; charset=utf-8',
    			success:function(data){
					console.log(data);	    				
    				// controller의 responseBody를 통해 data에 controller반환값을 넘겨줄수있다.
    				alert(data);
    				loadCareersBy($("#trainer-select").val());
    				
    				//삭제완료후 *************
    				// 추가생성된 input란 제거
    				$(".new-inputs").remove();
    				
    				// 기본 input란 데이터 비워주기
    				var defaultTR = $("#career-inputs tbody tr");
    				defaultTR.find(".career-name").val("");
    				defaultTR.find(".career-startdate").val("");
    				defaultTR.find(".career-enddate").val("");
    				defaultTR.find(".add-career-inputs").css("display", "inline-block");
    				
    				// 코멘트란 비워주기
    				$("#comments").val("");
    			},
    			error:function(){
    				alert("failed new career insert ajax");
    			}
    		});
	    }); // END of 경력 입력 항목 저장
	    
    }); // END of Ready
    </script>
</body>
</html>
