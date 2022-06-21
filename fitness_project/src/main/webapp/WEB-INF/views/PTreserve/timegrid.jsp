<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
					<c:forEach var="i" begin="10" end="21">
					<c:choose>
						<c:when test="${hour >= i }">
						<tr><td><input type="button" value="${i}:00" class="btn-default" disabled="disabled"></td></tr>
						</c:when>
						
						<c:otherwise>
						<tr><td><input type="button" value="${i}:00" class="btn-default"></td></tr>
						</c:otherwise>
					</c:choose>
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
		$(".tModal-table").find("tr").addClass("tModal-tr");
		$(".tModal-table").find("td").addClass("tModal-td");
		$(".tModal-tbody").find("input").addClass("tModal-input");
	})
</script>