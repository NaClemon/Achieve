package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import control.BoardDAO;
import control.BoardDTO;

public class BoardUpdateuiCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		BoardDAO dao = new BoardDAO();
		BoardDAO dao2 = new BoardDAO();
		ArrayList<BoardDTO> list = dao.list();
		BoardDTO data = dao2.retrieve(num);
		
		System.out.println(list.size());
		request.setAttribute("list", list);
		request.setAttribute("update", data);
	}
}