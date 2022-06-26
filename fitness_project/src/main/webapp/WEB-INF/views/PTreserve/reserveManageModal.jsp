<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalTime"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 예약 상세 모달창  -->
<div id="tModal" class="tModal-overlay" data-date="">
	<div class="tModal-window">
    	<div class="tModal-title">
            <h2 class="tModal-h2">회원님의 @월 @일 예약 정보 입니다.</h2>
        </div>
        <div class="tModal-content">
        	<table class="tModal-table">
        		<thead class="tModal-thead">
        			<tr>
        				<td></td>
        			</tr>
        		</thead>
        		<tbody class="tModal-tbody">
					
        		</tbody>
        		<tfoot class="tModal-tfoot">
        			<tr><td><h4 class="tfoot-title">선택한 예약을 취소할 수 있습니다.</h4></td></tr>
        			<tr>
        				<td>
        					<button type="button" class="btn btn-default btn-sm modal-reserve-cancle">예약 취소</button>
        					<button type="button" class="btn btn-primary btn-sm modal-close">닫기</button>
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
				/*.find("input").addClass("tModal-input").end().end();
			.children(".tModal-thead")
				.find("td").text("현재 시간  : " + "${HHmm}"); */
	});
</script>