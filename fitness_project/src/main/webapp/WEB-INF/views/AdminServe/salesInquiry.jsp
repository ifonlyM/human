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
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.6.0/chart.min.js"></script>
 <meta name="_csrf_header" content="${_csrf.headerName}" />
 <meta name="_csrf" content="${_csrf.token}" />
</head>

<body >
  
    <div >
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
    <div class="content" style="padding-top: 0;">
        <!-- main-container -->
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" style="text-align: center;">
                
                     <a href="${pageContext.request.contextPath }/AdminServe/salesInquiry"><h1 class="mb30">매출관리</h1></a>
                    <hr>
                	<canvas id="ctx" width="400" height="150"></canvas>
                	<hr>
                    <div>
                   <form class="form-inline">
                                           <select name="type" id="sel" class="custom-search-input" style="width: 100px; height: 35px; margin: 0;">
                                              <option value="I">ID</option>
                                              <option value="N">NAME</option>
                                              <option value="C">금액</option>
                                              <option value="D">구매일자</option> 
                                              <option value="T">담당트레이너</option> 
                                              <option value="B">구매내용</option>
                                              <option value="P">결제방법</option>
                                           </select>
                           <div class="col-md-3 col-sm-4 col-xs-12" style="padding-left: 0px;">
                            <div class="top-search">
                                <div class="custom-search-input" >
                                    <div class="input-group  " id="dataTable_filter" >
                                        <input name="keyword" type="search" class="  search-query form-control" value="${page.cri.keyword}" placeholder="Search" style="color: white;  aria-controls="dataTable">
                                        <span class="input-group-btn">
			                                <button class="btn btn-default" >
			                                 <i class="fa fa-search"></i> 
			                                 </button>
                                		</span> 
                                	</div>
                                </div>
                            </div>
                        </div>
                        
                           <input type="hidden" name="pageNum" value="${page.cri.pageNum }">
                			<input type="hidden" name="amount" value="${page.cri.amount }">
                			
					
					</form>
                    </div>
                    
                   <form name="f"  method="post">
                    <table class="table table table-hover">
                        <thead class="thead-dark">
                            <tr>
                                <th style="text-align: center;"><input type="checkbox" id="allCheck" name="allCheck"   ></th>
                                <th>No</th>
                                <th>ID</th>
                                <th>NAME</th>
                                <th>금액</th>
                                <th>구매일자</th>
                                <th>담당트레이너</th>
                                <th>구매내용</th>
                                <th>결제방법</th>
                            </tr>
                        </thead>
                        <tbody>
                      
                                          <c:forEach items="${list}" var="sales">
                                             <tr>
                                             	<td><input type="checkbox" id="${sales.sno}" name="check"></td>
                                                <td><c:out value="${sales.sno}" /></td>
                                               	<td><a href="salesget${page.cri.params}&sno=${sales.sno }"><c:out value="${sales.id}" /></a></td>
                                                <td><c:out value="${sales.name}" /></td>
                                                <td><c:out value="${sales.cost}" /></td>
                                                <td><fmt:formatDate value="${sales.buydate}" pattern="yyyy-MM-dd"/></td>
                                                <td><c:out value="${sales.trainer}" /></td>
                                                <td><c:out value="${sales.buycontent}" /></td>
                                                <td><c:out value="${sales.payment}" /></td>
                                             </tr>
                                           
                                          </c:forEach>
                                          </tbody>
                            
                       
                    </table>
                    </form> 
                    <hr>
                  	<div style="text-align: right;">
                       <a href="${pageContext.request.contextPath }/AdminServe/salesRegister"><button class="btn btn-default btn-sm" >등록</button></a>
					
						<input class="btn btn-primary btn-sm" type="button" id="del" value="삭제" onclick="deleteReport()">
                    </div>
                   
                    
                          <div class="row">
					   <div class="container ">
					   	<div class="st-pagination">
							<ul class="pagination justify-content-center">
								<li class="page-item previous ${page.prev ? '' : 'disabled'}" id="dataTable_previous">
									<a class="page-link bg-dark text-white" href="salesInquiry?pageNum=${page.startPage-1}&amount=${page.cri.amount}">&lt;</a>
								</li>
								
								<c:forEach begin="${page.startPage }" end="${page.endPage }" var="p" >
								   <li class="page-item ${p == page.cri.pageNum ? 'active' : ''}">
								   	<a class="page-link" href="salesInquiry?pageNum=${p}&amount=${page.cri.amount}&type=${page.cri.type}&keyword=${page.cri.keyword}">${p}</a>
								   </li>
								</c:forEach>
								
								<li class="page-item ${p == page.cri.pageNum ? 'active' : '' }" id="dataTable_next">
									<a class="page-link bg-dark text-white" href="salesInquiry?pageNum=${page.endPage+1}&amount=${page.cri.amount}">&gt;</a>
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
  	 console.log( $("#sel option:selected").val());
   
    
    var year = '${year}';
    
    $(function () {
    	$.getJSON("/AdminServe/salesInquiry/" +"2021.json")
        .done(function(data) {
        	console.log(data);
        	
        	var ctx = $("#ctx").get(0).getContext('2d');
        	var labels = data.map(obj => obj.MONTH+"월");
        	var datas = data.map(obj => obj.SALES);
        	console.log(labels);
        	console.log(datas);
        	var bgColor = [
        		'rgba(255, 99, 132, 0.2)',
                'rgba(54, 162, 235, 0.2)',
                'rgba(255, 206, 86, 0.2)',
                'rgba(75, 192, 192, 0.2)',
                'rgba(153, 102, 255, 0.2)',
                'rgba(255, 159, 64, 0.2)'];
        	var borderColor = [
        		 'rgba(255, 99, 132, 1)',
                 'rgba(54, 162, 235, 1)',
                 'rgba(255, 206, 86, 1)',
                 'rgba(75, 192, 192, 1)',
                 'rgba(153, 102, 255, 1)',
                 'rgba(255, 159, 64, 1)'];
  
        
        
       
        const myChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: labels,
                datasets: [{
                    label: '2021',
                    data: datas,
                    backgroundColor: [bgColor],
                    borderColor: [borderColor],
                    borderWidth: 1
                }]
            },
            options: {
            	maintainAspectRatio: true,
                scales: {
                	yAxes:[{
                		ticks:{
                			beginAtZero:true
                			}	
	                	}]
	                }
	            }
	        });
	    })
	})
	    
    
    
  
    
    
    
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
	        alert("선택된 매출이 없습니다.");
	    }
	 	else{
            $.ajax({
                type: "POST",
                url: "salesDelete",
                data: "sno=" + arr,
                beforeSend: function(xhr){
        			xhr.setRequestHeader(header, token);	
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
