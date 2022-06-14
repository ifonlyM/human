<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="../includes/head.jsp" />
<style>
	.header{background: #222}
	.content {margin-top: 50px;}
	.list table {width: 100%; margin: 0px auto; border-collapse: collapse;'}
	.list th, .list td{padding: 8px;}
	.list th {background: #222;}
	.list td {border-bottom: 3px solid #222; text-align: center; width: 10%;}
	.list td + td{text-align: left; width: 70%;}
	.list td + td + td {text-align: center; width: 10%;}
</style>
</head>
<body>
<main class="list">
<jsp:include page="../includes/header.jsp" />
<div class="content" style="padding-top: 0px;">
<div class="container">
	<div class="justify-content-end" >
		<form class="form-inline" method="get" action="/board/notice_list" >
			<select name="type" class="custom-search-input" style="width: 100px; height: 35px; margin: 0;">
				<option value="T">
					<c:out value="${page.cri.type eq 'T'?'':''}" />제목
				</option>
				<option value="C">
					<c:out value="${page.cri.type eq 'C'?'':''}" />내용
				</option>
				<option value="W">
					<c:out value="${page.cri.type eq 'W'?'':''}" />작성자
				</option>
			</select>
			<div class="col-md-3 col-sm-4 col-xs-12" style="padding-left: 0px;">
				<div class="top-search">
		        	<div class="custom-search-input">
						<div id="dataTable_filter" class="input-group ">
							<input name="keyword" type="search" class="search-query form-control form-control-sm text-white"  placeholder="search" aria-controls="dataTable">
							 <span class="input-group-btn">
								<button class="btn btn-primary btn-sm" >
									<i class="fa fa-search"></i>
								</button>
							</span>	
						</div>
					</div>
				</div>
			</div>		
			<input type="hidden" name="pageNum" value="${page.cri.pageNum }">
			<input type="hidden" name="amount" value="${page.cri.amount }">
	<%-- 	<input type="hidden" name="type" value="<c:out value="${page.cri.type }"/>">
			<input type="hidden" name="keyword" value="<c:out value="${page.cri.keyword }"/>"> --%>
		</form>
	</div>
	  <table class="table table-hover">
	  	<col>
		<col style="width:65%">
		<col>
		<col>
	    <thead class="thead-dark">
	      <tr class="text-center"> 
	        <th>글번호</th>
	        <th>제목</th>
	        <th>작성자</th>        
	        <th>작성일</th>
	        <th>수정일</th>
	      </tr>
	    </thead>
	    <tbody>
	   		<c:forEach items="${list}" var="board">
			<tr>
				<td><c:out value="${board.bno }" /> </td>
				<td><a href="get${page.cri.params}&bno=${board.bno }&category=${category}"><c:out value="${board.title }" /><b>[${board.replyCnt}]</b></a></td>
				<td><c:out value="${board.writer }" /> </td>
				<td><fmt:formatDate value="${board.regDate }" pattern="yy-MM-dd"/></td>
				<td><fmt:formatDate value="${board.updateDate }" pattern="yy-MM-dd"/></td>
			</tr>
	   		</c:forEach>
	    </tbody>
	    	<tfoot>
	    	<sec:authorize access="hasAnyRole('ROLE_ADMIN')">
				<tr>
					<td colspan="5">
						<a href="register?category=${category}" class="btn btn-default btn-sm float-right">글작성</a>
					</td>
				</tr>
			</sec:authorize>
	    	</tfoot>
	  </table>
	  
	  <div class="row" style="text-align: center;">
		   <div class="container"  >
		   	<div class="st-pagination">
				<ul class="pagination justify-content-center">
					<li class="page-item previous ${page.prev ? '' : 'disabled'}" id="dataTable_previous">
						<a class="page-link bg-dark text-white" href="notice_list?pageNum=${page.startPage-1}&amount=${page.cri.amount}">&lt;</a>
					</li>
					
					<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p" >
					   <li class="page-item ${p == page.cri.pageNum ? 'active' : ''}">
					   	<a class="page-link" href="notice_list?pageNum=${p}&amount=${page.cri.amount}">${p}</a>
					   </li>
					</c:forEach>
					
					<li class="page-item ${p == page.cri.pageNum ? 'active' : '' }" id="dataTable_next">
						<a class="page-link bg-dark text-white" href="notice_list?pageNum=${page.endPage+1}&amount=${page.cri.amount}">&gt;</a>
					</li>
				</ul>
			</div>	
		   </div>
	  </div>
</div>	  
</div> 
</main>
	
	<!-- back to top icon -->
<jsp:include page="../includes/footer.jsp" />
<script>
$(function() {
	var result = '${result}';
	checkModal(result);
	history.replaceState({}, null, null);
	function checkModal(result) {
		if(!result || history.state) {
			return;
		}
		var text = result == 'success' ? "처리가 완료되었습니다." : "게시글" + result + "번이 등록되었습니다"; 
		$("#myModal .modal-body").text(text);
		$("#myModal").modal("show");
	}
});
</script>
<!-- List Modal-->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Message</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body"></div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">close</button>
                </div>
            </div>
        </div>
    </div>


	<a href="#0" class="cd-top" title="Go to top">Top</a>
<jsp:include page="../includes/foot.jsp" />
</body>
</html>