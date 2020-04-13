<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.sql.*"%>
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
String title = "짠내 투어";
int n = 100;

String loginID = (String)session.getAttribute("ID");
String loginName = (String)session.getAttribute("NAME");
boolean login = loginID == null ? false : true;

Class.forName("com.mysql.jdbc.Driver");

String dbUser = "root";
String dbPw = "1234";

Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;

// 방송 정보
String b_date = null, b_info= null, b_time= null; 

// 캐스팅 정보
String[] casting;
casting = new String[30];
int count1 = 0;
int count2 = 0;

// 에피소드 정보
String[] ep_no;
String[] ep_info;
ep_no = new String[n];
ep_info = new String[n];
int count = 0;

// 에피소드 출연진 정보
String g_ep_no;
String[][] guest;
guest = new String[n][10];

// 포스터 정보
String poster_url = null;

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
			<a href="logout.jsp" class="w3-bar-item w3-padding-large w3-right"><%=loginName%>님,
				Logout</a>
			<%
					} else {
						%>
			<button class="w3-bar-item w3-padding-large w3-button w3-right"
				onclick="document.getElementById('id01').style.display='block'"
				style="width: auto; margin: 0px">Login</button>
			<%
					}
				%>
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

	<!-- Navbar on small screens (remove the onclick attribute if you want the navbar to always show on top of the content when clicking on the links) -->
	<div id="navDemo"
		class="w3-bar-block w3-black w3-hide w3-hide-large w3-hide-medium w3-top"
		style="margin-top: 46px">
		<a href="#" class="w3-bar-item w3-button w3-padding-large"
			onclick="myFunction()">드라마</a> <a href="#"
			class="w3-bar-item w3-button w3-padding-large" onclick="myFunction()">예능</a>
		<a href="#" class="w3-bar-item w3-button w3-padding-large"
			onclick="myFunction()">My Page</a>
	</div>

	<!-- Header -->
	<header class="w3-container w3-center header1 row">
	<h1 class="col-12 col-m-12">
		<b>Episode World</b>
	</h1>
	</header>

	<hr id="about" class="row">

	<!-- !PAGE CONTENT! -->
	<div class="w3-main w3-content w3-padding row"
		style="max-width: 90%; margin-top: 10px; margin-left: 4%; margin-right: 4%">

		<%
		request.setCharacterEncoding("euc-kr");
	
		String jdbcDriver = "jdbc:mysql://localhost:3306/sys?characterEncoding=EUC-KR&serverTimezone=UTC";

			
			try {
				
				conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPw);
	            
				String query = "select ep_no, ep_info from sys.episode_info where title='" + title + "' order by ep_no desc;";
				// Statement 생성
				stmt = conn.createStatement();
			
				// 쿼리 실행
				rs = stmt.executeQuery(query);
				
				while(rs.next()){
					ep_no[count] = rs.getString("ep_no");
					ep_info[count] = rs.getString("ep_info");
					count++;					
					}
				
				String query1 = "select title, b_date, b_info, b_time from sys.broadcast_info where title='" + title + "';";
				rs = stmt.executeQuery(query1);
				
				while(rs.next()){
					b_date = rs.getString("b_date");
					b_info = rs.getString("b_info");
					b_time = rs.getString("b_time");	
				}
				
				
				String query2 = "select casting from sys.casting_info where c_title = '" + title + "';";
				rs = stmt.executeQuery(query2);
				
				while(rs.next()){
					casting[count1] = rs.getString("casting");
					count1++;
				}
				
				count1 = 0;
				
				for (int i = 0; i < ep_no.length; i++){
					String query3 = "select * from sys.episode_guest where g_title = '" + title + "' AND g_ep_no = " + ep_no[i] + " order by g_ep_no desc;";
					rs = stmt.executeQuery(query3);
					
					count1 = 0;
					
					while (rs.next()) {
						guest[i][count1] = rs.getString("guest");
						count1++;
					}
				}
				
				
				String query4 = "select * from sys.poster_info where p_title='" + title + "';";
				rs = stmt.executeQuery(query4);
				
				while (rs.next()) {
					poster_url = rs.getString("poster_url");
				}
				
				
		%>

		<div class="row col-12 col-m-12">
			<h3><%=title%></h3>
		</div>

		<div class="mainInfo row">
			<div class="col-12 col-m-12 mainIntro">
				<img class="row col-3 col-m-3"
					src="<%=poster_url%>"
					title="<%=title%>" alt="<%=title%>" />

				<div class="info col-9 col-m-9">
					<span><b>[기본 정보]</b></span>
					<p><%=b_date%>
						<%=b_time%></p>
					<p>
						<b>출연진</b>:
						<%
						for(int i = 0; ; i++){
							if(casting[i] == null)
								break;
						%>
						<%=casting[i]%>
						<%
						}
						%>
					</p>
					<p>
						<b>전체 줄거리</b>:
						<%=b_info%>
					</p>

				</div>
			</div>
		</div>

		<div class="row col-12 col-m-12">
			<hr>
		</div>

		<!-- Pagination -->
		<div class="w3-center pagination row">
			<div class="col-12 col-m-12">
				<!-- <button class="w3-button w3-hover-black demo" onclick="currentDiv(1)">&laquo;</button> -->
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(1)"><%=ep_no[0]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(2)"><%=ep_no[1]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(3)"><%=ep_no[2]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(4)"><%=ep_no[3]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(5)"><%=ep_no[4]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(6)"><%=ep_no[5]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(7)"><%=ep_no[6]%>회
				</button>
				<button class="w3-button w3-hover-black demo"
					onclick="currentDiv(8)"><%=ep_no[7]%>회
				</button>
				<!-- <button class="w3-button w3-hover-black demo" onclick="currentDiv(8)">&raquo;</button> -->
			</div>
		</div>


		<div class="row col-12 col-m-12">
		<%
			for(int j=0;j<8;){
			%>
			<div class="w3-left">
				<div class="mySlides">
					<hr>
					<div class="w3-display-bottom">
						<p><%=ep_no[j]%>회
						</p>
						<p>
							<%
						for(int i = 0; i < 10; i++){
							if(guest[j][i] == null)
								break;
						%>
							<%=guest[j][i]%>
							<%
						}
						%>
						</p>
						<p><%=ep_info[j]%></p>
					</div>
					<hr>
					<div>
						<p>별점과 한줄평을 남겨주세요!</p>
						<form action=# method=post>
							
							<fieldset class="rating">
								<input type="radio" id="star5" name="rating" value="5" /><label
									class="full" for="star5" title="Awesome - 5 stars"></label> <input
									type="radio" id="star4half" name="rating" value="4.5" /><label
									class="half" for="star4half" title="Pretty good - 4.5 stars"></label>
								<input type="radio" id="star4" name="rating" value="4" /><label
									class="full" for="star4" title="Pretty good - 4 stars"></label>
								<input type="radio" id="star3half" name="rating" value="3.5" /><label
									class="half" for="star3half" title="Meh - 3.5 stars"></label> <input
									type="radio" id="star3" name="rating" value="3" /><label
									class="full" for="star3" title="Meh - 3 stars"></label> <input
									type="radio" id="star2half" name="rating" value="2.5" /><label
									class="half" for="star2half" title="Kinda bad - 2.5 stars"></label>
								<input type="radio" id="star2" name="rating" value="2" /><label
									class="full" for="star2" title="Kinda bad - 2 stars"></label> <input
									type="radio" id="star1half" name="rating" value="1.5" /><label
									class="half" for="star1half" title="Meh - 1.5 stars"></label> <input
									type="radio" id="star1" name="rating" value="1" /><label
									class="full" for="star1" title="Sucks big time - 1 star"></label>
								<input type="radio" id="starhalf" name="rating" value="0.5" /><label
									class="half" for="starhalf" title="Sucks big time - 0.5 stars"></label>
							</fieldset>

							<textarea name="comments" rows="3" cols="100"></textarea>
							<br> <input type="submit" value="등록" /> <input type="reset"
								value="초기화" />
						</form>
					</div>
					<%
					String rating = request.getParameter("rating");
					String comments = request.getParameter("comments");
					
					// DB에 별점 및 한줄평 insert
					if (rating != null) {
						pstmt = conn.prepareStatement("insert into sys.rating values (?, ?, ?, ?, ?)");
						pstmt.setString(1, loginID);
						pstmt.setString(2, title);
						pstmt.setString(3, ep_no[0]);
						pstmt.setString(4, rating);
						pstmt.setString(5, comments);
									
						pstmt.executeUpdate();
					}
					
					// 별점 및 한줄평 관련
					String writer_id = null;
					String star = null;
					String comment = null;
							
					String query5 = "select * from sys.rating where rate_title='" + title + "';";
											
					// Statement 생성
					stmt = conn.createStatement();
										
					// 쿼리 실행
					rs = stmt.executeQuery(query5);
					
					while (rs.next()){
						writer_id = rs.getString("writer_id");
						star = rs.getString("star");
						comment = rs.getString("comment");
					}
					
					if (writer_id != null) {
						%>
						<p><%=writer_id%> <%=star%></p>
						<p><%=comment%></p>
						<%
					}
					%>	</div><%
					j++;
					if(ep_no[j] == null)
					break;
					
		}} catch (SQLException e){
			out.println(e.getMessage());
			e.printStackTrace();
	} finally {
		if(pstmt != null) try { pstmt.close(); } catch(SQLException e) {}
		
		// 사용한 Statement 종료
		if (rs != null) try {rs.close();} catch(SQLException e) {}
		if (stmt != null) try {stmt.close();} catch(SQLException e) {}
		if(conn != null) try { conn.close(); } catch(SQLException e) {}
	}
					%>
			</div>


		<div class="row col-12 col-m-12">
			<hr>
		</div>

		<!-- Footer -->
		<footer>
		<div class="row col-12 col-m-12 w3-center">
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