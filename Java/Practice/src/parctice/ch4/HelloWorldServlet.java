package parctice.ch4;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class HelloWorldServlet
 */
@WebServlet(description = "처음 만드는 서블릿", urlPatterns = { "/HelloWorldServlet" })
public class HelloWorldServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out=response.getWriter();
		
		out.println("<html>");
		out.println("<body><h1>팀원 정보</h1>");
		out.println("<table border=1><tr>");
		out.println("<td><img src=c:\\\\Workspace\\\\Java\\\\Practice\\\\WebContent\\\\ch4\\\\jawoong.jpg></td>");
		out.println("<td><img src=c:\\\\Workspace\\\\Java\\\\Practice\\\\WebContent\\\\ch4\\\\wooseok.jpg></td></tr>");
		out.println("</ul>");
		out.println("</body></html>");
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
