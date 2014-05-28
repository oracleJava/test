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
