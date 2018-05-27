package haker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import haker.BoardDAO;
import haker.PageTO;

public class BoardPageCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		int curPage = 1;
		
		if(request.getParameter("curPage")!=null) {
			curPage = Integer.parseInt(request.getParameter("curPage"));
		}
		BoardDAO dao = new BoardDAO();
		PageTO list = dao.page(curPage);
		request.setAttribute("list", list.getList());
		request.setAttribute("page", list);
	}
}