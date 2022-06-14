<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html lang="ko">

<head>
   <jsp:include page="../includes/head.jsp" />
   
   <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta name="_csrf" content="${_csrf.token}" />
<style type="text/css">
th{text-align: center;}
 *{margin:0;padding:0;}
    .sl, .sl li{list-style:none;}
    .slide{height:500px;overflow:hidden; position:relative; top: -86px;}
    .slide .sl {width:calc(100% * 4);display:flex;animation:slide 25s infinite;} /* slide를 8초동안 진행하며 무한반복 함 */
    .slide .sl li{width:calc(100% / 4);height:500px;}
    .slide .sl li:nth-child(1){background:linear-gradient(rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3)), url(${pageContext.request.contextPath}/resources/images/시설4.jpg) no-repeat center;
    							background-size: cover;}
    .slide .sl li:nth-child(2){background:linear-gradient(rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3)), url(${pageContext.request.contextPath}/resources/images/시설3.jpg) no-repeat center;
    							background-size: cover;}
    .slide .sl li:nth-child(3){background:linear-gradient(rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3)), url(${pageContext.request.contextPath}/resources/images/시설2.jpg) no-repeat center;
    							background-size: cover;}
    .slide .sl li:nth-child(4){background:linear-gradient(rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3), rgba(19, 19, 18, 0.3)), url(${pageContext.request.contextPath}/resources/images/시설1.jpg) no-repeat center;
    							background-size: cover;}
    @keyframes slide {
      0% {margin-left:0;} /* 0 ~ 10  : 정지 */
      10% {margin-left:0;} /* 10 ~ 25 : 변이 */
      25% {margin-left:-100%;} /* 25 ~ 35 : 정지 */
      35% {margin-left:-100%;} /* 35 ~ 50 : 변이 */
      50% {margin-left:-200%;}
      60% {margin-left:-200%;}
      75% {margin-left:-300%;}
      85% {margin-left:-300%;}
      100% {margin-left:0;}
    }
</style>

   
</head>

