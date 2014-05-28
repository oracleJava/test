<%@page import="java.net.URL"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<!-- Include required JS files -->
<script type="text/javascript" src="${basePath}/js/shCore.js"></script>
 
<!--
    At least one brush, here we choose JS. You need to include a brush for every 
    language you want to highlight
-->
<script type="text/javascript" src="${basePath}/js/shBrushJava.js"></script>
 
<!-- Include *at least* the core style and default theme -->
<link href="${basePath}/css/shCore.css" rel="stylesheet" type="text/css" />
<link href="${basePath}/css/shThemeDefault.css" rel="stylesheet" type="text/css" />

<!-- Finally, to actually run the highlighter, you need to include this JS on your page -->
<script type="text/javascript">
     SyntaxHighlighter.all()
</script>
</head>
<body>
<pre class="brush: java">
package self.dreammaker.servlet.feature.annotation;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(
		name = "entryServlet3",
        urlPatterns = {"/servlet/3"},
        initParams = {
				@WebInitParam(name="",value=""),
				@WebInitParam(name="",value="")})
public class EntryServlet3 extends HttpServlet {

	@Override
	public void init(ServletConfig config) throws ServletException {
		// TODO Auto-generated method stub
		super.init(config);
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String nextPage = req.getServletContext().getAttribute("basePath")+"/jsp/servlet3/featureList.jsp";
		resp.addHeader("refresh", "5;url="+nextPage); 
		PrintWriter out = resp.getWriter();
		out.write("welcome to servlet 3,5秒后自动跳转");
	}

}

</pre>
</body>
</html>