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
<h3>NonAsyncServlet.java</h3>
<pre class="brush:java">
package self.dreammaker.servlet.feature.async;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/servlet/3/nonAsync")
public class NonAsyncServlet extends HttpServlet {

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
		long startTime = System.currentTimeMillis();
		System.out.println("NonAsyncServlet start at thread "
		        +Thread.currentThread().getName()+"with id of"
				+Thread.currentThread().getId());
		
		String time = req.getParameter("time");
		int secs = Integer.valueOf(time);
		if(secs > 10000){
			secs = 10000;
		}
		
		longProcessing(secs);
		
		PrintWriter out = resp.getWriter();
		long endTime = System.currentTimeMillis();
		out.write("Processing done for " + secs + " milliseconds!");
		System.out.println("NonAyncServlet take "+(endTime-startTime)+" ms.");
	}
	
	protected void longProcessing(int secs){
		try {
			Thread.sleep(secs);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
</pre>
<h3>AsyncServlet.java</h3>
<pre class="brush:java">
package self.dreammaker.servlet.feature.async;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.ThreadPoolExecutor;

import javax.servlet.AsyncContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns="/servlet/3/async",asyncSupported=true)
public class AsyncServlet extends HttpServlet {

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
		long startTime = System.currentTimeMillis();
		System.out.println("AsyncServlet start at thread "
		        +Thread.currentThread().getName()+"with id of"
				+Thread.currentThread().getId());
		
		req.setAttribute("org.apache.catalina.ASYNC_SUPPORTED", true);
		
		String time = req.getParameter("time");
		int secs = Integer.valueOf(time);
		if(secs > 10000){
			secs = 10000;
		}
		
		AsyncContext asyncCtx = req.startAsync();
		asyncCtx.addListener(new AppAsyncListener());
		asyncCtx.setTimeout(9000);
		
        ThreadPoolExecutor executor = (ThreadPoolExecutor) req
                .getServletContext().getAttribute("executor");
 
        executor.execute(new AsyncRequestProcessor(asyncCtx, secs));
		
		PrintWriter out = resp.getWriter();
		long endTime = System.currentTimeMillis();
		out.write("Processing done for " + secs + " milliseconds!");
		System.out.println("AyncServlet take "+(endTime-startTime)+" ms.");
	}

}

</pre>
<h3>AppContextListener.java</h3>
<pre class="brush:java">
package self.dreammaker.servlet.feature.async;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// TODO Auto-generated method stub
        ThreadPoolExecutor executor = new ThreadPoolExecutor(100, 200, 50000L,
                TimeUnit.MILLISECONDS, new ArrayBlockingQueue<Runnable>(100));
        sce.getServletContext().setAttribute("executor",
                executor);
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
        ThreadPoolExecutor executor = (ThreadPoolExecutor) sce
                .getServletContext().getAttribute("executor");
        executor.shutdown();
	}

}
</pre>
<h3>AppAsyncListener.java</h3>
<pre class="brush:java">
package self.dreammaker.servlet.feature.async;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.AsyncEvent;
import javax.servlet.AsyncListener;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebListener;

@WebListener
public class AppAsyncListener implements AsyncListener {

	@Override
	public void onComplete(AsyncEvent event) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("AppAsyncListener onComplete");
	}

	@Override
	public void onTimeout(AsyncEvent event) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("AppAsyncListener onTimeout");
		ServletResponse response = event.getAsyncContext().getResponse();
        PrintWriter out = response.getWriter();
        out.write("TimeOut Error in Processing");
	}

	@Override
	public void onError(AsyncEvent event) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("AppAsyncListener onError");
	}

	@Override
	public void onStartAsync(AsyncEvent event) throws IOException {
		// TODO Auto-generated method stub
		System.out.println("AppAsyncListener onStartAsync");
	}

}
</pre>
<h3>AsyncRequestProcessor.java</h3>
<pre class="brush:java">
package self.dreammaker.servlet.feature.async;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.AsyncContext;

public class AsyncRequestProcessor implements Runnable {
    
	private AsyncContext asyncContext;
	private int secs;
	
	public AsyncRequestProcessor(){
		
	}
	
	public AsyncRequestProcessor(AsyncContext asyncCtx, int secs){
		this.asyncContext = asyncCtx;
		this.secs = secs;
	}
	@Override
	public void run() {
		// TODO Auto-generated method stub
        System.out.println("Async Supported? "
                + asyncContext.getRequest().isAsyncSupported());
        longProcessing(secs);
        try {
            PrintWriter out = asyncContext.getResponse().getWriter();
            out.write("Processing done for " + secs + " milliseconds!!");
        } catch (IOException e) {
            e.printStackTrace();
        }
        //complete the processing
        asyncContext.complete();        
	}
    
	private void longProcessing(int secs){
		try {
			Thread.sleep(secs);
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

</pre>
</body>
</html>