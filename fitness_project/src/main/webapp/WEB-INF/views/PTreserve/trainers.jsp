<%@page import="co.kr.humankdh.domain.MemberVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<html lang="ko">
<head>
	<sec:csrfMetaTags/>
	<jsp:include page="../includes/head.jsp"/>
	<style>
		.page-header {
        	background: url("${pageContext.request.contextPath }/resources/images/pt_headerBack.png") no-repeat center;
        	background-size: cover;
        	margin:0;
        	min-height: 450px;
        }
        
        body .page-caption {
        	margin-top: 150px;
        	margin-bottom: 0;
        	background-color: #262626;
        }
        
        body > h1 {
        	margin-top: 50px;
        	margin-bottom: 100px;
        }
        
        .card-section{
        	margin: 50px 0;
        	padding: 40px 0;
        }
        
        .trainers-card{ 
        	display: flex;
        }
        
        .trainers-photo {
        	width: 437px;
        	margin: 0;
        	overflow: hidden;
        	border-radius: 5px;
        }
        
        .trainers-photo > img {
        	display: inline-block;
        	margin-right: 50px;
        	width: 100%;
        	height: 100%;
        	object-fit: cover;
        }
        
        .trainers-explain-odd {
        	display: inline-block;
        	vertical-align: middle;
        	padding: 10px;
        	margin: 0 25px;
        	color: white;
        }
        
        .trainers-explain-even {
        	display: inline-block;
        	vertical-align: middle;
        	padding: 10px;
        	margin: 0 25px;
        	color: black;
        }
        
        .awards-career{
        	margin: 50px 0 25px;
        	
        }
        .trainers-career {
        	list-style: none;
        	padding:0;
        	margin: 10px 0;
         	min-height: 55%;
        }
        
        .trainers-career .career-p {
        	display: inline-block;
        	margin-bottom: 5px;
        	font-size: 12px;
        	position: relative;
        	top: -10px;
        }
        
        .trainers-comments {
        	margin: 50px 0 0;
        }
        
        .trainers-choice {
        	display: inline-block;
        	margin: auto;
        }
        
	</style>
