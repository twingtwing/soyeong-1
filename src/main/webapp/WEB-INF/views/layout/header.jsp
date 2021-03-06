<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
@font-face {
   font-family: 'WandohopeB';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-10@1.0/WandohopeB.woff') format('woff');
    font-weight: normal;
    font-style: normal;
}
.breadcrumb_area h2, .section_title>h2 {
   font-family: 'WandohopeB' !important;
}

#loginModal {
	display: none;
	position: fixed; /* Stay in place */
	z-index: 5; /* Sit on top */
	left: 0;
	top: 0;
	width: 100%; /* Full width */
	height: 100%; /* Full height */
	overflow: auto; /* Enable scroll if needed */
	background-color: rgb(0, 0, 0); /* Fallback color */
	background-color: rgba(0, 0, 0, 0.4); /* Black w/ opacity */
}

#box {
	display: flex;
	justify-content: center;
	align-items: center;
	border: 2px solid black;
	padding: 1.5rem;
	flex-direction: column;
	margin: 5rem;
	width: 35rem;
	height: 45rem;
	justify-content: space-evenly;
	background-color: white;
	transition: all 1s;
}

#box input, #box button {
	width: 25rem;
	border: solid #04091e 1px;
	border-radius: 5px;
	padding: 10px;
}
#box #naverLogin{
	width: 25rem;
	border: solid #03C75A 1px;
	border-radius: 5px;
	background-color: #03C75A;
	cursor: pointer;
}

#box #kakaoLogin{
	width: 25rem;
	border: solid #FEE500 1px;
	border-radius: 5px;
	background-color: #FEE500;
	cursor: pointer;
}

#box button {
	background-color: #04091e;
	color: lightgrey;
	font-weight: bold;
	cursor: pointer;
}

.findPw {
	border-bottom: darkslategrey 1px solid;
	width: 15rem;
	font-weight: bold;
	margin: 15px 0px;
	cursor: pointer;
}

.close {
	margin-left: 25rem;
	font-size: 1.5rem;
	cursor: pointer;
}

