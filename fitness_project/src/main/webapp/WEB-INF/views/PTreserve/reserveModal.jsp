<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%!
	// 오늘 날짜
	LocalDate day = LocalDate.now();
	
	// 현재 시간 구하여 예약 불가능한 시간은 버튼 비활성화하기
	LocalTime time = LocalTime.now();
	String HH = time.format(DateTimeFormatter.ofPattern("HH"));
	String HHmm = time.format(DateTimeFormatter.ofPattern("HH시 mm분"));
%>
<%-- <div id="time" hidden="hidden"><%=HHmm %></div> --%>
<c:set var="HHmm" value="<%=HHmm %>"/>
<c:set var="HH" value="<%=HH %>"/>
<!-- 예약 상세 모달창  -->
<div id="tModal" class="tModal-overlay">
	<div class="tModal-window">
    	<div class="tModal-title">
            <h2 class="tModal-h2">마두철 트레이너 PT예약 -10월 26일</h2>
        </div>
        <div class="tModal-content">
        	<table class="tModal-table">
        		<thead class="tModal-thead">
        			<tr>
        				<td></td>
        			</tr>
        		</thead>
        		<tbody class="tModal-tbody">
					<c:forEach var="i" begin="10" end="21">
					<%-- <c:choose>
						<c:when test="${HH >= i }">
						<tr><td><input type="button" value="${i}:00" class="btn-secondary btn-disabled" disabled="disabled"></td></tr>
						</c:when>
						
						<c:otherwise>
						<tr><td><input type="button" value="${i}:00" class="btn-default"></td></tr>
						</c:otherwise>
					</c:choose> --%>
					<tr><td><input type="button" value="${i}:00" class="btn-default" data-time="${i}"></td></tr>
					</c:forEach>
        		</tbody>
        		<tfoot class="tModal-tfoot">
        			<tr><td><h4 class="tModal-h4">예약시간을 선택해주세요</h4></td></tr>
        			<tr>
        				<td>
        					<button type="button" class="btn btn-default btn-sm modal-select">예약하기</button>
        					<button type="button" class="btn btn-primary btn-sm modal-close">취소</button>
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
		var modalTable = $(".tModal-table");
		/* var nowTime = time.textContent; */
		
		modalTable
			.find("tr").addClass("tModal-tr").end()
			.find("td").addClass("tModal-td").end()
			.children(".tModal-tbody")
				.find("input").addClass("tModal-input").end().end();
			/* .children(".tModal-thead")
				.find("td").text("현재 시간  : " + "${HHmm}"); */
	});
</script>