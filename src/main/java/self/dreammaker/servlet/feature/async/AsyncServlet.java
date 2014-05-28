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
