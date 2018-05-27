package haker;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import haker.BoardDAO;
import haker.BoardDTO;


public class BoardSearchCommand implements BoardCommand{
   
   public void execute(HttpServletRequest request,HttpServletResponse response) {
      
      String searchName = request.getParameter("searchName");
      String searchValue = request.getParameter("searchValue");
      
      BoardDAO dao = new BoardDAO();
      ArrayList<BoardDTO>list=dao.search(searchName, searchValue);
      
      request.setAttribute("list",list);
   }

}