<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
#tModal.tModal-overlay {
    width: 100%;
    height: 100%;
    position: fixed;
    left: 0;
    top: 0; 
    display: none;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    background: rgba(0, 0, 0, 0.7);
    backdrop-filter: blur(1.5px);
    z-index: 5;
}
#tModal .tModal-window {
    background: rgba( 255, 255, 255 );
    backdrop-filter: blur( 13.5px );
    border-radius: 10px;
    border: 1px solid rgba( 255, 255, 255, 0.18 );
    position: relative;
    top: 0px;
    padding: 10px;
    padding-right: 0px;
}
#tModal .tModal-title {
	padding-top: 10px;
	text-align: center;
    color: black;
}

#tModal .tModal-content {
    margin-top: 20px;
    padding: 0 10px;
    color: black;
}

#tModal .tModal-thead {
	text-align: center;
}

#tModal .tModal-tbody {
	display: block;
	height: 300px;	
	overflow-y: scroll;
}

#tModal .tModal-input {
	margin-top: 10px;	
	margin-right: 10px;
}

#tModal .tModal-h4 {
	margin: 10px;
}

#tModal .tModal-tfoot {
	text-align: center;
}

#tModal .tModal-tfoot button {
	width: 100px;
	margin: 10px;
}

</style>

<!-- 예약 상세 모달창  -->
<div id="tModal" class="tModal-overlay">
	<div class="tModal-window">
    	<div class="tModal-title">
            <h2 class="tModal-h2">마두철 트레이너 PT예약 -10월 26일</h2>
        </div>
        <div class="tModal-content">
        	<table class="tModal-table">
        		<!-- <thead class="tModal-thead">
        			<tr>
        				<td>시간</td>
        			</tr>
        		</thead> -->
        		<tbody class="tModal-tbody">
					<c:forEach var="i" begin="0" end="1">
					<tr><td><input type="button" value="${i+10}:00"></td></tr>
        			<%-- <tr><td><input type="button" value="${i+10}:30"></td></tr> --%>
					</c:forEach>
					
					<c:forEach var="i" begin="0" end="7">
					<tr><td><input type="button" value="${i+13}:00"></td></tr>
        			<%-- <tr><td><input type="button" value="${i+13}:30"></td></tr> --%>
					</c:forEach>
					
        			<tr><td><input type="button" value="21:00"></td></tr>
        		</tbody>
        		<tfoot class="tModal-tfoot">
        			<tr><td><h4 class="tModal-h4">예약시간을 선택해주세요</h4></td></tr>
        			<tr>
        				<td>
        					<button class="btn btn-default btn-sm">선택</button>
        					<button class="btn btn-primary btn-sm">취소</button>
        				</td>
        			</tr>
        		</tfoot>
        	</table>
        </div>
    </div>
</div>
<script>
	// 모달 요소 초기설정 스크립트
	$(function(){
		$(".tModal-table").find("tr").addClass("tModal-tr");
		$(".tModal-table").find("td").addClass("tModal-td");
		$(".tModal-tbody").find("input").addClass("tModal-input");
		
		
	})
</script>