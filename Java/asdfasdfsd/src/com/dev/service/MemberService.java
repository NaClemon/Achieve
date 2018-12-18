package com.dev.service;

import com.dev.dao.MemberDAO;
import com.dev.vo.MemberVO;
import java.util.ArrayList;

public class MemberService {
	
		private static MemberService service = new MemberService();
		public MemberDAO dao = MemberDAO.getInstance();
		
		private MemberService() {}
		public static MemberService getInstance() {
			return service;
		}
		
		public void memberInsert(MemberVO member) {
			dao.memberInsert(member);
		}
		
		public ArrayList<MemberVO> memberList()
		{
			ArrayList<MemberVO> list = dao.memberList();
			return list;
		}
}
