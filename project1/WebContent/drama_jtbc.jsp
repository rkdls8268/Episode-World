<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<body>
	<%
	String m_company = "jtbc";
	String u_company = "jtbc";
	String m_genre = "드라마";
	String e_genre = "drama";
	int n = 2;
Class.forName("com.mysql.jdbc.Driver");
String jdbcDriver = "jdbc:mysql://localhost:3306/sys?characterEncoding=EUC-KR&serverTimezone=UTC";

String dbUser = "root";
String dbPw = "1234";

Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;

String[] title, genre, company, b_date, b_total, b_time;
title = new String[n];
genre = new String[n];
company = new String[n];
b_date = new String[n];
b_total = new String[n];
b_time = new String[n];

String[] poster_url;
poster_url = new String[n];

int count = 0;

String[] href;
href = new String[n];
%>

	<!-- Navbar -->
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
	<header class="w3-container w3-center header1">
	<h1>
		<b>Episode World</b>
	</h1>
	</header>

	<hr id="about">

	<!-- !PAGE CONTENT! -->
	<div class="w3-main w3-content w3-padding"
		style="max-width: 1200px;">
		
		<div class="row col-12 col-m-12 mainTitle">
			<h3><%=u_company%> <%=m_genre%></h3>
		</div>

		<%
		request.setCharacterEncoding("euc-kr");
		
		try {
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPw);
            
			String query = "select * from sys.broadcast_info where company='" + m_company + "' AND genre='" + m_genre + "';";
			// Statement 생성
			stmt = conn.createStatement();
		
			// 쿼리 실행
			rs = stmt.executeQuery(query);
			
			while(rs.next()){
				title[count] = rs.getString("title");
				genre[count] = rs.getString("genre");
				company[count] = rs.getString("company");
				b_date[count] = rs.getString("b_date");
				b_total[count] = rs.getString("b_total");
				b_time[count] = rs.getString("b_time");
				href[count] = e_genre + "_" + m_company + "_" + (count+1) + ".jsp";
				count++;
			}
			
			count = 0;
			
			String query1 = "select b.title, p.poster_url, b.company, b.genre from sys.poster_info p, sys.broadcast_info b"
					+ " where b.title = p.p_title AND b.company='" + m_company + "' AND b.genre='" + m_genre + "' group by p.poster_url;";
			
			rs = stmt.executeQuery(query1);
			
			while(rs.next()){
				poster_url[count] = rs.getString("p.poster_url");
				count++;
			}
			
			} catch (SQLException e){
				out.println(e.getMessage());
				e.printStackTrace();
		} finally {
			if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
			
			// 사용한 Statement 종료
			if (rs != null) try {rs.close();} catch(SQLException e) {}
			if (stmt != null) try {stmt.close();} catch(SQLException e) {}
			if(conn != null) try { conn.close(); } catch(SQLException e) {}
		}
		
		count = 0;
		
		for (int i = 0; i < (int) (Math.ceil(((double)n/4))); i++) {
		%>

		<div class="w3-row-padding w3-padding-16 w3-center" id="food">
			<%
			for (int j = 1; j <= 4; j++) {
			%>
			<a href="<%=href[count]%>">
				<div class="w3-quarter">
					<img
						src="<%=poster_url[(4*i)+j-1]%>"
						alt="<%=title[(4*i)+j-1]%>" style="width: 80%">
					<h4 style><%=title[(4*i)+j-1]%></h4>
					<p><%=company[(4*i)+j-1]%>
						<%=genre[(4*i)+j-1]%><br /><%=b_date[(4*i)+j-1]%>
						<%=b_time[(4*i)+j-1]%></p>
				</div>
			</a>
			<% 
				if((4*i)+j == n)
					break;
				count++;
			} %>
		</div>
		<% } %>

		<!-- Pagination -->
		<div class="w3-center w3-padding-32">
			<div class="w3-bar">
				<a href="#" class="w3-bar-item w3-button w3-hover-black">&laquo;</a>
				<a href="#" class="w3-bar-item w3-black w3-button">1</a> <a href="#"
					class="w3-bar-item w3-button w3-hover-black">&raquo;</a>
			</div>
		</div>

		<hr id="about">

		<!-- Footer -->
		<footer class="w3-center w3-padding-32">
		<div class="w3-center">
			<p>
				Copyright@ <a href="http://new.sungshin.ac.kr/web/kor/home"
					target="_blank">Sungshin.w.univ</a>
			</p>
		</div>
		</footer>

	</div>
	
	<!-- login modal -->
	<div id="id01" class="modal">
  
  <form class="modal-content animate" action="#" method=post>
    <div class="imgcontainer">
      <span onclick="document.getElementById('id01').style.display='none'" class="close" title="Close Modal">&times;</span>
      <img src="KakaoTalk_20181213_125826644.png" alt="Avatar" class="avatar">
    </div>

    <div class="container">
      <label for="uname"><b>ID</b></label>
      <input type="text" placeholder="ID를 입력하세요." name="id" required>

      <label for="psw"><b>Password</b></label>
      <input type="password" placeholder="비밀번호를 입력하세요." name="pw" required>
        
      <button class="btnLogin" type="submit">Login</button>
      <!-- <label>
        <input type="checkbox" checked="checked" name="remember"> Remember me
      </label> -->      
    </div>

    <div class="container" style="background-color:#f1f1f1">
      <div class="psw">아직 회원이 아니신가요? <a href="join.jsp">회원가입</a> 하러 가기</div>
    </div>
  </form>
</div>

</body>
</html>