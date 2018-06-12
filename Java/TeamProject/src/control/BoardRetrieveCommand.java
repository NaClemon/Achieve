package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import control.BoardDAO;
import control.BoardDTO;


public class BoardRetrieveCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		BoardDAO dao = new BoardDAO();
		BoardDTO data = dao.retrieve(num);
		
		request.setAttribute("retrieve", data);
	}
}