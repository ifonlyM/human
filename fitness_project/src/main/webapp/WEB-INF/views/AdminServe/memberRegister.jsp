<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">

<head>
<sec:csrfMetaTags/>
<jsp:include page="../includes/head.jsp" />
</head>

<body>
    
   <jsp:include page="../includes/header.jsp" />
    <div class="content">
        <!-- main-container -->
        <div class="container">
            <div class="row">
            
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12" >
                <div style="text-align: center;">
            		<h1 class="mb30">회원등록</h1>
            	</div>
                		
                
                    <form method="post" name="frm">
                    
                    <table class="table table-hover table-bordered">
                        <thead>
                            <tr>
                                <td colspan="2">아이디</td>
                                <td><input type="text" placeholder="아이디를 입력하세요." name="userid"></td>
                                <td colspan="2">회원등급</td>
                                <td colspan="8">
                                	 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="rating" name="rating" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option value="1">일반회원</option>
                                            <option value="2">정회원</option>
                                            <option value="3">트레이너</option>
                                            <option value="4">관리자</option>
                                          </select>
                                        </div>
                                </td>
                               
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td colspan="2">비밀번호</td>
                                <td><input type="password"  name="userpw" placeholder="비밀번호를 입력하세요."></td>
                                <td colspan="2">성별</td>
                                <td colspan="8">
                               
                                	 <div class="form-group" style="margin: 0;">
                                          <select class="form-control" id="gender" name="gender" style="height: 32px; margin: 0; font-size: 15px; padding: 2px; width: 100px;">
                                            <option value="M">남자</option>
                                            <option value="F">여자</option>
                                          </select>
                                        </div>
                                </td>
                              
                               
                            </tr>
                            <tr>
                                <td>이름</td>
                                <td colspan="12"><input type="text"  name="userName" placeholder="이름을 입력하세요."></td>
                                
                            </tr>
                            <tr>
                                <td>전화번호</td>
                                <td colspan="12"><input type="text" name="phone" placeholder="전화번호를 입력하세요."></td>
                                
                            </tr>
                            
                            <tr>
                                <td>이메일</td>
                                <td colspan="12"><input type="email"  name="email"  placeholder="이메일을 입력하세요."></td>
                                
                            </tr>
                            <tr>
                                <td>주소</td>
                                <td colspan="12"><textarea type="text"  name="address" placeholder="주소를 입력하세요."  style="resize: none;"></textarea></td>
                              
                            </tr>
                        <tr>
                                <td>키</td>
                                <td colspan="12"><input type="text"  name="height" placeholder="키를 입력하세요."> cm</td>
                                
                            </tr> 
                            <tr>
                                <td>몸무게</td>
                                <td colspan="12"><input type="text"  name="weight" placeholder="몸무게를 입력하세요."> kg</td>
                                
                            </tr> 
                            
                        </tbody>
                    </table>

						<input type="hidden" name="pageNum" value="${cri.pageNum }">
                                <input type="hidden" name="amount" value="${cri.amount}">
                                <input type="hidden" name="type" value="${cri.type}">
                                <input type="hidden" name="keyword" value="${cri.keyword}">
 								<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                    <div style="text-align: right;">
                      
                        <button class="btn btn-default btn-sm"  type="submit">등록</button>
                        <a  class="btn btn-primary btn-sm" href="${pageContext.request.contextPath }/AdminServe/memberInquiry">취소</a>
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
    
    
    frm.onsubmit= function () {
    	event.preventDefault();
    	if(!frm.userid.value){
    		alert("회원아이디를 입력하세요");
			frm.userid.focus();
       	}else if(!frm.userpw.value){
       		alert("회원비밀번호를 입력하세요");
			frm.userpw.focus();
       	}else if(!frm.userName.value){
			alert("회원이름을 입력하세요");
			frm.userName.focus();
		}else if(!frm.phone.value){
			alert("회원전화번호를 입력하세요");
			frm.phone.focus();
		}else if(!frm.email.value){
			alert("회원이메일을 입력하세요");
			frm.email.focus();
		}else if(!frm.address.value){
			alert("회원주소를 입력하세요");
			frm.address.focus();
		}else if(!frm.height.value){
			alert("회원키를 입력하세요");
			frm.height.focus();
		}else if(!frm.weight.value){
			alert("회원몸무게를 입력하세요");
			frm.weight.focus();
		}else {
			frm.submit();
		}
    	
		
	}
    var csrfHeader = $("meta[name='_csrf_header']").attr("content")
    var csrfToken = $("meta[name='_csrf']").attr("content");
    if(csrfHeader && csrfToken){
       $(document).ajaxSend(function(e, xhr) {
          xhr.setRequestHeader(csrfHeader, csrfToken);
       });
    }
    
   /*  $("#categoryvar").val();
    
    
    $('#category').val($("#categoryvar").val()).prop("selected",true);
    $('#gender').val($("#gendervar").val()).prop("selected",true); */
    </script>
    
</body>

</html>
