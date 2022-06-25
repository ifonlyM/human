<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<div class="header">

            <!-- navigation -->
            <div class="container">
                <div class="row">
                    <div class="col-md-3 col-sm-6 col-xs-6">
                        <div class="logo">
                            <a href="../common/index"><img src="${pageContext.request.contextPath }/resources/images/logo.png" alt=""></a>
                        </div>
                    </div>
                    <div class="col-md-9 col-sm-12">
                        <div class="navigation pull-right" id="navigation">
                            <ul>
                                <li class="active"><a href="../common/index" title="Home" class="animsition-link">Home</a></li>
                                <li><a href="${pageContext.request.contextPath}/board/notice_list" title="notice" class="animsition-link">공지사항</a> </li>
                                <li><a href="${pageContext.request.contextPath}/board/free_list" title="board" class="animsition-link">자유게시판</a>
                                    <ul>
                                        <li><a href="../board/gallery_list" title="Blog Single" class="animsition-link">갤러리</a></li>
                                    </ul>
                                </li>
                                <li><a href="#" title="Features" class="animsition-link">PT예약</a>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/PTreserve/trainers" title="trainers" class="animsition-link">트레이너 선택</a></li>
                                        <li><a href="${pageContext.request.contextPath}/PTreserve/memberPTCalendar" title="PTcalendar" class="animsition-link">PT 예약확인</a></li>
                                    </ul>
                                </li>
                                <li><a href="../board/video_list" title="Classes" class="animsition-link">운동프로그램</a>
                                    <ul>
                                        <li><a href="../board/video_list" title="Classes List">운동영상</a></li>
                                        <li><a href="../board/record_list" title="Classes Detail">운동기록 공유</a></li>
                                    </ul>
                                </li>
                                
                                
                                <sec:authorize access="isAnonymous()">
                                	<li><a href="${pageContext.request.contextPath }/common/login" title="login" class="animsition-link">로그인</a></li>
                                
                                </sec:authorize>
                                
                                <sec:authorize access="isAuthenticated()">
                                <li><a href="#" title="login" class="animsition-link">마이페이지</a>
	                                <ul>
										<li><a href="${pageContext.request.contextPath }/common/memberModify" title="회원정보 수정" class="animsition-link">회원정보 수정</a></li>
	                                	<li><a href="../common/logout" title="로그아웃" class="animsition-link">로그아웃</a></li>
	                                </ul>
                                </li>
                                </sec:authorize>
                                <sec:authorize access="hasAnyRole('ROLE_TRAINER ,ROLE_ADMIN')">
                                 <li><a href="#" title="Classes" class="animsition-link">관리자</a>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath }/AdminServe/memberInquiry" title="Classes List">회원관리</a></li>
                                        <li><a href="${pageContext.request.contextPath }/AdminServe/salesInquiry" title="Classes Detail">매출관리</a></li>
                                        <li><a href="${pageContext.request.contextPath }/AdminServe/blackList" title="Classes Detail">블랙리스트</a></li>
                                        <li><a href="${pageContext.request.contextPath }/AdminServe/boardList" title="Classes Detail">게시글관리</a></li>
                                        <li><a href="${pageContext.request.contextPath }/PTreserve/careerWrite" title="Classes Detail">트레이너경력관리</a></li>
                                    </ul>
                                </li>
                                </sec:authorize>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>