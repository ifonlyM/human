<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
   <jsp:include page="../includes/head.jsp" />
   <sec:csrfMetaTags/>
   
</head>

<body >
    
 <jsp:include page="../includes/header.jsp" />
    <div class="content">
        <!-- main-container -->
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
	                <div style="text-align: center;">
	                	<h1>매출수정</h1>
	                </div>
                   	
                   <div >
                    <form method="post" name="frm">
                    <table class="table table-hover table-bordered">
                    	
                        <tbody>
                      
                            <tr>
                                <td colspan="2">아이디</td>
                                <td colspan="12"><input type="text" placeholder="아이디를 입력하세요." id="id" name="id" readonly value="${sales.id} "></td>
                               
                            </tr>
                       
                            <tr>
                                <td colspan="2">이름</td>
                                <td><input type="text" placeholder="이름을 입력하세요." id="name" name="name" value="${sales.name}"></td>
                            </tr>
                            <tr>
                                <td>금액</td>
                                <td colspan="12"><input type="text" placeholder="금액을 입력하세요." id="cost" name="cost" value="${sales.cost}"> 원</td>
                            </tr>
                           
                            <tr>
                                <td>구매일자</td>
                                <td colspan="12"><input type="date" id="buydate" name="buydate" placeholder="구매일자를 입력하세요." ></td>
                                
                            </tr>
                            <tr>
                                <td>담당트레이너</td>
                                <td colspan="12"><input type="text" id="trainer" name="trainer" placeholder="담당트레이너를 입력하세요." value="${sales.trainer}"></td>
                                
                            </tr>
                            <tr>
                                <td>구매내용</td>
                                <td colspan="8">
                                <input type="hidden" value="${sales.buycontent}" id="buyvar">
                                 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="buycontent"  name="buycontent" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option value="회원권">회원권</option>
                                            <option value="PT">PT</option>
                                          </select>
                                        </div>
                                </td>
                            </tr>
                            <tr>
                                <td>결제방법</td>
                                <td colspan="8">
                                 <input type="hidden" value="${sales.payment}" id="payvar">
                                 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="payment" name="payment" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option value="현금">현금</option>
                                            <option value="카드">카드</option>
                                          </select>
                                        </div>
                                </td>
                            </tr>
                           
                          
                            
                        </tbody>
                    </table>
                    <input type="hidden" name="pageNum" value="${cri.pageNum }">
                                <input type="hidden" name="amount" value="${cri.amount}">
                                <input type="hidden" name="type" value="${cri.type}">
                                <input type="hidden" name="keyword" value="${cri.keyword}">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />

                    <div style="text-align: right;">
                        <button class="btn btn-default btn-sm"  >수정</button>
                       <a  class="btn btn-primary btn-sm" href="${pageContext.request.contextPath }/AdminServe/salesInquiry">취소</a>
                    </div>
                   </form>
                    
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
     frm.onsubmit= function () {
     	event.preventDefault();
     	
     	if(!frm.id.value){
     		alert("회원아이디를 입력하세요");
 			frm.id.focus();
        	}else if(!frm.name.value){
        		alert("회원이름을 입력하세요");
 			frm.name.focus();
        	}else if(!frm.cost.value){
 			alert("비용을 입력하세요");
 			frm.cost.focus();
 		}else if(!frm.buydate.value){
 			alert("구매일자를 입력하세요");
 			frm.buydate.focus();
 		}else if(!frm.trainer.value){
 			alert("담당트레이너를 입력하세요");
 			frm.trainer.focus();
 		}else {
 			frm.submit();
 		}
     }
     
     

     $('#payment').val($("#payvar").val()).prop("selected",true);
     $('#buycontent').val($("#buyvar").val()).prop("selected",true);
     
    </script>
    
</body>

</html>
