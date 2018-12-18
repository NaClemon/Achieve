package com.dev.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

import com.dev.service.GameService;
import com.dev.vo.GameVO;


public class MemberInsertController implements Controller{
	public void excute(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		
		String id =request.getParameter("id");
		String passwd = request.getParameter("passwd");
		String name = request.getParameter("name");
		String mail = request.getParameter("mail");
		
		//유효성 체크 
		if(id.isEmpty() || passwd.isEmpty()||name.isEmpty()||mail.isEmpty())
		{
			request.setAttribute("error","모든항목을 입력해주세요.");
			HttpUtil.forward(request, response, "/memberInsert.jsp");
			return ;
		}
		
		//VO 객체에 데이터 바인딩 
		GameVO member =new GameVO();
		
		//Service객체의 메소드 호출
		GameService service = GameService.getInstance();
		//service.memberInsert(member);
		
		//Output view 페이지로 이동
		request.setAttribute("id", id);
		HttpUtil.forward(request, response, "/result/memberInsertOutput.jsp");
		
		
	}
}
