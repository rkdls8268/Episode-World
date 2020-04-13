<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
    <%@page import="java.sql.*" %> 
    <%@page session="true" %>
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
Class.forName("com.mysql.jdbc.Driver");

String jdbcDriver = "jdbc:mysql://localhost:3306/sys?characterEncoding=EUC-KR&serverTimezone=UTC";
String dbUser = "root";
String dbPw = "1234";

Connection conn = null;
PreparedStatement pstmt = null;
Statement stmt = null;
ResultSet rs = null;

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String id2 = null;
	String pw2 = null;
	String name = null;
	
	try {
		
		conn = DriverManager.getConnection(jdbcDriver, dbUser, dbPw);
        
		String query = "select * from sys.membership_info where id='" + id + "';";
	
		// Statement 생성
		stmt = conn.createStatement();
	
		// 쿼리 실행
		rs = stmt.executeQuery(query);
		
		while (rs.next()){
			id2 = rs.getString("id"); // id에 해당하는 값
			pw2 = rs.getString("password"); // 그 id의 비밀번호
			name = rs.getString("name");
		}
	
		// (id2 == null) || (pw != pw2)
		if ((id.equals(id2)) && (pw.equals(pw2))) {
			session.setAttribute("ID", id);
			/* request.setAttribute("ID", id); */
			session.setAttribute("NAME", name);
			/* request.setAttribute("NAME", name); */
			/* response.addCookie(Cookies.createCookie("AUTH", id, "/", -1)); */ // <- 쿠키로 로그인
		%>
		<script>
			 history.go(-1); // 데이터 저장은 잘 되어 있는데 새로고침해야 원하는 정보 얻을 수 있음.. ㅠㅠ
		</script>		
		<%
		} else {
		%>
		<script>
			alert("ID 또는 비밀번호가 올바르지 않습니다.");
			history.go(-1);
		</script>		
		<%
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
%>

</body>
</html>