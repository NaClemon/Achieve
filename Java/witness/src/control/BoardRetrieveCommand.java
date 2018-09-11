package control;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import control.BoardDAO;
import control.BoardDTO;


public class BoardRetrieveCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		BoardDAO dao = new BoardDAO();
		BoardDAO dao2 = new BoardDAO();
		BoardDTO data = dao.retrieve(num);
		ArrayList<BoardDTO> list = dao2.list();
		System.out.println(list.size());
		
		request.setAttribute("list", list);
		
		request.setAttribute("retrieve", data);
	}
}