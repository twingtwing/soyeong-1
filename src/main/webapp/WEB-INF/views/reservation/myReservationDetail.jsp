<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
#all {
	display: grid;
	grid-template-columns: 1fr 2fr;
	justify-content: center;
	align-items: center;
	width: 80vw;
	margin: 10rem;
	margin-top: 0px;
}

.bookInfo {
	display: flex;
	flex-direction: column;
	margin: 1rem;
	align-items: center;
}

.bookDetails {
	display: flex;
	flex-direction: column;
	margin-top: 2.5rem;
}

.back {
	background-color: white;
	border: 1px solid #F3C300;
	border-radius: 5rem;
	padding: 0.5rem 1rem;
	position: inherit;
	margin-top: 5rem;
	margin-left: 5rem;
	z-index: 2;
	cursor: pointer;
	font-size: 0.8rem;
	color: lightgray;
}

.bookInfo>div>div {
	cursor: pointer;
	display: inline-block;
	padding: 0.5rem 1rem;
	margin: 7px;
}

.bookInfo button {
	width: 15rem;
	padding: 5px;
	border-radius: 5px;
	color: white;
}

.bookImg {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: space-evenly;
}

.bookImg>div>span:nth-child(1) {
	font-size: 1.1rem;
	font-weight: bold;
}

.state {
	display: flex;
	justify-content: space-between;
}

.bookDetails>span:nth-child(2n) {
	border-top: 1px solid lightgray;
	font-size: 1.05rem;
	font-weight: bold;
}

.bookDetails>span:nth-child(1), .bookDetails>span:nth-child(8),
	.bookDetails>span:nth-child(10) {
	font-size: 1.3rem;
	font-weight: bold;
	border-top: 1px solid lightgray;
	color: #F8B600;
}

.bookDetails>span {
	padding: 0.5rem 1rem;
}

.refundBar {
	background-color: #eae0b9;
	height: 2rem;
	border: 1px solid #eae0b9;
	border-radius: 10rem;
	width: 35vw;
}
.refundBar>span{
	display: inline-block;
	width: 10rem;
	background-color: #F3C300;
	z-index: 2;
}

button {
	background-color: #F3C300;
	border: 1px solid #F3C300;
	cursor: pointer;
}

.bookImg button {
	color: #04091e;
	border: 1px solid #F3C300;
	padding: 5px 1rem;
	border-radius: 3px;
	margin: 0.5rem;
	margin-top: 1.5rem;
}

.bookInfo button:hover {
	background-color: #F8B100;
	transition: all 0.4s;
}

.bookImg img {
	width: 40rem;
	margin-bottom: 2rem;
}
#cancelBtn{
margin-top: 3rem;
background: gray;
border : 1px solid gray;
}
#cancelBtn:hover{
	background-color: darkred;
	
}
</style>
<script src="https://kit.fontawesome.com/00b1224df3.js"
	crossorigin="anonymous"></script>
</head>

<body>
	<section class="breadcrumb_area">

		<div class="overlay bg-parallax" data-stellar-ratio="0.8"
			data-stellar-vertical-offset="0" data-background=""
			style="transform: translateY(0px);">
			<img src="resources/img/banner_bg.jpg">
		</div>
		<div class="container">
			<div class="page-cover text-center">
				<h2 class="page-cover-tittle">?????? ?????? ??????</h2>
			</div>
		</div>
	</section>



	<button type="button" onclick="location.href='myReserv.do?ispaid=A'" class="back">
		 &lt; PREV
	</button>
	<div id="all">
		<div class="bookInfo">
			<div align="center">
				<div>?????????</div>
				<div>????????????</div>
				<br>
				<button>????????? ?????????</button>
			</div>
			<div class="bookDetails">
				<span>?????? ????????????</span>
				<span>????????? - ????????????</span>
				<span>${reservInfo.checkin} &nbsp;&nbsp;${reservInfo.rcheckin}???<br> - ${reservInfo.checkout} &nbsp;&nbsp;${reservInfo.rcheckout}???</span>
				<span>?????????</span>
				<span>?????? ${reservInfo.bookadult}???</span>
				<span>????????????</span>
				<span>${reservInfo.bookno}???</span>
				<span>????????????</span>
				<span>????????? ???????????? ????????? ??????</span>
				<span>??????????????? ???</span> 
				<span>${reservInfo.raddress}</span> 
				<span>?????? ??????</span> 
				<span id="cost">${reservInfo.fee}</span>
				<c:if test="${reservInfo.bookcancel eq 'N'}">
					<button id="cancelBtn">????????????</button>
				</c:if>
			</div>
		</div>
		<div class="bookImg">
			<img alt="" src="${reservInfo.rphoto}">
			<h3>${reservInfo.rname}</h3>
			<div>?????????: ${reservInfo.rtel }</div>
			<div id="cancel">
				<span>?????? ????????????</span><br>
				<div class="state">
					<span>??????</span><span>??????</span><span>??????</span>
				</div>
				<div class="refundBar"><span></span></div>
				<div align="right">
					<button>?????????</button>
					<button>??????</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		if(new Date('${reservInfo.checkout}')<new Date()){
			$('#cancelBtn').remove();
		}		
		let checkin = new Date('${reservInfo.checkin}');
		let checkout = new Date('${reservInfo.checkout}');
		let one = ${reservInfo.fee};
		let day = parseInt(+(checkout.getTime()-checkin.getTime())/(1000*3600*24));
		$('#cost').text('??? '+parseInt(one*day*(1+0.1+0.01))+' ???');
		
		if('${reservInfo.bookrefund}'=='Y'){
			$('.refundBar').css('backgroundColor','#77c5fd').css('border','#77c5fd 1px solid');
			$('.state').children().last().text('????????????').css('font-weight','bold').css('color','darkred');
		} else{
			$('.state').children().first().css('font-weight','bold').css('color','darkred');
		}

		let bookcancel = '${reservInfo.bookcancel}';
		if (bookcancel == 'N') {
			$('#cancel').children().remove();
		}
		if ('${reservInfo.bookkid}' != '0') {
			$('.bookDetails>span:nth-child(5)').text(
					'?????? ${reservInfo.bookadult}???\n?????? ${reservInfo.bookkid}???');
		}

		$('#cancelBtn').on('click',(e)=>{
			if(window.confirm('????????? ?????????????????????????\n ?????? ??? ???????????? ????????? ????????? ????????? ???????????????.')){
				canceling('${reservInfo.bookno}','${id}');			
			}
		})
		
		let addBar = function(){
			$('#cancel').children().css('display','block');
			$('#cancel').append($('<span>').html('?????? ????????????<br>'),
								$('<div>').addClass('state').append($('<span>').text('??????'),$('<span>').text('??????'),$('<span>').text('??????')),
								$('<div>').addClass('refundBar').append('<span>'),
								$('<div>').attr('align','right').append($('<button>').text('?????????'),$('<button>').text('??????'))
									)
			$('#cancelBtn').css('display','none');
		}
		
		
		
		let canceling = function(bookno, id){
			$.ajax({
				url: 'cancelReserv.do',
				method : 'post',
				data : {bookno : bookno, id:id},
				dataType : 'text'
			})
			.done((response)=>{
				console.log(response)
				if(response=='ok'){
					window.alert('????????? ??????????????? ?????????????????????.');
					addBar();
					return;
				} else{
					window.alert('????????? ?????????????????????. \n??????????????? ???????????????.');
				}
			})
			.fail((error)=>{
				window.alert('????????? ?????????????????????.\n??????????????? ???????????????.')
			})
		}
		
	</script>
</body>

</html>