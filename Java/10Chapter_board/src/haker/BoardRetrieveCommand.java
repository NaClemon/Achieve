package haker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import haker.BoardDAO;
import haker.BoardDTO;


public class BoardRetrieveCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		BoardDAO dao = new BoardDAO();
		BoardDTO data = dao.retrieve(num);
		
		request.setAttribute("retrieve", data);
	}
}