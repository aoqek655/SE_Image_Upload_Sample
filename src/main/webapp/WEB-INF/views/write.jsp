<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript" src="resources/se/js/HuskyEZCreator.js" charset="utf-8" ></script>
<script type="text/javascript" src="resources/se/js/jindo.min.js" charset="utf-8" ></script>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
<style type="text/css">
#boardWriteForm{margin: 30px 0;}
</style>
</head>
<body>
<div class="container">
	<form id="boardWriteForm" method="post">
		<div>
			<div><b>제목</b></div>
			<input type="text" id="title" name="title" value="" maxlength="100" style="width: 100%;"/>
		</div>
		<div class="contentDiv">
		 	<textarea id="txtContent" name="contents" rows="30" style="width:100%;"></textarea>
		</div>
		<div class="buttonDiv">
			 <button type="button" class="btn btn-primary" onclick="onWrite()">쓰기</button>
			 <button type="button" class="btn btn-primary" onclick="history.go(-1);"> 취소</button>
			 <input type="hidden" name="seq" value="${board.seq}"/> 
		</div>
	</form>
</div>
</body>
<script type="text/javascript">
var oEditors = [];
	nhn.husky.EZCreator.createInIFrame({
	oAppRef: oEditors,
	elPlaceHolder: document.getElementById('txtContent'), // html editor가 들어갈 textarea id 입니다.
	sSkinURI: "resources/se/SmartEditor2Skin.html",  // html editor가 skin url 입니다.
	fOnAppLoad: function () { 
        //수정모드를 구현할 때 사용할 부분입니다. 로딩이 끝난 후 값이 체워지게 하는 구현을 합니다.
         var title = localStorage.getItem("title");            
         var contents = localStorage.getItem("contents");        //db에서 불러온 값은 여기에서 체워넣습니다.
         document.getElementById("title").value = title;     
         oEditors.getById["txtContent"].exec("PASTE_HTML", [contents]); //로딩이 끝나면 contents를 txtContent에 넣습니다.
     },
     fCreator: "createSEditor2"
 });

var onWrite = function(){
	oEditors.getById["txtContent"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea에 적용합니다.
	
	 var contents = document.getElementById("txtContent").value;
	 var title = document.getElementById("title").value;
	 localStorage.setItem("contents", contents);
	 localStorage.setItem("title", title);             //localStorage에 제목과 내용을 저장.
	 
	var boardWriteForm = document.getElementById("boardWriteForm");  
	//boardWriteForm.action ="writeSubmit";			//저장할 페이지로 쏩니다.              
	boardWriteForm.submit();  
};

var pasteHTML = function(filename){
    var sHTML = '<img src="${pageContext.request.contextPath}/resources/upload/'+filename+'">';
    oEditors.getById["txtContent"].exec("PASTE_HTML", [sHTML]);
};
</script>
</html>