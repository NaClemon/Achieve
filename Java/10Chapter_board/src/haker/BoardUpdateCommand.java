package haker;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import haker.BoardDAO;

public class BoardUpdateCommand implements BoardCommand {

   public void execute(HttpServletRequest request, HttpServletResponse response) {
      
      String num = request.getParameter("num");
      String title = request.getParameter("title");
      String author = request.getParameter("author");
      String nickname = request.getParameter("nickname"); // add 
      String age = request.getParameter("age"); //add
      String content = request.getParameter("content");
      
      
      BoardDAO dao = new BoardDAO();
      dao.update(num, title, author, content, nickname, age);
   }
}