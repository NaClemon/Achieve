package haker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import haker.BoardDAO;
import haker.BoardDTO;

public class BoardListCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.list();
		System.out.println(list.size());
		request.setAttribute("list", list);
	}
}