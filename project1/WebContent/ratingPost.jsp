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
	<H2>�۾���</H2>
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
			writer.printf("����: %s %n", rating);
			writer.printf("������: %s %n", comment);
			out.println("����Ǿ����ϴ�.");
		}
		catch (IOException ioe) {
			out.println("���Ͽ� �����͸� �� �� �����ϴ�.");
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