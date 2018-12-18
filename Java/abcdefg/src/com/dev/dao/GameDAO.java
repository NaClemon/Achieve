package com.dev.dao;

import java.sql.*;
import java.util.ArrayList;

import com.dev.vo.GameVO;


public class GameDAO {
	
	private static GameDAO dao = new GameDAO();
	private GameDAO() {}
	public static GameDAO getInstance() {
		return dao;
	}
	
	public Connection connect() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbproject","root","tmvjswl@2877");
		}catch (Exception e) {
			System.out.println("오류 발생 : "+e);
		}
		return conn;
	}
	
	public void close(Connection conn,PreparedStatement ps,ResultSet rs) {
		if(rs !=null) {
			try {
				rs.close();
			}catch (Exception ex)
			{
				System.out.println("오류 발생 : "+ ex);
			}
		}
		close(conn,ps);
	}
	public void close(Connection conn, PreparedStatement ps) {
		
		if(ps !=null) {
			try {
				ps.close();
			}catch (Exception ex)
			{
				System.out.println("오류 발생 : "+ ex);
			}
		}
		if(conn !=null) {
			try {
				conn.close();
			}catch (Exception ex)
			{
				System.out.println("오류 발생 : " +ex);
			}
		}
	}
	
	public ArrayList<GameVO> gameList(){
		ArrayList<GameVO>list = new ArrayList<GameVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		GameVO game = null;
		try {
			conn = connect();
			pstmt = conn.prepareStatement("select name, price, release, img_url from game_detail");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				game = new GameVO();
				game.setGame_name(rs.getString(1));
				game.setGame_price(rs.getInt(2));
				game.setGame_date(rs.getString(3));
				game.setImg_url(rs.getString(4));
				
				list.add(game);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<GameVO> selectGenreGameList(GameVO temp_game)
	{
		ArrayList<GameVO>list = new ArrayList<GameVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GameVO game = null;
		
		try {
			conn = connect();
			
			if (temp_game.getGenre_name() == "선택" && temp_game.getGame_name() == "")
				pstmt = conn.prepareStatement("select name, price, date, img_url from game_genre_view");
			else if (temp_game.getGenre_name() == "선택")
				pstmt = conn.prepareStatement("select name, price, date, img_url from game_genre_view where name like '%" + temp_game.getGame_name() + "%' group by name");
			else if (temp_game.getGame_name() == "")
				pstmt = conn.prepareStatement("select name, price, date, img_url from game_genre_view where genre = '" + temp_game.getGenre_name() + "' group by name");
			else
				pstmt = conn.prepareStatement("select name, price, date, img_url from game_genre_view where genre = '" + temp_game.getGenre_name() + "and name like '%" + temp_game.getGame_name() + "%' group by name");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				game = new GameVO();
				game.setGame_name(rs.getString(1));
				game.setGame_price(rs.getInt(2));
				game.setGame_date(rs.getString(3));
				game.setImg_url(rs.getString(4));
				
				list.add(game);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
}
