package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import control.BoardDAO;
import control.BoardDTO;

public class BoardWriteuiCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		BoardDAO dao = new BoardDAO();
		ArrayList<BoardDTO> list = dao.list();
		System.out.println(list.size());
		request.setAttribute("list", list);
	}
}