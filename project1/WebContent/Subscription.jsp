<%@page contentType="text/html; charset=euc-kr" errorPage="DBError.jsp" %>
<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("EUC-KR");
    String name = request.getParameter("name");
    String id = request.getParameter("id");
    String password = request.getParameter("pw");
    if (name == null || id == null || password == null) 
        throw new Exception("데이터를 입력하십시오.");
    Connection conn = null;
    Statement stmt = null;
	String command;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/sys?characterEncoding=euc-kr&serverTimezone=Asia/Seoul", "root", "1234");
        if (conn == null)
            throw new Exception("데이터베이스에 연결할 수 없습니다.");
        stmt = conn.createStatement();
		command = String.format("insert into membership_info " +
					  "(name, id, password) values ('%s', '%s', '%s');",
					  name, id, password);
        int rowNum = stmt.executeUpdate(command);
        if (rowNum < 1)
            throw new Exception("데이터를 DB에 입력할 수 없습니다.");
    }
    finally {
        try { 
            stmt.close();
        } 
        catch (Exception ignored) {
        }
        try { 
            conn.close();
        } 
        catch (Exception ignored) {
        }
    }
    response.sendRedirect("SubscriptionResult.jsp");
%>
