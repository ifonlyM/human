<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core"  prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<!DOCTYPE html>
<html lang="ko">

<head>
	<meta name="_csrf" content="${_csrf.token}">
   	<meta name="_csrf_header" content="${_csrf.headerName}">	
    <jsp:include page="../includes/head.jsp" />
<style>
	.header{background: #222}
	.list table {width: 70%; margin: 40px auto; border-collapse: collapse;'}
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
<form role="form" action="/board/register" method="post" name="frm">
	<table class="table">
		<thead>
			<tr>
				<td>
				<div class="form-group">
					<label for="bno" class="text-dark font-weight-bold">글번호</label>
					<input type="text" class="form-control" id="bno" name="bno" disabled value="${board.bno }">
				</div>
				</td>
			</tr>	
			<tr>
				<td>
				<div class="form-group">
					<label for="writer" class="text-dark font-weight-bold">작성자</label>
					<input type="text" class="form-control" id="writer" name="writer" value="${board.writer }" disabled>
				</div>
				</td>
			</tr>
			<tr>	
				<td>
				<div class="form-group">
					<label for="title" class="text-dark font-weight-bold">제목</label>
					<input type="text" class="form-control" id="title" name="title" disabled value="${board.title }">
				</div>
				<h6 class="m-0 font-weight-bold text-primary">첨부파일</h6>
				<div class="card-body">
					<div class="uploadResult">
						<ul class="list-group"></ul>
					</div>	
				</div>
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
				<div class="form-group">
					<label for="content" class="text-dark font-weight-bold">내용 : </label>
					<c:out value="${board.content }" escapeXml="false"></c:out> 
				</div>
				</td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td>
					<a href="notice_list${cri.params}" class="btn btn-sm bg-dark text-white float-right mr-3">목록</a>
					<c:choose>
					<c:when test="${category == 1 || category ==  4}">
					<sec:authorize url="/board/get?category=1" access="hasAnyRole('ROLE_ADMIN')">
					<a href="modify${cri.params}&bno=${board.bno }&category=${category}" class="btn btn-default btn-sm  float-right mr-3">글수정</a>
					</sec:authorize>
					</c:when>
					<c:when test="${category == 2 || category ==  3 || category == 5}">
					<a href="modify${cri.params}&bno=${board.bno }&category=${category}" class="btn btn-default btn-sm  float-right mr-3">글수정</a>
					</c:when>
					</c:choose>
					
				</td>
			</tr>       
		</tfoot>
	</table>
</form>	
<table>
<tr>
	<td>
		<div class="card shadow mb-4">
            <div class="card-header py-3 clearfix">
                <h6 class="m-0 font-weight-bold text-primary float-left"><i class="fa fa-comments"></i> 댓글</h6>
                <sec:authorize access="hasAnyRole('ROLE_MEMBER', 'ROLE_ADMIN', 'ROLE_USER')"> 
                	<button class="btn btn-primary float-right btn-sm" id="btnRegFrm">댓글 작성</button>
                </sec:authorize> 
            </div>
            <ul id="replyUL" class="list-group list-group-flush">
            </ul>
            <div class="card-footer text-center">
            	<button class="btn btn-primary btn-block" id="btnShowMore">더보기</button> 
            </div>
        </div>
	</td>
</tr>
</table>
</main>
<%-- <script src="${pageContext.request.contextPath}/resources/js/reply.js"></script> --%>
<script>
console.log("reply module");

var replyService = (function() { 
	var header = $("meta[name='_csrf_header']").attr("content");
	var token = $("meta[name='_csrf']").attr("content");
    function add(reply, callback, error) {
        console.log("reoly.add()");

        $.ajax({
            type : "post",
            url : "/replies/new",
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
            success : function(data) {
                if(callback)
                callback(data)
            },
            error : function(xhr, stat, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    function getList(param, callback, error) {
        console.log("reply.getList()");
        var bno = param.bno; // 고정값
        var amount = param.amount || 10;
        var lastRno = param.lastRno || 0;
     	//var lastRno = 0;
        var url = '/replies/' + bno + "/" + amount + "/" + lastRno;

        $.getJSON(url, function(data) {
        	console.log(lastRno);
            if(callback)
            callback(data)
        });
    }

    function remove(rno, callback, error) {
        console.log("reply.remove()");
        var url = '/replies/' + rno;

        $.ajax(url, {
            type : "delete",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
        }).done(function(data) {
                if(callback)
                callback(data)
        })      
    }

    function modify(reply, callback, error) {
        console.log("reply.modify()");
        var url = '/replies/' + reply.rno;

        $.ajax(url, {
            type : "put",
            data : JSON.stringify(reply),
            contentType : "application/json; charset=utf-8",
            beforeSend: function(xhr){
                xhr.setRequestHeader(header, token);   
             },
            success : function(data) {
                if(callback)
                callback(data)
            }  
        })
    }

    function get(rno, callback, error) {
        console.log("reply.get()");
        var url = '/replies/' + rno;
        $.getJSON(url, function(data) {
            if(callback)
            callback(data)
        });
        $.ajax(url, {
            type : "get",
            contentType : "application/json; charset=utf-8",
            success : function(data) {
                if(callback)
                callback(data)
            },
            error : function(data) {
            	console.log("failed ajax get");
            }
        })
    }
    
    function displayTime(timeValue) {
        return moment().diff(moment(timeValue), 'days') < 1 ? moment(timeValue).format('HH:mm:SS') : moment(timeValue).format('YY/MM/DD') ;
    }

	

    return {
        name:"aaaa", 
        add:add,
        getList:getList,
        remove:remove,
        modify:modify,
        get:get,
        displayTime:displayTime        
    } 
})();

</script>
<script>
var header = $("meta[name='_csrf_header']").attr("content");
var token = $("meta[name='_csrf']").attr("content");
	function showImage(fileCallPath) {
		$("#pictureModal")
		.find("img").attr("src", "/display?fileName=" +fileCallPath)
		.end().modal("show");
	}
    $(function() {
        console.log(replyService);

        var bno = '${board.bno}';
        var $ul = $("#replyUL");

        showList();
        function showList(lastRno, amount) {
            replyService.getList({bno:bno, lastRno:lastRno, amount:amount}, 
                function(data) {
                    if(!data) {
                        return;
                }

                if(data.length == 0) {
                    $("#btnShowMore").text("댓글이 없습니다.").prop("disabled", true)
                    return;
                }

                var str = "";
                for(var i in data){
                    str += '<li class="list-group-item" data-rno="' + data[i].rno + '">'
                    str += '    <div class="clearfix">'
                    str += '        <div class="float-left text-dark font-weight-bold">'+data[i].replyer+'</div>'
                    str += '        <div class="float-right">'+replyService.displayTime(data[i].replyDate)+'</div>'
                    str += '    </div>'
                    str += '    <div>'+data[i].reply+'</div>'
                    str += '</li> '
                }
                $("#btnShowMore").text("더보기").prop("disabled", false);
                $ul.append(str);
            })
        }
        // reply.js

        // ****************************** reply frm add ********************************
        $("#btnRegFrm").click(function() {
            $("#myModal").find("input").val("");
            $("#myModal").find("#replyer").val("<sec:authentication property="principal.username"/>");
            $("#replyDate").closest("div").hide();
            $(".btns button").hide();
            $("#btnReg").show();
            $("#myModal").modal("show");
        })
        // ****************************** add ********************************
        $("#btnReg").click(function() {
            var reply = {reply:$("#reply").val(), replyer:$("#replyer").val(), bno:bno};
            replyService.add(reply,
                function(data) { 
                    alert(data)
                    var count = $ul.find("li").length;
                    $ul.html("");
                    $("#myModal").find("input").val("");
                    $("#myModal").modal("hide");
                    showList(0, count + 1);
            	
            });
        	
        })
        // ****************************** get ********************************
        $ul.on("click", "li", function() {
            // alert($(this).data("rno"));
            var rno = $(this).data("rno");
            replyService.get(rno, function(data) {
                $("#reply").val(data.reply);
                $("#replyer").val("<sec:authentication property="principal.username"/>");
                $("#replyDate").val(replyService.displayTime(data.replyDate)).prop("readonly", true).closest("div").show();
                $(".btns button").hide();
                $("#btnMod, #btnRmv").show();
                $("#myModal").data("rno", data.rno).modal("show");
            });
        })
        // ****************************** modify ********************************
        $("#btnMod").click(function() {
            var reply = {reply:$("#reply").val(), rno:$("#myModal").data("rno"), replyer:$("#replyer").val()};
            replyService.modify(reply, function(data) {
                alert(data)
                $("#myModal").modal("hide");
                // showList();
                $ul.find("li").each(function() {
                    if($(this).data("rno") == reply.rno) {
                        $(this).children().eq(0).find("div").first().text(reply.replyer);
                        $(this).children().eq(1).text(reply.reply);
                    }
                })
            });
        })

        // ****************************** remove ********************************
        $("#btnRmv").click(function() {
            var rno = $("#myModal").data("rno");
            replyService.remove(rno, function(data) {
                alert(data)
                $("#myModal").modal("hide");
                // showList();
                $ul.find("li").each(function() {
                    if($(this).data("rno") == rno) {
                        $(this).remove();
                    }
                })

            });
        })

        // ****************************** 더보기 ********************************
        $("#btnShowMore").click(function() {
            var lastRno = $ul.find("li:last").data("rno");
            // alert(lastRno);
            showList(lastRno);
        })

        
        // 첨부파일 불러오기
        $.getJSON("/board/getAttachs/"+bno).done(function(data) {
			console.log(data);
			showUploadedFile(data);
		})
    }); // end of ready
    function showImage(fileCallPath) {
		$("#pictureModal")
		.find("img").attr("src", "/display?fileName=" +fileCallPath)
		.end().modal("show");
	}
    function showUploadedFile(resultArr) {
		var str = "";
		for(var i in resultArr) {
			str += "<li class='list-group-item' "  
			str += "data-uuid='" + resultArr[i].uuid + "' ";
			str += "data-path='" + resultArr[i].path + "' ";
			str += "data-origin='" + resultArr[i].origin + "' ";
			str += "data-size='" + resultArr[i].size + "' "
			str += "data-image='" + resultArr[i].image + "' "
			str += "data-mime='" + resultArr[i].mime + "' "
			str += "data-ext='" + resultArr[i].ext + "' "
			str += ">"
			if(resultArr[i].image) {
				str += "<a href= 'javascript:showImage(\""+ resultArr[i].fullPath +"\")'>"
				str += "<img src='/display?fileName=" + resultArr[i].thumb + "'>";
				str += "</a>"
				str += "<a href='/download?fileName=" + resultArr[i].fullPath + "'>"; 
				str += " <i class='fa fa-floppy-o'></i> " + resultArr[i].origin + "</a>";  
			} else {
				str += "<a href='/download?fileName=" + resultArr[i].fullPath + "'>"; 
				str += "<i class='fa fa-floppy-o'></i> " + resultArr[i].origin + "</a>";  
			}
			str += "</li>";
		}
		$(".uploadResult ul").append(str);
	}
</script>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" > 
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">댓글</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="form-group">
                        <label for="reply" class="text-dark font-weight-bold">댓글</label>
                        <input class="form-control" id="reply" name="reply" placeholder="댓글 내용을 입력해주세요."> 
                        <%-- <input type="text" class="form-control" id="replyer" name="replyer"  value="<sec:authentication property="principal.username"/>"> --%>
                        <%-- <input type="text" class="form-control" id="writer" name="writer" value="<sec:authentication property="principal.username"/>"> --%>
                    </div>
                    <div class="form-group">
                        <label for="replyer" class="text-dark font-weight-bold">작성자</label>
                        <input type="text" class="form-control" id="replyer" name="replyer"  placeholder="작성자를 입력해주세요.">
                    </div>
                    <div class="form-group">
                        <label for="replyDate" class="text-dark font-weight-bold">Reply Date</label>
                        <input class="form-control" id="replyDate" name="replyDate" placeholder="">
                    </div>
                </div>
                <div class="modal-footer text-right">
                    <div class="btns">
                        <button class="btn btn-primary" id="btnReg">댓글작성</button>
                        <button class="btn btn-warning" id="btnMod">수정</button>
                        <button class="btn btn-danger" id="btnRmv">삭제</button>
                    </div>
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">close</button>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="pictureModal" >
        <div class="modal-dialog modal-xl" >
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Image Detail</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                	<img class="mw-100" src="" >
                </div>
            </div>
        </div>
    </div>
   <script type="text/javascript">

   
   </script>
<jsp:include page="../includes/footer.jsp" />
    <a href="#0" class="cd-top" title="Go to top">Top</a>
<jsp:include page="../includes/foot.jsp" />
</body>
</html>
