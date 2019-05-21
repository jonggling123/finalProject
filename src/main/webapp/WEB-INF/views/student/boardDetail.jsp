<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<style>
.sangyup {
	display: inline;
	float: right;
}

.dataTables_wrapper .dataTables_filter {
	width: 45%;
}

.dataTables_wrapper .dataTables_filter input, .dataTables_wrapper .dataTables_filter label
	{
	width: 20%;
}
</style>

<!--    메뉴 소개 영역 -->
<c:set var="board"
	value="${(not empty boardList[2] || not empty boardList[1]) ? boardList[1] : boardList[0] }" />
<div class="breadcomb-area">
	<div class="container">
		<div class="row">
			<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
				<div class="breadcomb-list">
					<div class="row">
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-12">
							<div class="breadcomb-wp">
								<div class="breadcomb-ctn">
									<h2>게시판 상세</h2>
									<p>
										<span class="bread-ntd">게시판 상세 페이지</span>
									</p>
									<button type="button" id="goList">목록으로</button>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<form id="goForm" action="${pageContext.request.contextPath }/subjectPage/${board.lecture_code}/lectureBoard"></form>
<form:form modelAttribute="board" id="boardForm">
<div class="container">
	<div class="row">
		<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
			<div class="view-mail-list sm-res-mg-t-30">
				<div class="mail-ads mail-vw-ph">
					<input type="hidden" class="modifyInputs" name="board_no" value="${board.board_no }">
					<c:if test="${user.user_id == board.user_id}">
						<button type="button" id="modifyBtn">수정</button>
						<button type="button" id="removeBtn">삭제</button>
					</c:if>
					<p class="first-ph">
						<b>분류 : ${board.board_type} </b>
					</p>
					<p>
						<b>작성자 : ${board.user_id }</b>
					</p>
					<p>
						<b id="boardTitle">제목 : ${board.board_title}</b>
						<input class="modifyTags modifyInputs" type="text" id="modTitle" name="board_title" value="${board.board_title }" style="display:none;" />
					</p>
					<p class="last-ph">
						<b id="boardDate">Date : ${board.board_date}</b>
					</p>
				</div>
				<div class="file-download-system">
					<div class="dw-st-ic mg-t-20">
						<div id="attachList" class="dw-atc-sn">
							<p>
								<b>첨부파일 : </b>
							</p>
							<c:if test="${not empty board.savedAttachmentList }">
							<c:forEach items="${board.savedAttachmentList}" var="pds"
								varStatus="vs">
								<c:if test="${not empty pds.file_name }">
									<span>
										<a href="${pageContext.request.contextPath }/${board.lecture_code}/download/${pds.attachment_no }"
											title="파일명:${pds.file_size }">${pds.file_name }</a>
										<button type="button" id="del_${pds.attachment_no }" class="deleteBtn modifyTags"
											 style="display:none;">삭제</button>
										&nbsp;&nbsp;
										${not vs.last?"|":"" }
										&nbsp;&nbsp;
									</span>
								</c:if>
							</c:forEach>
							</c:if>
						</div>
					</div>
					<div class="modifyTags" style="display:none;">
						<c:forEach begin="1" end="${board.board_attachmentcount eq 0 ? 5 : 5-board.board_attachmentcount}" step="1">
							<input class="newFiles" type="file" name="bo_files">
						</c:forEach>
					</div>
				</div>
				
				<div id="contentDiv" class="view-mail-atn">${board.board_content }</div>
				
				<div class="vw-ml-action-ls text-left mg-t-20">
					<div class="btn-group ib-btn-gp active-hook nk-email-inbox">
						<button class="btn btn-default btn-sm waves-effect">
							<i class="notika-icon notika-next"></i> 댓글
						</button>
						<!--                                 <button class="btn btn-default btn-sm waves-effect"><i class="notika-icon notika-trash"></i> Remove</button> -->
					</div>
				</div>
				<div class="row">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="form-element-list mg-t-30">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div class="form-group">
										<div class="nk-int-st">
											<textarea id="replyContent" class="form-control" rows="5"
												placeholder="댓글을 작성해주세요."
												style="width: 80%; display: inline;"></textarea>
											<button type="button" class="btn btn-default notika-btn-default"
												id="newReply">댓글등록</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<button type="button" id="confirm" class="modifyTags" style="display:none;">확인</button>
				<button type="button" id="cancel"  class="modifyTags" style="display:none;">취소</button>
				
				<table id="replyTable" class="table table-striped dataTable"
					role="grid" aria-describedby="data-table-basic_info">
					<thead>
						<tr>
							<th>작성자</th>
							<th>내용</th>
							<th>작성일</th>
							<th>삭제</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
				<div class="row">
					<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
						<div class="form-element-list mg-t-30">
							<div class="row">
								<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
									<div>
										<c:if
											test="${not empty boardList[2] || not empty boardList[1] }">
											<c:set var="prev" value="${boardList[0] }"></c:set>
											<span> <img
												src="${pageContext.request.contextPath }/notika/images/sort_asc_disabled.png">
												<a
												href="${pageContext.request.contextPath }/${prev.lecture_code}/board/${prev.board_no}"
												style="margin-left: 3px;">이전글</a> <a
												href="${pageContext.request.contextPath }/${prev.lecture_code}/board/${prev.board_no}"
												style="margin-left: 40px;">${prev.board_title}</a> <span
												style="margin-left: 300px;">${prev.user_id }</span> <span
												style="margin-left: 100px;">${prev.board_date }</span>
											</span>
										</c:if>
									</div>
									<div>
										<c:if
											test="${not empty boardList[2] || not empty boardList[1] }">
											<c:choose>
												<c:when test="${not empty boardList[2] }">
													<c:set var="next" value="${boardList[2] }" />
												</c:when>
												<c:otherwise>
													<c:set var="next" value="${boardList[1] }"></c:set>
												</c:otherwise>
											</c:choose>
											<span> <img
												src="${pageContext.request.contextPath }/notika/images/sort_desc_disabled.png">
												<a
												href="${pageContext.request.contextPath }/${next.lecture_code}/board/${next.board_no}"
												style="margin-left: 3px;">다음글</a> <a
												href="${pageContext.request.contextPath }/${next.lecture_code}/board/${next.board_no}"
												style="margin-left: 40px;">${next.board_title }</a> <span
												style="margin-left: 300px;">${next.user_id }</span> <span
												style="margin-left: 100px;">${next.board_date }</span>
											</span>
										</c:if>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
