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
