<%@page contentType="text/html; charset=UTF-8" %>
<html>
<body>
<h2>Hello World!</h2>
<h3>Server info:<%=application.getServerInfo() %></h3>
<h3>Servlet version:<%=application.getMajorVersion() %>.<%=application.getMajorVersion() %></h3>
<h3>JSP version:<%=JspFactory.getDefaultFactory().getEngineInfo().getSpecificationVersion()%></h3>
<h3>
<% 
  //String basePath = "http://"+request.getLocalAddr()+":"+request.getLocalPort()+request.getContextPath();
  //application.setAttribute("basePath", basePath); 
%>
${basePath}
</h3>
<h3><a href="servlet/3">进入servlet3</a></h3>

</body>
</html>
