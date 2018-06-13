package control;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import control.BoardDAO;


public class BoardDeleteCommand implements BoardCommand {
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		String num = request.getParameter("num");
		
        BoardDAO  dao = new BoardDAO();
        dao.delete( num );
	}
}