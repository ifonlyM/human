<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<sec:csrfMetaTags/>
<jsp:include page="../includes/head.jsp" />
</head>
<script type="text/javascript"></script>
<body>
    
    <div class="page-header">
         <jsp:include page="../includes/header.jsp" />
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">회원정보 수정</h1>
                        <p>수정드가자</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="content">
        <!-- main-container -->
        <div class="container">
            <div class="row">
            
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" >
                <div style="text-align: center;">
            		<h1 class="mb30">회원정보 수정</h1>
            	</div>
                		
                
                    <form method="post">
                    
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <td colspan="2">아이디</td>
                                <td><input type="text" readonly="readonly" value="${member.userid}" ></td>
                                <td colspan="2">회원등급</td>
                                <td colspan="8">
                                	<input type="text" readonly="readonly" value="${member.category}" id="categoryvar"> 
                                 	 <div class="form-group" style="margin: 0; ">
                                          <!-- <select class="form-control" id="category" name="category" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px; readonly">
                                            <option value="1">일반회원</option>
                                            <option value="2">정회원</option>
                                            <option value="3">트레이너</option>
                                            <option value="4">관리자</option>
                                          </select> -->
                                     </div> 
                                </td>
                               
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="2">비밀번호</td>
                                <td><input type="password" name="userpw" id="pwds" ></td>
                                <td colspan="2">성별</td>
                                <td colspan="8">
                                <input type="text" value="${member.gender}" name="gender" readonly="readonly"> 
                                </td>
                              
                               
                            </tr>
                            <tr>
                                <td>이름</td>
                                <td colspan="12"><input type="text" value="${member.userName}" name="userName" readonly="readonly"></td>
                                
                            </tr>
                            <tr>
                                <td>전화번호</td>
                                <td colspan="12"><input type="text" value="${member.phone}" name="phone"></td>
                                
                            </tr>
                            
                            <tr>
                                <td>이메일</td>
                                <td colspan="12"><input type="email" value="${member.email}" name="email" ></td>
                                
                            </tr>
                            <tr>
                                <td>주소</td>
                                <td colspan="12"><textarea type="text"  name="address" style="resize: none;">${member.address}</textarea></td>
                              
                            </tr>
                        <tr>
                                <td>키</td>
                                <td colspan="12"><input type="text" value="${member.height}" name="height"> cm</td>
                                
                            </tr> 
                            <tr>
                                <td>몸무게</td>
                                <td colspan="12"><input type="text" value="${member.weight}" name="weight"> kg</td>
                                
                            </tr> 
                            
                        </tbody>
                    </table>

						<%-- <input type="hidden" name="pageNum" value="${cri.pageNum }">
                                <input type="hidden" name="amount" value="${cri.amount}">
                                <input type="hidden" name="type" value="${cri.type}">
                                <input type="hidden" name="keyword" value="${cri.keyword}"> --%>

                    <div style="text-align: right;">
                      	<sec:csrfInput/>
                        <button class="btn btn-default btn-sm">수정</button>
                        <a class="btn btn-primary btn-sm" href="${pageContext.request.contextPath }/common/index">취소</a>
                    </div>
                   </form>
              
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
    var csrfHeader = $("meta[name='_csrf_header']").attr("content")
    var csrfToken = $("meta[name='_csrf']").attr("content");
    if(csrfHeader && csrfToken){
       $(document).ajaxSend(function(e, xhr) {
          xhr.setRequestHeader(csrfHeader, csrfToken);
       });
    }

    /* var url = "${pageContext.request.contextPath}/common/memberModify";
	$.ajax(url, {
		type : "post",		
		data : JSON,
		contentType : "application/json; charset=utf-8",
		success : function(result) {
			if(result === "success"){
				
				alert("수정성공")
			}
			else {
				 alert("수정실패");
			}
			
		},
		error : function(){
			alert("failed ajax modify");
		}
	}) */
    
    console.log("ajax")
/*     $("#categoryvar").val();
    
    
    $('#category').val($("#categoryvar").val()).prop("selected",true);
    $('#gender').val($("#gendervar").val()).prop("selected",true);
 */    
 
 </script>
</body>

</html>
