package com.service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.dao.BoardDAO;

public class BoardWriteCommand implements BoardCommand {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) {
		
		String nickname = request.getParameter( "nickname" );
		String age = request.getParameter( "age" );
				String title = request.getParameter( "title" );
				String author = request.getParameter( "author" );
				String content = request.getParameter( "content" );


				BoardDAO dao = new BoardDAO();
				dao.write(nickname, age, title, author , content );
		

	}

}
