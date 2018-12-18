package com.dev.service;

import com.dev.dao.GameDAO;
import com.dev.vo.GameVO;

import java.util.ArrayList;

public class GameService {
	
		private static GameService service = new GameService();
		public GameDAO dao = GameDAO.getInstance();
		
		private GameService() {}
		public static GameService getInstance() {
			return service;
		}
		
		public ArrayList<GameVO> gameSelect(GameVO member) {
			ArrayList<GameVO> list = dao.selectGenreGameList(member);
			return list;
		}
		
		public ArrayList<GameVO> gameList()
		{
			ArrayList<GameVO> list = dao.gameList();
			return list;
		}
}