</head>
<body>
    <div class="page-header">
        <jsp:include page="../includes/header.jsp"/>
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
                    <div class="page-caption pinside40">
                        <h1 class="page-title">???????????? ??????</h1>
                        <p>?????? GYM??? ??????????????? ??????????????? ?????????!</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <h1 class="text-center">???????????? ??????</h1>
    <div id="trainers-section"></div>
    <jsp:include page="../includes/footer.jsp"/>
    <!-- back to top icon -->
    <a href="#0" class="cd-top" title="Go to top">Top</a>
    <jsp:include page="../includes/foot.jsp"/>
    <script>
	var contextPath = "${pageContext.request.contextPath}";
    var csrfHeader = $("meta[name='_csrf_header']").attr("content");
    var csrfParameter = $("meta[name='_csrf_parameter']").attr("content");
	var csrfToken = $("meta[name='_csrf']").attr("content");
	
	if(csrfHeader && csrfToken){
		$(document).ajaxSend(function(e, xhr) {
			xhr.setRequestHeader(csrfHeader, csrfToken);
		});
	}
	
    $(function() {
		// ?????????????????? ???????????? ???????????? ????????? ==========================================================
    	var url = contextPath + "/PTreserve/getTrainers";
    	$.ajax( url, {
    		type: "POST",
    		dataType : "JSON",
    		success : function(careers) {
    			var cnt = 1;
    			for(var trainer in careers) {
    				var t = JSON.parse(trainer);
    				
    				if(cnt % 2 === 1 ){
	    				oddTrainerCard(t, careers[trainer]);
    				}
    				else {
    					evenTrainerCard(t, careers[trainer]);
    				}
					cnt++;
    			}
    		}
    	});
    	
		// Odd trainer card DOM
		function oddTrainerCard(trainer, careers) {
		   var str = "";
		   str += '<div class="space-medium section-color card-section">';
		   str += '<div class="container">';
		   str += '<div class="trainers-card">';
		   str += '<div class="trainers-photo">';
		   str += '<img src="${pageContext.request.contextPath }/resources/images/'+ trainer.userName +'.jpg">';
		   str += '</div>';
		   str += '<div class="trainers-explain-odd">';
		   str += '<h2 class="trainers-name text-white">'+ trainer.userName +' ????????????</h2>';
		   str += '<h4 class="text-white awards-career"> Awards & Career</h4>';
		   str += '<ul class="trainers-career">';
		   for(var i in careers) {
			   if(!careers[i].careerName) continue;
			   if(careers[i].startDate && careers[i].endDate){
				   str += '<li>' + careers[i].careerName + '</li>' + '<p class="career-p">' + careers[i].startDate + ' ~ ' + careers[i].endDate + '</p>';
			   }
			   else {
				   str += '<li style="margin-bottom: 10px">' + careers[i].careerName + '</li>';
			   }
		   }
		   str += '</ul>';
		   str += '<div class="trainers-comments">';
		   str += '<h5 class="text-white">Comments</h5>';
		   
		   // ?????? ????????? ???????????? ???????????? ????????? ???????????? ????????? '???????????? ????????????!' ??????.
		   var comment = "";
		   for(var i in careers) {
			   if(careers[i].comments)	{
				   comment = careers[i].comments;
			   }
		   }
		   if(comment){
			   str += '<p>' + comment +'</p>';
		   }
		   else {
			   str += '<p>???????????? ????????????!</p>';
		   }
		   
		   str += '</div>';
		   str += '</div>';
		   str += '<div class="trainers-choice">';
		   str += '<form method="post" action="'+contextPath+'/PTreserve/PTReserveCalendar">';
		   str += '<input type="hidden" name="trainerName" value="'+ trainer.userName +'"/>';
		   str += '<input type="hidden" name="trainerId" value="'+ trainer.userid +'"/>';
		   str += '<button type="submit" class="btn btn-default btn-reserve">PT ????????????</button>';
		   str += '<input type="hidden" name="'+csrfParameter+'" value="'+ csrfToken+'"/>';
		   str += '</form>';
		   str += '</div>';
		   str += '</div><!--  END of trainers-card -->';
		   str += '</div>';
		   str += '</div> <!-- END of card-section  -->';
		   $("#trainers-section").append(str);
		} // END of odd TrainerCard
		
		// Even tariner Card DOM
		function evenTrainerCard(trainer, careers) {
		   var str = "";
		   str += '<div class="space-medium even-section-color card-section">';
		   str += '<div class="container">';
		   str += '<div class="trainers-card">';
		   str += '<div class="trainers-choice">';
		   str += '<form method="post" action="'+contextPath+'/PTreserve/PTReserveCalendar">';
		   str += '<input type="hidden" name="trainerName" value="'+ trainer.userName +'"/>';
		   str += '<input type="hidden" name="trainerId" value="'+ trainer.userid +'"/>';
		   str += '<button type="submit" class="btn btn-default btn-reserve">PT ????????????</button>';
		   str += '<input type="hidden" name="'+csrfParameter+'" value="'+ csrfToken+'"/>';
		   str += '</form>';
		   str += '</div>';
		   str += '<div class="trainers-explain-even">';
		   str += '<h2 class="trainers-name text-black">'+ trainer.userName +' ????????????</h2>';
		   str += '<h4 class="text-balck awards-career"> Awards & Career</h4>';
		   str += '<ul class="trainers-career">';
		   for(var i in careers) {
			   if(!careers[i].careerName) continue;
			   if(careers[i].startDate && careers[i].endDate){
				   str += '<li>' + careers[i].careerName + '</li>' + '<p class="career-p">' + careers[i].startDate + ' ~ ' + careers[i].endDate + '</p>';
			   }
			   else {
				   str += '<li style="margin-bottom: 10px">' + careers[i].careerName + '</li>';
			   }
		   }
		   str += '</ul>';
		   str += '<div class="trainers-comments">';
		   str += '<h5 class="text-black">Comments</h5>';
		   
		   // ?????? ????????? ???????????? ???????????? ????????? ???????????? ????????? '???????????? ????????????!' ??????.
		   var comment = "";
		   for(var i in careers) {
			   if(careers[i].comments)	{
				   comment = careers[i].comments;
			   }
		   }
		   if(comment){
			   str += '<p>' + comment +'</p>';
		   }
		   else {
			   str += '<p>???????????? ????????????!</p>';
		   }
		   
		   str += '</div>';
		   str += '</div>';
		   str += '<div class="trainers-photo">';
		   str += '<img src="${pageContext.request.contextPath }/resources/images/'+ trainer.userName +'.jpg">';
		   str += '</div>';
		   str += '</div><!--  END of trainers-card -->';
		   str += '</div>';
		   str += '</div> <!-- END of card-section  -->';
		   $("#trainers-section").append(str);
		} // END of even TrainerCard
		
		$("body").on("click", ".btn-reserve", function() {
			console.log($(this).data("trainer"));
			// ?????? ??????????????? ?????? ???????????? ??????
			//location.href = contextPath + "/PTreserve/calendar?trainerName=" + $(this).data("trainer");
		});
    	
    }); // END of Ready
    </script>
</body>
</html>
