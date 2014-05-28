package self.dreammaker.servlet.feature.annotation;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;

@WebFilter(
		filterName="constInitFilter",
		urlPatterns={"/*"})
public class ConstInitFilter implements Filter {
	public final static String BASE_PATH = "basePath";

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
        System.out.println("========ConstInitFilter init=========");
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		// TODO Auto-generated method stub
		ServletContext context = request.getServletContext();
		String basePath = "http://"+request.getLocalAddr()+":"+request.getLocalPort()+context.getContextPath();
		context.setAttribute(BASE_PATH, basePath);
		chain.doFilter(request, response);
	}

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		System.out.println("========ConstInitFilter destroy=========");
	}

}
