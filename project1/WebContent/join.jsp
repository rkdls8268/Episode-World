<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
	<%@page import="java.sql.*" %> 
   
    <%@page session="true" %>
<HTML>
	<head>
	<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
	<link rel="stylesheet"
		href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<link rel='stylesheet'
		href='https://use.fontawesome.com/releases/v5.5.0/css/all.css'
		integrity='sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU'
		crossorigin='anonymous'>
	<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
	<link rel="stylesheet" type="text/css" href="style.css" />
	<link rel="stylesheet"
		href="https://fonts.googleapis.com/css?family=Karma">
	<script type="text/javascript" src="javascript.js"></script>
	<title>Episode World</title>
	</head>
    <BODY>
		<div class="w3-top">
		<div class="w3-bar w3-black w3-card">
			<a
				class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right"
				href="javascript:void(0)" onclick="myFunction()"
				title="Toggle Navigation Menu"></a>
				<!-- <a
				class="w3-bar-item w3-button w3-padding-large w3-right"
				href="javascript:void(0)" onclick="document.getElementById('id01').style.display='block'" style="width:auto;"
				title="Login">Login</a> -->
				<button class="w3-bar-item w3-padding-large w3-button w3-right" onclick="document.getElementById('id01').style.display='block'" style="width:auto; margin:0px">Login</button>
				<a
				href="main.jsp" class="w3-bar-item w3-button w3-padding-large">HOME</a>
			
			<div class="w3-dropdown-hover w3-hide-small">
				<button class="w3-padding-large w3-button" title="드라마" style="margin:0px">
					드라마
				</button>
				<div class="w3-dropdown-content w3-bar-block w3-card-4">
					<a href="drama_kbs.jsp" class="w3-bar-item w3-button">KBS</a> <a
						href="drama_sbs.jsp" class="w3-bar-item w3-button">SBS</a> <a href="drama_mbc.jsp"
						class="w3-bar-item w3-button">MBC</a> <a href="drama_tvn.jsp"
						class="w3-bar-item w3-button">TVN</a> <a href="drama_jtbc.jsp"
						class="w3-bar-item w3-button">JTBC</a>
				</div>
			</div>
			<div class="w3-dropdown-hover w3-hide-small">
				<button class="w3-padding-large w3-button" title="예능" style="margin:0px">
					예능
				</button>
				<div class="w3-dropdown-content w3-bar-block w3-card-4">
					<a href="variety_kbs.jsp" class="w3-bar-item w3-button">KBS</a> <a href="variety_sbs.jsp"
						class="w3-bar-item w3-button">SBS</a> <a href="variety_mbc.jsp"
						class="w3-bar-item w3-button">MBC</a> <a href="variety_tvn.jsp"
						class="w3-bar-item w3-button">TVN</a> <a href="variety_jtbc.jsp"
						class="w3-bar-item w3-button">JTBC</a>
				</div>
			</div>
			<div class="w3-dropdown-hover w3-hide-small">
				<button class="w3-padding-large w3-button" title="My_Page" style="margin:0px">
					My Page
				</button>
				<div class="w3-dropdown-content w3-bar-block w3-card-4">
					<a href="my_stars.jsp" class="w3-bar-item w3-button">내가 매긴 별점</a> <a href="my_comments.jsp"
						class="w3-bar-item w3-button">내가 쓴 한줄평</a> <a href="edit_info.jsp"
						class="w3-bar-item w3-button">회원 정보 수정</a>
				</div>
			</div>
		</div>
	</div>

	<!-- Header -->
	<header class="w3-container w3-center" style="padding-top:88px; padding-bottom:8px">
	<h1>
		<b>Episode World</b>
	</h1>
	</header>
	<!-- !PAGE CONTENT! -->
	<div class="w3-main w3-content w3-padding"
		style="max-width: 1200px; margin-top: 50px">
	
	<hr id="about">
        <FORM ACTION=Subscription.jsp METHOD=POST>
			<table width="100%">
				<tr height="40">
					<td align="center"><b>[회원가입]</b></td>
				</tr>
			</table>
            <table width="50%" height="400" align="center" cellpadding="0" style="border-collapse:collapse; font-size:9pt;">
				<tr height="30" id="box">
					<td width="20%" align="center">*</td>
					<td width="30%">이름</td>
					<td><INPUT TYPE=TEXT NAME=name SIZE=10 required></td>
				</tr>
				<tr height="30" id="box">
					<td width="20%" align="center">*</td>
					<td width="30%">아이디</td>
					<td><INPUT TYPE=TEXT NAME=id SIZE=10 required></td>
				</tr>
				
				<tr height="30" id="box">
					<td width="20%" align="center">*</td>
					<td width="30%">패스워드</td>
					<td><INPUT TYPE=PASSWORD NAME=pw id="password" SIZE=15 required></td>
				</tr>
				<tr height="30">
					<td width="20%" align="center">*</td>
					<td width="30%">패스워드확인</td>
					<td><INPUT TYPE=PASSWORD NAME=passwordCheck id='pwCheck' SIZE=15 required></td>
					<td width="10%"><div height="30" id="same"/></td>
					<script language="JavaScript">
						$("pwCheck").keydown(function(){
						String pw = document.getElementById("pw").value;
						String confirmPW = document.getElementById("pwCheck").value;
						if(pw != confirmPW)){
						document.getElementById("same").innerHTML="<b><font color="green"> 비밀번호가 일치하지 않습니다.</font></b>";
						}
						else {
							document.getElementById("same").innerHTML="<b>비밀번호 일치</b>";
							document.getElementById("same").style.color='red';
						}
						});
					</script>
				</tr>
				<tr height="30">
					<td colspan="3" align="center"><INPUT TYPE=SUBMIT VALUE='&nbsp;가입하기&nbsp;' class="w3-button">&nbsp;&nbsp;<INPUT TYPE=RESET VALUE='&nbsp;취소&nbsp;' class="w3-button"></td>
				</tr>
			</table>
        </FORM>
		<!-- Footer -->
		<footer class="w3-center w3-padding-32">
		<div class="w3-center">
			<p>
				Copyright@ <a href="http://new.sungshin.ac.kr/web/kor/home"
					target="_blank">Sungshin.w.univ</a>
			</p>
		</div>
		</footer>
    </BODY>
</HTML>
