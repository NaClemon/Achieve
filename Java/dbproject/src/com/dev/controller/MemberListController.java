package com.dev.controller;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.http.*;

import com.dev.service.GameService;
import com.dev.vo.GameVO;

public class MemberListController implements Controller {
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		GameService service = GameService.getInstance();
		ArrayList<GameVO> list = service.gameList();
		
		request.setAttribute("list", list);
		HttpUtil.forward(request, response, "GameList.jsp");
	}
	
}
