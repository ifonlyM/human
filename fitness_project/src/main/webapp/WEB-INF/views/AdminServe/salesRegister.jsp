<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
   <jsp:include page="../includes/head.jsp" />
   <meta name="_csrf" content="${_csrf.token}">
	<meta name="_csrf_header" content="${_csrf.headerName}">
</head>

<body >
    
   <jsp:include page="../includes/header.jsp" />
    <div class="content">
        <!-- main-container -->
        <div class="container">
            <div class="row">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                   <div>
                   	<h1 align="center">매출등록</h1>
                   	
                   	
                    <form method="post" name="frm">
                    <table class="table table-hover table-bordered">
                    	
                        <tbody>
                      
                            <tr>
                                <td colspan="2">아이디</td>
                                <td colspan="12"><input type="text" placeholder="아이디를 입력하세요." id="id" name="id"></td>
                               
                            </tr>
                       
                            <tr>
                                <td colspan="2">이름</td>
                                <td><input type="text" placeholder="이름을 입력하세요." id="name" name="name"></td>
                            </tr>
                            <tr>
                                <td>금액</td>
                                <td colspan="12"><input type="text" placeholder="금액을 입력하세요." id="cost" name="cost"> 원</td>
                            </tr>
                           
                            <tr>
                                <td>구매일자</td>
                                <td colspan="12"><input type="date" id="buydate" name="buydate" placeholder="구매일자를 입력하세요."></td>
                                
                            </tr>
                            <tr>
                                <td>담당트레이너</td>
                                <td colspan="12"><input type="text" id="trainer" name="trainer" placeholder="담당트레이너를 입력하세요."></td>
                                
                            </tr>
                            <tr>
                                <td>구매내용</td>
                                <td colspan="8">
                                 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="buycontent" name="buycontent" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option>회원권</option>
                                            <option>PT</option>
                                          </select>
                                        </div>
                                </td>
                            </tr>
                            <tr>
                                <td>결제방법</td>
                                <td colspan="8">
                                 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="payment" name="payment" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option>현금</option>
                                            <option>카드</option>
                                          </select>
                                        </div>
                                </td>
                            </tr>
                           
                          
                            
                        </tbody>
                    </table>
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div style="text-align: right;">
                        <button class="btn btn-default btn-sm" type="submit" >등록</button>
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
 			alert("금액을 입력하세요");
 			frm.cost.focus();
 		}else if(!frm.buydate.value){
 			alert("구매일자를 입력하세요");
 			frm.buydate.focus();
 		}else if(!frm.trainer.value){
 			alert("담당트레이너를 입력하세요");
 			frm.trainer.focus();
 		}else if(!frm.buycontent.value){
 			alert("구매내용을 입력하세요");
 			frm.buycontent.focus();
 		}else if(!frm.payment.value){
 			alert("결제방법을 입력하세요");
 			frm.payment.focus();
 		}else {
 			frm.submit();
 		}
     }
     
  // ajax 통신을 위한 csrf 설정
     var token = $("meta[name='_csrf']").attr("content");
     var header = $("meta[name='_csrf_header']").attr("content");
     $(document).ajaxSend(function(e, xhr, options) {
         xhr.setRequestHeader(header, token);
     });
	   /*  $("form").submit(function(){
	    	event.preventDefault()
	    	console.log(
	    			$("#id").val(), 
	    			$("#name").val(),
	    			$("#cost").val(),
	    			$("#buydate").val(),
	    			$("#trainer").val(),
	    			$("#buycontent").val(),
	    			$("#payment").val(),
	    			)
	    }) */
    </script>
    
    <!-- 
    <script>
    function initMap() {
        var myLatLng = {
            lat: 23.0225,
            lng: 72.5714
        };

        var map = new google.maps.Map(document.getElementById('googleMap'), {
            zoom: 8,
            center: myLatLng,
            scrollwheel: false,

        });
        var image = 'images/map-pin.png';
        var marker = new google.maps.Marker({
            position: myLatLng,
            map: map,
            icon: image,
            title: 'Hello World!'

        });
    }
    </script>
    <script src="https://maps.googleapis.com/maps/api/js?&callback=initMap" async defer></script> -->
</body>

</html>
