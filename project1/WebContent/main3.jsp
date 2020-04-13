<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
<%@page session="true" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" type="text/css" href="style.css" />
<link rel="stylesheet"
	href="https://fonts.googleapis.com/css?family=Karma">
<script type="text/javascript" src="javascript.js"></script>
<title>Episode World</title>
</head>
<body>
	<%
	int n = 54;
Class.forName("com.mysql.jdbc.Driver");
String jdbcDriver = "jdbc:mysql://localhost:3306/sys?characterEncoding=EUC-KR&serverTimezone=UTC";

String dbUser = "root";
String dbPw = "1234";

String loginID = (String)session.getAttribute("ID");
String loginName = (String)session.getAttribute("NAME");
boolean login = loginID == null ? false : true;

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
%>

	<!-- Navbar -->
	<div class="w3-top">
		<div class="w3-bar w3-black w3-card">
			<a
				class="w3-bar-item w3-button w3-padding-large w3-hide-medium w3-hide-large w3-right"
				href="javascript:void(0)" onclick="myFunction()"
				title="Toggle Navigation Menu"></a>
				<%
					if(login) {
						%>
						<a href="logout.jsp" class="w3-bar-item w3-padding-large w3-right"><%=loginName%>님, Logout</a>
					<%
					} else {
						%>
						<button class="w3-bar-item w3-padding-large w3-button w3-right"
						onclick="document.getElementById('id01').style.display='block'"
						style="width: auto; margin: 0px">Login</button>
						<%
					}
				%>
			<a href="main.jsp" class="w3-bar-item w3-button w3-padding-large">HOME</a>
			
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
		style="max-width: 1200px; margin-top: 50px">
		
		<%
		request.setCharacterEncoding("euc-kr");
		
		try {
			
			conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPw);
            
			String query = "select * from sys.broadcast_info;";
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
				count++;
			}
			
			count = 0;
			
			String query1 = "select * from sys.poster_info;";
			
			rs = stmt.executeQuery(query1);
			
			while(rs.next()){
				poster_url[count] = rs.getString("poster_url");
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
		
		for (int i = 6; i < 9; i++) {
		%>

		<div class="w3-row-padding w3-padding-16 w3-center">
			<%
			for (int j = 1; j <= 4; j++) {
			%>
			
			<div class="w3-quarter">
				<img
					src="<%=poster_url[(4*i)+j-1] %>"
					alt="<%=title[(4*i)+j-1]%>" style="width: 80%">
				<h4 style><%=title[(4*i)+j-1]%></h4>
				<p><%=company[(4*i)+j-1]%> <%=genre[(4*i)+j-1]%><br /><%=b_date[(4*i)+j-1]%> <%=b_time[(4*i)+j-1]%></p>
			</div>
			<% } %>
		</div>
		<% } %>
		
		<!-- Pagination -->
		<div class="w3-center w3-padding-32">
			<div class="w3-bar">
				<a href="http://localhost:8080/project1/main.jsp" class="w3-bar-item w3-button w3-hover-black">&laquo;</a>
				<a href="http://localhost:8080/project1/main.jsp" class="w3-bar-item w3-button w3-hover-black">1</a> <a
					href="http://localhost:8080/project1/main2.jsp" class="w3-bar-item w3-button w3-hover-black">2</a>
				<a href="http://localhost:8080/project1/main3.jsp" class="w3-bar-item w3-black w3-button">3</a>
				<a href="http://localhost:8080/project1/main4.jsp" class="w3-bar-item w3-button w3-hover-black">4</a>
				<a href="http://localhost:8080/project1/main5.jsp" class="w3-bar-item w3-button w3-hover-black">5</a>
				<a href="http://localhost:8080/project1/main5.jsp" class="w3-bar-item w3-button w3-hover-black">&raquo;</a>
			</div>
		</div>

		<!-- Footer -->
		<footer class="w3-center w3-padding-32">
		<div class="w3-center">
			<p>
				Copyright@ <a href="https://www.w3schools.com/w3css/default.asp"
					target="_blank">w3.css</a>
			</p>
		</div>
		</footer>
		
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