</form:form>

<link rel="stylesheet" type="text/css"
	href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
<script type="text/javascript"
	src="https://cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
<script
	src="${pageContext.request.contextPath }/res/js/ckeditor/ckeditor.js"></script>
	
<script>
	$('#goList').on('click', function() {
		$('#goForm').submit();
	});
	
	var dataSettings = {
		"scrollY" : "200px",
		"scrollCollapse" : true,
		"paging" : false,
		ajax : {
			"type" : "get",
			"url" : "${pageContext.request.contextPath}/${board.board_no}/reply",
			"dataType" : "JSON"
		},
		columns : [
			{data : "user_id"}
			, {data : "reply_content"}
			, {data : "reply_reg"}
			, {data : "remover"} 
		],
		"order" : [2, 'desc']
	};
	
	var replyTable = $('#replyTable').DataTable(dataSettings);

	$('#newReply').on('click', function() {
		var sendData = {
			"board_no" : "${board.board_no}",
			"lecture_code" : "${board.lecture_code}",
			"attend_no" : "${board.attend_no}",
			"reply_content" : $('#replyContent').val()
		};
		var jsonData = JSON.stringify(sendData);
		$.ajax({
			url : "${pageContext.request.contextPath}/${board.board_no}/reply/create",
			method : "post",
			data : jsonData,
			contentType : "application/json;charset=UTF-8",
			dataType : "text",
			success : function(resp) {
				alert(resp);
				if(resp=="성공"){
					$('#replyContent').text("");
					replyTable.ajax.reload();
				}
			}
		});
	});
	
	$('#replyTable').on('click', "button", function(){
		var btn = $(this);
		if(btn.attr("name")!="${user.user_id}"){
			alert("글쓴이가 아닙니다.");
			return false;
		}
		
		if(btn.text()=="삭제"){
			$.ajax({
				url : "${pageContext.request.contextPath}/${board.board_no}/reply/remove/"+btn.val(),
				method : "delete",
				dataType : "text",
				success : function(resp) {
					alert(resp);
					if(resp.equals("성공")){
						replyTable.ajax.reload();
					}
				}
			});
		}else{
			sendData = {};
			btn.parent.
			$.ajax({
				url : "${pageContext.request.contextPath}/${board.board_no}/reply/edit",
				method : "put",
				dataType : "text",
				success : function(resp) {
					alert(resp);
					if(resp.equals("성공")){
						replyTable.ajax.reload();
					}
				}
			});
		}
	});
	
	$('#removeBtn').on('click', function(){
		var sendData = {
			"board_no" : "${board.board_no}"
		};
		var jsonData = JSON.stringify(sendData);
		$.ajax({
			url : "${pageContext.request.contextPath}/${board.lecture_code}/board/remove",
			method : "delete",
			data : jsonData,
			contentType : "application/json;charset=UTF-8",
			dataType : "text",
			success : function(resp){
				$('#goForm').submit();
			}
		});
	});
	
	var modifyMode = function(){
		$('.modifyTags').prop('style', null);
		
		$('#contentDiv').after('<textarea id="contextArea" rows="20" cols="50" style="display:none;"></textarea>');
		CKEDITOR.replace("contextArea", {
			filebrowserImageUploadUrl:"<c:url value='/board/imageUpload.do'/>?sample=test"
		});
		
		$('#contentDiv').prop("style", "display:none;");
		$('#boardTitle').prop("style", "display:none;");
	}
	
	var viewMode = function(){
		$('.modifyTags').prop('style', 'display:none;');
		for(name in CKEDITOR.instances)
		{
		    CKEDITOR.instances[name].destroy(true);
		}
		$('#contextArea').remove();
		
		$('#contentDiv').prop("style", null);
		$('#boardTitle').prop("style", null);
	}
	
	$('#modifyBtn').on('click', modifyMode);
	
	$('#cancel').on('click', viewMode);
	
	$('#confirm').on('click', function(){
		var form = new FormData(document.getElementById('boardForm'));
		var nos = $('.container').find('.modifyFiles');
		var arr = [];
		$(nos).each(function(index, input){
			arr[index]=$(input).val();
		});
		var content = CKEDITOR.instances.contextArea.getData();
		
		form.append("deleteAttachmentNos", arr);
		form.append("board_content", content);
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${board.lecture_code}/board/modify",
			method : "post",
			data : form,
			processData: false,
			contentType: false,
			dataType : "json",
			success : function(resp){
				$('.modifyTags').prop('style', 'display:none;');
				viewMode();
				
				$('#boardTitle').val("제목 : " + resp.board_title);
				$('#boardDate').val("작성일 : " + resp.board_title);
				$('#contentDiv').text("").append(resp.board_content);
				
				var fileList = [];
				var p = $('<p>').append(
					$('<b>').text("첨부파일 :")		
				);
				fileList.push(p);
				console.log(resp.board_attachmentcount);
				for(var i=0; i<parseInt(resp.board_attachmentcount); i++){
					var file = resp.attachmentList[i];
					var a = $('<a>').attr({
						href : "'${pageContext.request.contextPath }/${board.lecture_code}/download/"+file.attachment_no+"'"
						, title : "'파일명:"+file.file_size+"'"
					}).text(file.file_name);
					var btn = $('<button>').attr({
						type : "button"
						, id : "'del_"+file.attachment_no+"'"
						, "class" : "deleteBtn modifyTags"
						, style : "display:none;"
					}).text("삭제");
					fileList.push(a);
					fileList.push(btn);
					if(i<parseInt(resp.board_attachmentcount)-1){
						var space = "&nbsp;&nbsp | &nbsp;&nbsp";
						fileList.push(space);
					}
				}
				
				$('#attachList').remove().html(fileList);
			},
			error : function(e){
				
			}
		});
	});
	
	var boardForm = $("#attachList");
	$(".deleteBtn").on("click", function(){
		var regex = /del_([0-9]*)/g;
		var btnId = $(this).prop("id");
		var pdsNo = regex.exec(btnId)[1];
		boardForm.append(
			$("<input>").attr({
				type:"hidden"
				, "class":"modifyFiles"
				, name:"deleteAttachmentNos"
				, value:pdsNo
			})		
		);
		$(this).parent("span").remove();
	});

</script>