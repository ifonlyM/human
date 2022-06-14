<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"  prefix="sec"%>
<!DOCTYPE html>
<html lang="ko">

<head>
	<sec:csrfMetaTags/>
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
<form role="form" action="/board/modify" method="post" name="frm">
	<table class="table">
		<thead>
			<tr>
				<td>
				<div class="form-group">
					<label for="bno" class="text-dark font-weight-bold">글번호</label>
					<input type="text" class="form-control" id="bno" name="bno" readonly value="${board.bno }">
				</div>
				</td>
			</tr>	
			<tr>	
				<td>	
				<div class="form-group">
					<label for="title" class="text-dark font-weight-bold">제목</label>
					<input type="text" class="form-control" id="title" name="title" value="${board.title }">
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<div class="form-group">
					<label for="title" class="text-dark font-weight-bold">작성자</label>
					<input type="text" class="form-control" id="writer" name="writer" value="${board.writer }"  readonly>
				</div>
				</td>
			</tr>
			<tr>
				<td>
				<label for="title" class="text-dark font-weight-bold">첨부파일</label>
				<div class="form-group uploadDiv">
					<label for="files" class="btn btn-primary px-4"><i class='fa fa-floppy-o mr-2'></i> File</label>                   		
                   	<input type="file" class="form-control d-none" id="files" name="files" multiple>
				</div>
				<div class="uploadResult">
					<ul class="list-group">
					</ul>
				</div>	
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>
				<div class="form-group">
					<label for="content" class="text-dark font-weight-bold">내용 : </label>
					<textarea class="form-control" rows="17"  id="content2" name="content" >${board.content }</textarea>
				</div>
				</td>
			</tr>
			
		</tbody>
		<tfoot>
			<tr>
				<td>
					<input type="hidden" name="pageNum" value="${cri.pageNum }">
	           		<input type="hidden" name="amount" value="${cri.amount}">
	           		<input type="hidden" name="type" value="${cri.type}">
	           		<input type="hidden" name="keyword" value="${cri.keyword}">
	           		<input type="hidden" name="category" value="${param.category}">
	           		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
					<button class="btn btn-sm  bg-danger text-white float-right " formaction="remove" >글삭제</button>
					<a href="notice_list${cri.params}" class="btn btn-sm  bg-dark text-white float-right mr-3">목록</a>
					<button class="btn btn-default btn-sm  float-right mr-3" id="btnSubmit" formaction="modify">글수정</button>
				</td>
			</tr>	
		</tfoot>
	</table>
</form>	
</main>
<jsp:include page="../includes/footer.jsp" />
<script>
var csrfHeader = $("meta[name='_csrf_header']").attr("content")
var csrfToken = $("meta[name='_csrf']").attr("content");
if(csrfHeader && csrfToken){
	$(document).ajaxSend(function(e, xhr) {
		xhr.setRequestHeader(csrfHeader, csrfToken);
	});
}
function showImage(fileCallPath) {
	$("#pictureModal")
	.find("img").attr("src", "/display?fileName=" +fileCallPath)
	.end().modal("show");
}
$(function() {
	var bno = '${board.bno}';
	
	
	var cloneObj = $(".uploadDiv").clone();
	
    var regex = /(.*?)\.(exe|sh|zip|alz)$/;
    var maxSize = 1024 * 1024 * 5;

    function checkExtension (fileName, fileSize) {
        if(fileSize >= maxSize) {
            alert("파일 사이즈 초과");
            return false;
        }
        if(regex.test(fileName)) {
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }
        return true;
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
			} else {
				str += "<a href='/download?fileName=" + resultArr[i].fullPath + "'>"; 
				str += "<i class='fas fa-paperclip'></i> " + resultArr[i].origin + "</a>";  
			}
			str += " <small><i data-file='"+ resultArr[i].fullPath +"' data-image='"+ resultArr[i].image +"'"
			str += "class='fas fa-trash-alt text-danger'></i></small></li>";
		}
		$(".uploadResult ul").append(str);
	}

    $(".uploadDiv").on("change", "#files" , function() {
        var files = $("#files")[0].files
        console.log(files);

        var formData = new FormData();
        for(var i in files) {
            if(!checkExtension(files[i].name, files[i].size)) {
                return false;
            }
            formData.append("files", files[i]);
        }
        $.ajax("/upload", {
            processData:false,
            contentType:false,
            data:formData,
            dataType:'json',
            type:"POST",
            success:function(result) {
                console.log(result);
                $(".uploadDiv").html(cloneObj.html());
                showUploadedFile(result);
            }
        })
    });
    <!-- $("#pictureModal").modal("show"); -->
    
    $(".uploadResult").on("click", "small i", function () {
    	var $li = $(this).closest("li");
    	if(confirm("Remove this file?")) {
    		$li.remove();
    	}
 //  	$.ajax("/deleteFile" , {
  // 		type : "post",
   	//	data : {fileName:$(this).data("file"), image:$(this).data("image")},
   //		success : function (result) {
			//$li.remove();
		//	}
    //	})
	});
		// 글 작성 이벤트
		$("#btnSubmit").click(function () {
    			event.preventDefault();
				if(!frm.title.value) {
					alert("제목을 입력해 주세요.")
					frm.title.focus();
				} else {
				var str = "";
				var datas = ["uuid", "path", "origin", "ext", "mime", "size", "image"];
	    		$(".uploadResult li").each(function(i) {
	    			for(var j in datas)
						str += "<input type='hidden' name='attachs["+i+"]." + datas[j] + "' value='" + $(this).data(datas[j])+ "'>";
				});
	    		$(this).closest("form").append(str).submit();
	    		//console.log($(this).closest("form").append(str).html());
					frm.submit();
				}
    			
		}) 
	
	// 첨부파일 불러오기
        $.getJSON("/board/getAttachs/"+bno).done(function(data) {
			console.log(data);
			showUploadedFile(data);
		})
	// CK editor 적용
	CKEDITOR.replace("content2", {
		 extraAllowedContent: 'h3{clear};h2{line-height};h2 h3{margin-left,margin-top}',

	      // Adding drag and drop image upload.
	      extraPlugins: 'print,format,font,colorbutton,justify,uploadimage',
	      uploadUrl: '${pageContext.request.contextPath }/ckupload.json?command=file&type=Files&responseType=json',

	      // Configure your file manager integration. This example uses CKFinder 3 for PHP.
	  /*     filebrowserBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html',
	      filebrowserImageBrowseUrl: '/apps/ckfinder/3.4.5/ckfinder.html?type=Images', 
	      filebrowserUploadUrl: '/ckupload.json?command=QuickUpload&type=Files', */
	      filebrowserImageUploadUrl: '${pageContext.request.contextPath }/ckupload.json?command=QuickUpload&type=Images',

	      height: 560,

	      removeDialogTabs: 'image:advanced;link:advanced',
	      removeButtons: 'PasteFromWord'
	    		 
	});
})

</script>
    <a href="#0" class="cd-top" title="Go to top">Top</a>
<jsp:include page="../includes/foot.jsp" />
</body>
</html>