<body>
   
    <div>
        <jsp:include page="../includes/header.jsp" />
         <div class="slide" >
	     <ul class="sl">
		      <li></li>
		      <li></li>
		      <li></li>
		      <li></li>
	    </ul>
    	</div>
    </div>
    <div class="content" style="padding-top: 0px;">
        <!-- main-container -->
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                    <a href="${pageContext.request.contextPath }/AdminServe/boardList"><h1 class="mb30">게시글조회</h1></a>
                    <hr>
                    <div>
                     <form class="form-inline">
                                           <select name="type" class="custom-search-input" style="width: 100px; height: 35px; margin: 0; ">
                                              <option value="N">NO</option>
                                              <option value="T">제목</option>
                                              <option value="W">작성자</option>
                                              <option value="P">작성일</option>
                                              <option value="CATE">카테고리</option>
                                              
                                           </select>
                           <div class="col-md-3 col-sm-4 col-xs-12" style="padding-left: 0px;">
                            <div class="top-search">
                                <div class="custom-search-input" >
                                    <div class="input-group  " id="dataTable_filter" >
                                        <input name="keyword" type="search" class="  search-query form-control" placeholder="Search" style="color: white;  aria-controls="dataTable">
                                        <span class="input-group-btn">
			                                <button class="btn btn-default" >
			                                 <i class="fa fa-search"></i> 
			                                 </button>
                                		</span> 
                                	</div>
                                </div>
                            </div>
                        </div>
                      </form>
                        
                    </div>
                    <table class="table table table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th style="text-align: center;"><input type="checkbox" id="allCheck" name="allCheck" ></th>
                                <th>NO</th>
                                <th>제목</th>
                                <th>작성자</th>
                                <th>작성일</th>
                                <th>카테고리</th>
           
                            </tr>
                        </thead>
                        <tbody>
                         <c:forEach items="${list}" var="board">
                                             <tr>
                                             	<td><input type="checkbox" id="${board.bno}" name="check"></td>
                                             	<td><c:out value="${board.bno}" /></td>
                                                <td><a href="${pageContext.request.contextPath }/board/get${page.cri.params}&bno=${board.bno}"><c:out value="${board.title}" /></a></td>
                                               	<td><c:out value="${board.writer}" /></td>
                                                <td><fmt:formatDate value="${board.regDate}" pattern="yyyy-MM-dd"/></td>
                                                <td>
                                                <c:set var="category" value="${board.category}"></c:set>
                                                <c:choose>
												    <c:when test="${category == '1'}">공지사항</c:when>
												    <c:when test="${category == '2'}">자유게시판</c:when>
												    <c:when test="${category == '3'}">갤러리</c:when>
												    <c:when test="${category == '4'}">운동영상</c:when>
												 <c:otherwise>
											        미입력
											    </c:otherwise>
												</c:choose>
												</td>
                                             </tr>
                                           
                                          </c:forEach>
                            
                        </tbody>
                    </table>
                    <hr>
                    <div style="text-align: right;">
                        <input class="btn btn-primary btn-sm" type="button" id="del" value="삭제" onclick="deleteReport()">
                    </div>
                    
                  
                      <input type="hidden" name="pageNum" value="${page.cri.pageNum }">
                	<input type="hidden" name="amount" value="${page.cri.amount }">
                    
				      <div class="row" style="text-align: center;">
					   <div class="container ">
					   	<div class="st-pagination">
							<ul class="pagination justify-content-center">
								<li class="page-item previous ${page.prev ? '' : 'disabled'}" id="dataTable_previous">
									<a class="page-link bg-dark text-white" href="boardList?pageNum=${page.startPage-1}&amount=${page.cri.amount}">&lt;</a>
								</li>
								
								<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p" >
								   <li class="page-item ${p == page.cri.pageNum ? 'active' : ''}">
								   	<a class="page-link" href="boardList?pageNum=${p}&amount=${page.cri.amount}">${p}</a>
								   </li>
								</c:forEach>
								
								<li class="page-item ${p == page.cri.pageNum ? 'active' : '' }" id="dataTable_next">
									<a class="page-link bg-dark text-white" href="boardList?pageNum=${page.endPage+1}&amount=${page.cri.amount}">&gt;</a>
								</li>
							</ul>
						</div>	
					   </div>
				  </div>
                </div>
            </div>
        </div>
    </div>
     <jsp:include page="../includes/footer.jsp" />
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>
    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
   	<jsp:include page="../includes/foot.jsp" />
    <script>
   
  
   
    
    // ajax 통신을 위한 csrf 설정
   /*     var token = $("meta[name='_csrf']").attr("content");
       var header = $("meta[name='_csrf_header']").attr("content");
       $(document).ajaxSend(function(e, xhr, options) {
           xhr.setRequestHeader(header, token);
       });
     */
    
    $("#allCheck").click(function () {
		
		if($("input:checkbox[id='allCheck']").prop("checked")){
			$("input[type=checkbox]").prop("checked",true);
		}else {
			$("input[type=checkbox]").prop("checked",false);
		}
	});
    
    $("input[name='check']").click(function () {
		$("input:checkbox[id='allCheck']").prop("checked",false);
	});
    
  //체크된 것만 삭제
	function deleteReport(){
        var cnt = $("input[name='check']:checked").length;
        var arr = new Array();
        var header = $("meta[name='_csrf_header']").attr("content");
        var token = $("meta[name='_csrf']").attr("content");
        
      
        $("input[name='check']:checked").each(function() {
        	/* confirm("정말삭제하시겠습니까?") */
            arr.push($(this).attr('id'));
        
           
        });
        console.log(arr)
       	
        
	    if(cnt == 0){
	        alert("선택된 글이 없습니다.");
	    }
	 	else{
            $.ajax({
                type: "POST",
                url: "boardDelete",
                data: "bno=" + arr,
                beforeSend: function(xhr){
        			xhr.setRequestHeader(header, token);	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
        		},
                success: function(data){
                    if(data) {
                        alert("ID:"+"["+arr+"]" + "삭제 성공");
                        location.reload();
                    }
                    else{
                        alert("삭제 실패");
                    }
                }
               
            }); 
	    } 
    }
    
    </script>
   
</body>

</html>
