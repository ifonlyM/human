<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<jsp:include page="../includes/head.jsp" />
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

<!-- ajax 통신을 위한 meta tag -->
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <meta name="_csrf" content="${_csrf.token}" />

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
    <div class="content" style="padding-top: 0; ">
        <!-- main-container -->
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                     <a href="${pageContext.request.contextPath }/AdminServe/blackList"><h1 class="mb30">블랙리스트</h1></a>
                    <hr>
                    <div>
                   <form class="form-inline">
                                           <select name="type" class="custom-search-input" style="width: 100px; height: 35px; margin: 0;">
                                              <option value="I">ID</option>
                                              <option value="T">기간</option>
                                              <option value="S">등록일자</option>
                                              <option value="E">만료일자</option>
                                              <option value="R">사유</option>
                                           </select>
                           <div class="col-md-3 col-sm-4 col-xs-12" style="padding-left: 0px;">
                            <div class="top-search">
                                <div class="custom-search-input" >
                                    <div class="input-group  " id="dataTable_filter" >
                                   		<input name="keyword" type="search" class="search-query form-control" value="${page.cri.keyword}" placeholder="Search" style="color: white;"  aria-controls="dataTable">
                                        <%-- <input name="keyword" type="date" class="search-query form-control" value="${page.cri.keyword}" placeholder="Search" style="color: white;  aria-controls="dataTable">  --%>
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
                
                   <form name="f"  method="post">
                    <table class="table table table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th style="text-align: center;"><input type="checkbox" id="allCheck" name="allCheck"   ></th>
                                <th>No</th>
                                <th>ID</th>
                                <th>등록일자</th>
                                <th>기간</th>
                                <th>만료일자</th>
                                <th>사유</th>
                            </tr>
                        </thead>
                        <tbody>
                      
                                          <c:forEach items="${list}" var="blacklist">
                                         
                                             <tr>
                                             	<td><input type="checkbox" id="${blacklist.blackno}" name="check"></td>
                                                <td><c:out value="${blacklist.blackno}" /></td>
                                               	<td><c:out value="${blacklist.id}" /></td>
                                               	<td><c:out value="${blacklist.start_date}" /></td>
                                               	<td><c:out value="${blacklist.term}" />일</td>
                                                <td><c:out value="${blacklist.end_date}" /></td>
                                                <td><c:out value="${blacklist.resson}" /></td>
                                             </tr>
                                           
                                          </c:forEach>
                                          </tbody>
                            
                       
                    </table>
                    </form> 
                    <hr>
                  	<div style="text-align: right;">
                  		<button type="button" class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal">등록</button>
						<input class="btn btn-primary btn-sm" type="button" id="del" value="삭제" onclick="deleteReport()">
                    </div>
                    <!--페이징 처리  -->
                    
                      <input type="hidden" name="pageNum" value="${page.cri.pageNum }">
                	<input type="hidden" name="amount" value="${page.cri.amount }">
                    
				      <div class="row">
					   <div class="container ">
					   	<div class="st-pagination">
							<ul class="pagination justify-content-center">
								<li class="page-item previous ${page.prev ? '' : 'disabled'}" id="dataTable_previous">
									<a class="page-link bg-dark text-white" href="blackList?pageNum=${page.startPage-1}&amount=${page.cri.amount}">&lt;</a>
								</li>
								
								<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p" >
								   <li class="page-item ${p == page.cri.pageNum ? 'active' : ''}">
								   	<a class="page-link" href="blackList?pageNum=${p}&amount=${page.cri.amount}&type=${page.cri.type}&keyword=${page.cri.keyword}">${p}</a>
								   </li>
								</c:forEach>
								
								<li class="page-item ${p == page.cri.pageNum ? 'active' : '' }" id="dataTable_next">
									<a class="page-link bg-dark text-white" href="blackList?pageNum=${page.endPage+1}&amount=${page.cri.amount}&type=${page.cri.type}&keyword=${page.cri.keyword}">&gt;</a>
								</li>
							</ul>
						</div>	
					   </div>
				  </div>
                  
                </div>
            </div>
              <!-- The Modal -->
			  <div class="modal fade" id="myModal">
			    <div class="modal-dialog modal-dialog-centered">
			      <div class="modal-content">
			      
			        <!-- Modal Header -->
			        <div class="modal-header">
			          <h4 class="modal-title">블랙리스트 등록</h4>
			          <button type="button" class="close" data-dismiss="modal">&times;</button>
			        </div>
			        
			        <!-- Modal body -->
			        <div class="modal-body">
			          <form method="post" name="frm">
                            <table class="table table-hover table-bordered">
                                <tbody>
                                    <tr>
                                        <td>아이디</td>
                                        <td colspan="5"><input id="id" name="id" type="text" placeholder="아이디를 입력하세요." ></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">기간</td>
                                        <td>
                                                <div class="form-group" style="margin: 0;">
                                                 
                                                  <select class="form-control" id="term" name="term" style="width: 190px; height: 35px; padding: 2px; ">
                                                    <option value="3">3일</option>
                                                    <option value="7">7일</option>
                                                    <option value="14">14일</option>
                                                    <option value="30">30일</option>
                                                    <option value="90">90일</option>
                                                  </select>
                                                </div>
                                        </td>
                                    </tr>
                                                                
                                                                    
                                    <tr>
                                        <td>사유</td>
                                        <td colspan="2"><textarea  name="resson" id="resson" cols="40" rows="5" style="resize: none;"></textarea></td>
                                    </tr>
                                </tbody>
                            </table>
                            <!--  <button type="submit" class="btn btn-primary" >등록</button> -->
                        </form>
                    </div>
			     
			        
			        <!-- Modal footer -->
			        <div class="modal-footer">
			          <button id="regi" type="button" class="btn btn-primary" data-dismiss="modal">등록</button>
			          <button type="button" class="btn btn-danger" data-dismiss="modal">취소</button>
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
    
/*  // ajax 통신을 위한 csrf 설정
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader(header, token);
    });
 */
    // 블랙리스트 등록
    $("#regi").click(function () {
    	
    	
    	
        var header = $("meta[name='_csrf_header']").attr("content");
        var token = $("meta[name='_csrf']").attr("content");
    	var id = $("#id").val();
    	var term = $("#term").val();
    	var resson = $("#resson").val();
    	console.log(id);
    	console.log(term);
    	console.log(resson);
    	var param = {"id":id,"term":term,"resson":resson};
    	
    	
    	
    	console.log(param);
         $.ajax({
        	 	contentType : "application/json; charset=UTF-8",
                type: "POST",
                url: "blacklistregister",
                data: JSON.stringify(param),
                beforeSend: function(xhr){
        			xhr.setRequestHeader(header, token);	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
        		},
                success: function(data){
                    if(data) {
                        alert(id + "등록 성공");
                        location.reload();
                    }
                    else{
                        alert("삭제 실패");
                    }
                }
               
            });  
		});
    	
    
    
    
    //체크박스 전체선택 
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
	        alert("선택된 블랙리스트회원이 없습니다.");
	    }
	 	else{
            $.ajax({
                type: "POST",
                url: "blackDelete",
                data: "blackno=" + arr,
                beforeSend: function(xhr){
        			xhr.setRequestHeader(header, token);	// 헤드의 csrf meta태그를 읽어 CSRF 토큰 함께 전송
        		},
                
                success: function(data){
                    if(data) {
                        alert("NO"+"["+arr+"]" + "삭제 성공");
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