#login {
	cursor: pointer;
}
#pwShow-S {
	display: inline-block;
	position: absolute;
	margin-left: 350px;
	margin-top: -143px;
	cursor: pointer;
}
</style>
</head>
<body>
	<!--================Header Area =================-->
	<header class="header_area">
		<div class="container">
			<nav class="navbar navbar-expand-lg navbar-light">
				<!-- Brand and toggle get grouped for better mobile display -->
				<a class="navbar-brand logo_h" href="home.do"><img
					src="resources/img/Logo.png" alt=""></a>
				<button class="navbar-toggler" type="button" data-toggle="collapse"
					data-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<!-- Collect the nav links, forms, and other content for toggling -->
				<div class="collapse navbar-collapse offset"
					id="navbarSupportedContent">
					<ul class="nav navbar-nav menu_nav ml-auto">
						<li class="nav-item active"><a class="nav-link"
							href="home.do">????????????</a></li>
						<li class="nav-item"><a class="nav-link" href="noticeList.do">????????????</a></li>
						<li class="nav-item"><a class="nav-link"
							href="question.do">????????????</a></li>
						<!-- ????????? ?????? ????????? -->
						<c:if test="${author eq 'USER'}">
							<li class="nav-item"><a class="nav-link" href="memberAuthor.do">????????? ??????</a></li>
						</c:if>
						<c:if test="${author eq 'ADMIN'}">
							<li class="nav-item"><a class="nav-link" href="admin.do">????????? ??????</a></li>
						</c:if>
						<li class="nav-item submenu dropdown">
							<a href="#" class="nav-link dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> 
								<c:if test="${empty id}">
									?????????
								</c:if> 
								<c:if test="${not empty id}">
									???????????????
								</c:if>
							</a>
							<ul class="dropdown-menu">
								<!-- ????????? ?????? ??????????????? ?????? -->
								<c:if test="${empty id}">
									<li class="nav-item" id="loginBtn"><a class="nav-link"
										href="#">?????????</a></li>
									<li class="nav-item"><a class="nav-link"
										href="joinForm.do">????????????</a></li>
								</c:if>
								<c:if test="${not empty id}">
									<li class="nav-item"><a class="nav-link"
										href="memberProfile.do">??? ??????</a></li>
									<c:if test="${author ne 'BAN'}">
									<li class="nav-item"><a class="nav-link"
										href="myReserv.do?ispaid=A">?????? ?????? ??????</a></li>
									</c:if>
									<c:if test="${author eq 'HOST'}">
									<li class="nav-item"><a class="nav-link"
										href="hostManage.do">????????? ??????</a></li>
									</c:if>
									<li class="nav-item"><a class="nav-link" href="logout.do"
										onclick="kakaoLogout();">????????????</a></li>
								</c:if>
							</ul></li>
					</ul>
				</div>
			</nav>
		</div>
	</header>
	<!--================Header Area =================-->

	<!-- login modal -->
	<div align="center" id="loginModal">
		<div id="box" class="pb-5">
			<span class="close">&times;</span> <span>????????? ???????????? ?????? ?????? ???????????????.</span>
			<input type="text" placeholder="ID" id="id" name="id"> 
			<input type="password" placeholder="Password" id="password" name="password">
			<div id="pwShow-S">
            	<i class="far fa-eye-slash"></i>
            </div>
			<button type="button" id="login">?????????</button>
			<div align="center" class="findPw">???????????? ??????</div>
			<a href="ajaxKakao.do" id="kakaoLogin">
      			<img alt="kakao_login" src="resources/img/kakaoLogin.png" height ="50">
      		</a>
      		<a href="${naverUrl }" id="naverLogin">
      			<img alt="naver_login" src="resources/img/naverLogin.png" height ="50">
      		</a>
		</div>
	</div>
	
	
	
	<script type="text/javascript">

	// login
	document.getElementById('login').addEventListener('click',()=>{
		if(document.getElementById('id').value==''||document.getElementById('password').value==''){
			window.alert('????????? ?????? ??????????????? ??????????????????.');
			return;
		}		
		let id = $('#id').val()
		let password = $('#password').val()
		loginSelect(id,password);	
	})
	
	// login ajax
	function loginSelect(id,password){
		$.ajax({
			method:'post',
			url: 'login.do',
			data : {'id':id,'password':password},
			dataType : 'text'
		})
		.done((response)=>{
			if(response=='ng'){
				window.alert('????????? ?????? ??????????????? ???????????????.');
			}else{
				window.alert('???????????????!');
				$('.close').click();
				location.href='home.do';
			}
		})
	}
/* 	
	if($('#loginModal').css('display')=='block'){
		$('#loginModal').on('keypress',(e)=>{			
			if(e.keyCode==27){
				console.log()
				$('.close').click();
			}			
		})
	} */

	// ???????????? ?????? ?????????
	$('.findPw').click(()=>{
		$('#loginModal').css('display','none');
		location.href="findPw.do"
	})

	$('#loginBtn').on('click',()=>{
		$('#loginModal').css('display','block');
	})
	
	$('.close').on('click',()=>{
		$('#loginModal').css('display','none');
	})

	$('#password').keypress((event)=>{
		if(event.keyCode==13){
			$('#login').click();
		}
	})
	
	//???????????? ???????????? ??????
    document.getElementById('pwShow-S').addEventListener('click',function(){
        let pw = document.getElementById('password');
        if(pw.getAttribute('type')=="password"){
            pw.setAttribute('type','text');
	        this.innerHTML = '<i class="far fa-eye"></i>';
   	    }else {
       	    pw.setAttribute('type','password');
           	this.innerHTML = '<i class="far fa-eye-slash"></i>';
       	}
    });	
	
</script>
</body>
</html>