<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@page import="java.io.*, java.util.Date"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Insert title here</title>
</head>
<body>
	<H2>글쓰기</H2>
	<%
		request.setCharacterEncoding("euc-kr");
		String rating = request.getParameter("rating");
		String comment = request.getParameter("comment");
		Date date= new Date();
		Long time = date.getTime();
		String filename = time + ".txt";
		PrintWriter writer = null;
		
		try {
			String filePath= application.getRealPath("/WEB-INF/rating/" + filename);
			writer = new PrintWriter(filePath);
			writer.printf("별점: %s %n", rating);
			writer.printf("한줄평: %s %n", comment);
			out.println("저장되었습니다.");
		}
		catch (IOException ioe) {
			out.println("파일에 데이터를 쓸 수 없습니다.");
		}
		finally {
			try {
				writer.close();
			}
			catch (Exception e) {
			}
		}
	%>
</body>
</html>