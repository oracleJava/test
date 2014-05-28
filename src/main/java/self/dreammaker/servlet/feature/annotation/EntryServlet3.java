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
