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
<form action="${basePath}/servlet/3/upload" method="post" enctype="multipart/form-data">
  username:<input type="text" name="username">
  yourfile:<input type="file" name="yourfile">
  <input type="submit" value="submit"> 
</form>
<br>
<h3 onclick="">source</h3>
<p>jsp</p>
<pre class="brush:java">
<form action="${basePath}/servlet/3/upload" method="post" enctype="multipart/form-data">
  username:<input type="text" name="username">
  yourfile:<input type="file" name="yourfile">
  <input type="submit" value="submit"> 
</form>
</pre>
<p>servlet</p>
<pre class="brush:java">
package self.dreammaker.servlet.feature.upload;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

@MultipartConfig(location="/filetemp"
		)
@WebServlet(
		name="uploadServlet",
		value={"/servlet/3/upload"})
public class UploadServlet extends HttpServlet {

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
		System.out.println(req.getParameter("username"));
		Part part = req.getPart("yourfile");
		System.out.println("文件类型："+part.getContentType());
		System.out.println("文件大小："+part.getSize());
		InputStream in = part.getInputStream();
		
		System.out.println("文件大小："+part.getInputStream());
	}

}

</pre>
</body>
</html>