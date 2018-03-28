package practice.ch4;

import java.io.IOException;
import java.io.PrintWriter;							// 브라우저 출력을 위한 출력 스트림 객체
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class TeamInform
 */
@WebServlet(description = "팀 정보 서블릿", urlPatterns = { "/TeamInform" })
public class TeamInform extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");					// 파라미터로 전달되는 데이터의 한글 처리
		response.setContentType("text/html; charset=UTF-8");	// 브라우저로 보내지는 데이터의 한글 처리
		response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		
		out.println("<html><body>");
		out.println("<h1>팀원 정보</h1>");
		
		/* 테이블을 통한 멤버 정보 출력 */
		/* 내용들은 가운데 정렬 */
		out.println("<table border=1><tr>");						
		out.println("<th></th>");
		
		/* 이미지 소스(상대 경로)를 통해 이미지 출력 및 사이즈 조정 */
		out.println("<td><img src=ch4/jawoong.jpg width=120 height=120></td>");
		out.println("<td><img src=ch4/wooseok.jpg width=120 height=120></td>");
		out.println("<td><img src=ch4/gwangho.jpg width=120 height=120></td></tr>");
		
		/* 팀원 이름 출력 */
		out.println("<tr><th>이름</th>");
		out.println("<th>최재웅</th>");
		out.println("<th>조우석</th>");
		out.println("<th>손광호</th></tr>");
		
		/* 소속 학과 출력 */
		out.println("<tr><th>학과</th>");
		out.println("<td align=center>소프트웨어학과</td>");
		out.println("<td align=center>소프트웨어학과</td>");
		out.println("<td align=center>소프트웨어학과</td></tr>");
		
		/* 학번 출력 */
		out.println("<tr><th>학번</th>");
		out.println("<td align=center>2013041049</td>");
		out.println("<td align=center>2014041020</td>");
		out.println("<td align=center>2014041030</td></tr>");

		/* 나이 출력 */
		out.println("<tr><th>나이</th>");
		out.println("<td align=center>27</td>");
		out.println("<td align=center>24</td>");
		out.println("<td align=center>24</td></tr>");
		
		/* 고향 출력 */
		out.println("<tr><th>사는 지역</th>");
		out.println("<td align=center>서울</td>");
		out.println("<td align=center>대전</td>");
		out.println("<td align=center>이천</td></tr>");
		
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
