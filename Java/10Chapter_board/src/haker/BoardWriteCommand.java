package haker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import haker.BoardDAO;


public class BoardWriteCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String title = request.getParameter("title");
		String author = request.getParameter("author");
		String content = request.getParameter("content");
		String nickname = request.getParameter("nickname");
		String age = request.getParameter("age");
		
		BoardDAO dao = new BoardDAO();
		dao.write(title, author, nickname, age, content);
	}
}