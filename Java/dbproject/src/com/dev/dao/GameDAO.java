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
	
	public ArrayList<GameVO> gameDetail(GameVO temp_game)
	{
		ArrayList<GameVO>list = new ArrayList<GameVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		GameVO game = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select gd.name, gd.price, gd.release, gd.development, gd.publisher, gd.explain, gd.img_url, "
					+ "msv.min_os, msv.min_processor, msv.min_mem, msv.min_graphic, "
					+ "rsv.rec_os, rsv.rec_processor, rsv.rec_mem, rsv.rec_graphic from game_detail as gd"
					+ " join min_spec_view as msv on gd.game_id = msv.game_id"
					+ " join rec_spec_view as rsv on gd.game_id = rsv.game_id"
					+ " where gd.game_id = " + temp_game.getGame_id());
			
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				game = new GameVO();
				game.setGame_name(rs.getString(1));
				game.setGame_price(rs.getInt(1));
				game.setGame_date(rs.getString(1));
				game.setGame_dev(rs.getString(1));
				game.setGame_pub(rs.getString(1));
				game.setGame_cont(rs.getString(1));
				game.setGame_url(rs.getString(1));
				game.setGame_min_os(rs.getString(1));
				game.setGame_min_processor(rs.getString(1));
				game.setGame_min_mem(rs.getString(1));
				game.setGame_min_graphic(rs.getString(1));
				game.setGame_rec_os(rs.getString(1));
				game.setGame_rec_processor(rs.getString(1));
				game.setGame_rec_mem(rs.getString(1));
				game.setGame_rec_graphic(rs.getString(1));
				
				list.add(game);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> cpuList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO cpu = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, core, thread, socket, img_url1, img_url2 from cpu");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				cpu = new ComputerVO();
				cpu.setCpu_name(rs.getString(1));
				cpu.setCpu_price(rs.getInt(2));
				cpu.setCpu_core(rs.getInt(3));
				cpu.setCpu_thread(rs.getInt(4));
				cpu.setCpu_socket(rs.getString(5));
				cpu.setCpu_img_url1(rs.getString(6));
				cpu.setCpu_img_url2(rs.getString(7));
				
				list.add(cpu);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> ramList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO ram = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price_16, price_8, ddr, clock, img_url1, img_url2 from ram");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				ram = new ComputerVO();
				ram.setRam_name(rs.getString(1));
				ram.setRam_price16(rs.getInt(2));
				ram.setRam_price8(rs.getInt(3));
				ram.setRam_ddr(rs.getString(4));
				ram.setRam_clock(rs.getString(5));
				ram.setRam_img_url1(rs.getString(6));
				ram.setRam_img_url2(rs.getString(7));
				
				list.add(ram);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> vgaList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO vga = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, manufacturer, model, memory, img_url1, img_url2 from vga");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				vga = new ComputerVO();
				vga.setVga_name(rs.getString(1));
				vga.setVga_price(rs.getInt(2));
				vga.setVga_manufacturer(rs.getString(3));
				vga.setVga_model(rs.getString(4));
				vga.setVga_memory(rs.getInt(5));
				vga.setVga_img_url1(rs.getString(6));
				vga.setVga_img_url2(rs.getString(7));
				
				list.add(vga);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> caseList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO case = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, type, standard, img_url1, img_url2 from case");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				case = new ComputerVO();
				case.setCase_name(rs.getString(1));
				case.setCase_price(rs.getInt(2));
				case.setCase_type(rs.getString(3));
				case.setCase_standard(rs.getString(4));
				case.setCase_img_url1(rs.getString(5));
				case.setCase_img_url2(rs.getString(6));
				
				list.add(case);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> hddList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO hdd = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, storage, manufacturer, type, img_url from hdd");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				hdd = new ComputerVO();
				hdd.setHdd_name(rs.getString(1));
				hdd.setHdd_price(rs.getInt(2));
				hdd.setHdd_storage(rs.getString(3));
				hdd.setHdd_manufacturer(rs.getString(4));
				hdd.setHdd_type(rs.getString(5));
				hdd.setHdd_img_url(rs.getString(6));
				
				list.add(hdd);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> ssdList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO ssd = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, storage, company, type, img_url from ssd");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				ssd = new ComputerVO();
				ssd.setSsd_name(rs.getString(1));
				ssd.setSsd_price(rs.getInt(2));
				ssd.setSsd_storage(rs.getString(3));
				ssd.setSsd_company(rs.getString(4));
				ssd.setSsd_type(rs.getString(5));
				ssd.setSsd_img_url(rs.getString(6));
				
				list.add(ssd);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> powerList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO power = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, output, type, img_url from power");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				power = new ComputerVO();
				power.setPower_name(rs.getString(1));
				power.setPower_price(rs.getInt(2));
				power.setPower_output(rs.getString(3));
				power.setPower_type(rs.getString(4));
				power.setPower_img_url(rs.getString(5));
				
				list.add(power);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
	
	public ArrayList<ComputerVO> mainboardList()
	{
		ArrayList<ComputerVO>list = new ArrayList<ComputerVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ComputerVO mb = null;
		
		try {
			conn = connect();
			
			pstmt = conn.prepareStatement("select name, price, support_cpu, standard, socket, chipset, img_url1, img_url2 from mainboard");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				mb = new ComputerVO();
				mb.setMainboard_name(rs.getString(1));
				mb.setMainboard_price(rs.getInt(2));
				mb.setMainboard_support_cpu(rs.getString(3));
				mb.setMainboard_standard(rs.getString(4));
				mb.setMainboard_socket(rs.getString(5));
				mb.setMainboard_chipset(rs.getString(6));
				mb.setMainboard_img_url1(rs.getString(7));
				mb.setMainboard_img_url2(rs.getString(8));
				
				list.add(mb);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
}
