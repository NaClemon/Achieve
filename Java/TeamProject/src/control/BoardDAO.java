package control;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC";
	
	void connect() {
		try {
			Class.forName(jdbc_driver);
			con = DriverManager.getConnection(jdbc_url, "root", "dbqldhk@038");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
		if(con != null) {
			try {
				con.close();
			} catch(SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public ArrayList<BoardDTO> list() {
		ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
		ResultSet rs = null;
		
		try {
			connect();
			
			String query = "SELECT num FROM schedule order by num asc";
			
			pstmt = con.prepareStatement(query);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				int num = rs.getInt("num");
				
				BoardDTO data = new BoardDTO();
				data.setNum(num);
				list.add(data);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		
		return list;
	}
	
	public void write(String mon_athle1_name, int mon_athle1_many, int mon_athle1_set, String mon_athle2_name, int mon_athle2_many, int mon_athle2_set, String mon_meal,
			String tue_athle1_name, int tue_athle1_many, int tue_athle1_set, String tue_athle2_name, int tue_athle2_many, int tue_athle2_set, String tue_meal,
			String wed_athle1_name, int wed_athle1_many, int wed_athle1_set, String wed_athle2_name, int wed_athle2_many, int wed_athle2_set, String wed_meal,
			String thu_athle1_name, int thu_athle1_many, int thu_athle1_set, String thu_athle2_name, int thu_athle2_many, int thu_athle2_set, String thu_meal,
			String fri_athle1_name, int fri_athle1_many, int fri_athle1_set, String fri_athle2_name, int fri_athle2_many, int fri_athle2_set, String fri_meal,
			String sat_athle1_name, int sat_athle1_many, int sat_athle1_set, String sat_athle2_name, int sat_athle2_many, int sat_athle2_set, String sat_meal,
			String sun_athle1_name, int sun_athle1_many, int sun_athle1_set, String sun_athle2_name, int sun_athle2_many, int sun_athle2_set, String sun_meal) {
		try {
			connect();
			String query = "INSERT INTO schedule (mon_athle1_name, mon_athle1_many, mon_athle1_set, mon_athle2_name, mon_athle2_many, mon_athle2_set, mon_meal,\r\n" + 
					"				tue_athle1_name, tue_athle1_many, tue_athle1_set, tue_athle2_name, tue_athle2_many, tue_athle2_set, tue_meal,\r\n" + 
					"				wed_athle1_name, wed_athle1_many, wed_athle1_set, wed_athle2_name, wed_athle2_many, wed_athle2_set, wed_meal,\r\n" + 
					"				thu_athle1_name, thu_athle1_many, thu_athle1_set, thu_athle2_name, thu_athle2_many, thu_athle2_set, thu_meal,\r\n" + 
					"				fri_athle1_name, fri_athle1_many, fri_athle1_set, fri_athle2_name, fri_athle2_many, fri_athle2_set, fri_meal,\r\n" + 
					"				sat_athle1_name, sat_athle1_many, sat_athle1_set, sat_athle2_name, sat_athle2_many, sat_athle2_set, sat_meal,\r\n" + 
					"				sun_athle1_name, sun_athle1_many, sun_athle1_set, sun_athle2_name, sun_athle2_many, sun_athle2_set, sun_meal) values \r\n" +
					"(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, mon_athle1_name);
			pstmt.setInt(2, mon_athle1_many);
			pstmt.setInt(3, mon_athle1_set);
			pstmt.setString(4, mon_athle2_name);
			pstmt.setInt(5, mon_athle2_many);
			pstmt.setInt(6, mon_athle2_set);
			pstmt.setString(7, mon_meal);
			pstmt.setString(8, tue_athle1_name);
			pstmt.setInt(9, tue_athle1_many);
			pstmt.setInt(10, tue_athle1_set);
			pstmt.setString(11, tue_athle2_name);
			pstmt.setInt(12, tue_athle2_many);
			pstmt.setInt(13, tue_athle2_set);
			pstmt.setString(14, tue_meal);
			pstmt.setString(15, wed_athle1_name);
			pstmt.setInt(16, wed_athle1_many);
			pstmt.setInt(17, wed_athle1_set);
			pstmt.setString(18, wed_athle2_name);
			pstmt.setInt(19, wed_athle2_many);
			pstmt.setInt(20, wed_athle2_set);
			pstmt.setString(21, wed_meal);
			pstmt.setString(22, thu_athle1_name);
			pstmt.setInt(23, thu_athle1_many);
			pstmt.setInt(24, thu_athle1_set);
			pstmt.setString(25, thu_athle2_name);
			pstmt.setInt(26, thu_athle2_many);
			pstmt.setInt(27, thu_athle2_set);
			pstmt.setString(28, thu_meal);
			pstmt.setString(29, fri_athle1_name);
			pstmt.setInt(30, fri_athle1_many);
			pstmt.setInt(31, fri_athle1_set);
			pstmt.setString(32, fri_athle2_name);
			pstmt.setInt(33, fri_athle2_many);
			pstmt.setInt(34, fri_athle2_set);
			pstmt.setString(35, fri_meal);
			pstmt.setString(36, sat_athle1_name);
			pstmt.setInt(37, sat_athle1_many);
			pstmt.setInt(38, sat_athle1_set);
			pstmt.setString(39, sat_athle2_name);
			pstmt.setInt(40, sat_athle2_many);
			pstmt.setInt(41, sat_athle2_set);
			pstmt.setString(42, sat_meal);
			pstmt.setString(43, sun_athle1_name);
			pstmt.setInt(44, sun_athle1_many);
			pstmt.setInt(45, sun_athle1_set);
			pstmt.setString(46, sun_athle2_name);
			pstmt.setInt(47, sun_athle2_many);
			pstmt.setInt(48, sun_athle2_set);
			pstmt.setString(49, sun_meal);
			
			int n = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	
	public void update(String num, String mon_athle1_name, int mon_athle1_many, int mon_athle1_set, String mon_athle2_name, int mon_athle2_many, int mon_athle2_set, String mon_meal,
			String tue_athle1_name, int tue_athle1_many, int tue_athle1_set, String tue_athle2_name, int tue_athle2_many, int tue_athle2_set, String tue_meal,
			String wed_athle1_name, int wed_athle1_many, int wed_athle1_set, String wed_athle2_name, int wed_athle2_many, int wed_athle2_set, String wed_meal,
			String thu_athle1_name, int thu_athle1_many, int thu_athle1_set, String thu_athle2_name, int thu_athle2_many, int thu_athle2_set, String thu_meal,
			String fri_athle1_name, int fri_athle1_many, int fri_athle1_set, String fri_athle2_name, int fri_athle2_many, int fri_athle2_set, String fri_meal,
			String sat_athle1_name, int sat_athle1_many, int sat_athle1_set, String sat_athle2_name, int sat_athle2_many, int sat_athle2_set, String sat_meal,
			String sun_athle1_name, int sun_athle1_many, int sun_athle1_set, String sun_athle2_name, int sun_athle2_many, int sun_athle2_set, String sun_meal) {
		try {
			connect();
			String query = "UPDATE schedule SET mon_athle1_name=?, mon_athle1_many=?, mon_athle1_set=?, mon_athle2_name=?, mon_athle2_many=?, mon_athle2_set=?, mon_meal=?,\r\n" + 
					"				tue_athle1_name=?, tue_athle1_many=?, tue_athle1_set=?, tue_athle2_name=?, tue_athle2_many=?, tue_athle2_set=?, tue_meal=?,\r\n"+ 
					"wed_athle1_name=?, wed_athle1_many=?, wed_athle1_set=?, wed_athle2_name=?, wed_athle2_many=?, wed_athle2_set=?, wed_meal=?,\r\n"+ 
					"thu_athle1_name=?, thu_athle1_many=?, thu_athle1_set=?, thu_athle2_name=?, thu_athle2_many=?, thu_athle2_set=?, thu_meal=?,\r\n"+ 
					"fri_athle1_name=?, fri_athle1_many=?, fri_athle1_set=?, fri_athle2_name=?, fri_athle2_many=?, fri_athle2_set=?, fri_meal=?,\r\n" + 
					"sat_athle1_name=?, sat_athle1_many=?, sat_athle1_set=?, sat_athle2_name=?, sat_athle2_many=?, sat_athle2_set=?, sat_meal=?,\r\n" + 
					"sun_athle1_name=?, sun_athle1_many=?, sun_athle1_set=?, sun_athle2_name=?, sun_athle2_many=?, sun_athle2_set=?, sun_meal=? WHERE num=?";
			
pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, mon_athle1_name);
			pstmt.setInt(2, mon_athle1_many);
			pstmt.setInt(3, mon_athle1_set);
			pstmt.setString(4, mon_athle2_name);
			pstmt.setInt(5, mon_athle2_many);
			pstmt.setInt(6, mon_athle2_set);
			pstmt.setString(7, mon_meal);
			pstmt.setString(8, tue_athle1_name);
			pstmt.setInt(9, tue_athle1_many);
			pstmt.setInt(10, tue_athle1_set);
			pstmt.setString(11, tue_athle2_name);
			pstmt.setInt(12, tue_athle2_many);
			pstmt.setInt(13, tue_athle2_set);
			pstmt.setString(14, tue_meal);
			pstmt.setString(15, wed_athle1_name);
			pstmt.setInt(16, wed_athle1_many);
			pstmt.setInt(17, wed_athle1_set);
			pstmt.setString(18, wed_athle2_name);
			pstmt.setInt(19, wed_athle2_many);
			pstmt.setInt(20, wed_athle2_set);
			pstmt.setString(21, wed_meal);
			pstmt.setString(22, thu_athle1_name);
			pstmt.setInt(23, thu_athle1_many);
			pstmt.setInt(24, thu_athle1_set);
			pstmt.setString(25, thu_athle2_name);
			pstmt.setInt(26, thu_athle2_many);
			pstmt.setInt(27, thu_athle2_set);
			pstmt.setString(28, thu_meal);
			pstmt.setString(29, fri_athle1_name);
			pstmt.setInt(30, fri_athle1_many);
			pstmt.setInt(31, fri_athle1_set);
			pstmt.setString(32, fri_athle2_name);
			pstmt.setInt(33, fri_athle2_many);
			pstmt.setInt(34, fri_athle2_set);
			pstmt.setString(35, fri_meal);
			pstmt.setString(36, sat_athle1_name);
			pstmt.setInt(37, sat_athle1_many);
			pstmt.setInt(38, sat_athle1_set);
			pstmt.setString(39, sat_athle2_name);
			pstmt.setInt(40, sat_athle2_many);
			pstmt.setInt(41, sat_athle2_set);
			pstmt.setString(42, sat_meal);
			pstmt.setString(43, sun_athle1_name);
			pstmt.setInt(44, sun_athle1_many);
			pstmt.setInt(45, sun_athle1_set);
			pstmt.setString(46, sun_athle2_name);
			pstmt.setInt(47, sun_athle2_many);
			pstmt.setInt(48, sun_athle2_set);
			pstmt.setString(49, sun_meal);
			pstmt.setInt(50, Integer.parseInt(num));
			
			int n = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	
	public void delete(String _num) {
		try {
			connect();
			String query = "Delete FROM schedule WHERE num = ?";
			
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(_num));
			int n = pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
	}
	
	public BoardDTO retrieve(String _num) {
		
		ResultSet rs = null;
		BoardDTO data = new BoardDTO();
		
		try {
			connect();
			String query = "SELECT * FROM schedule WHERE num = ?";
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, Integer.parseInt(_num));
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				int num = rs.getInt("num");
				String mon_athle1_name = rs.getString("mon_athle1_name");
				int mon_athle1_many = rs.getInt("mon_athle1_many");
				int mon_athle1_set = rs.getInt("mon_athle1_set");
				String mon_athle2_name = rs.getString("mon_athle2_name");
				int mon_athle2_many = rs.getInt("mon_athle2_many");
				int mon_athle2_set = rs.getInt("mon_athle2_set");
				String mon_meal = rs.getString("mon_meal");
				String tue_athle1_name = rs.getString("tue_athle1_name");
				int tue_athle1_many = rs.getInt("tue_athle1_many");
				int tue_athle1_set = rs.getInt("tue_athle1_set");
				String tue_athle2_name = rs.getString("tue_athle2_name");
				int tue_athle2_many = rs.getInt("tue_athle2_many");
				int tue_athle2_set = rs.getInt("tue_athle2_set");
				String tue_meal = rs.getString("tue_meal");
				String wed_athle1_name = rs.getString("wed_athle1_name");
				int wed_athle1_many = rs.getInt("wed_athle1_many");
				int wed_athle1_set = rs.getInt("wed_athle1_set");
				String wed_athle2_name = rs.getString("wed_athle2_name");
				int wed_athle2_many = rs.getInt("wed_athle2_many");
				int wed_athle2_set = rs.getInt("wed_athle2_set");
				String wed_meal = rs.getString("wed_meal");
				String thu_athle1_name = rs.getString("thu_athle1_name");
				int thu_athle1_many = rs.getInt("thu_athle1_many");
				int thu_athle1_set = rs.getInt("thu_athle1_set");
				String thu_athle2_name = rs.getString("thu_athle2_name");
				int thu_athle2_many = rs.getInt("thu_athle2_many");
				int thu_athle2_set = rs.getInt("thu_athle2_set");
				String thu_meal = rs.getString("thu_meal");
				String fri_athle1_name = rs.getString("fri_athle1_name");
				int fri_athle1_many = rs.getInt("fri_athle1_many");
				int fri_athle1_set = rs.getInt("fri_athle1_set");
				String fri_athle2_name = rs.getString("fri_athle2_name");
				int fri_athle2_many = rs.getInt("fri_athle2_many");
				int fri_athle2_set = rs.getInt("fri_athle2_set");
				String fri_meal = rs.getString("fri_meal");
				String sat_athle1_name = rs.getString("sat_athle1_name");
				int sat_athle1_many = rs.getInt("sat_athle1_many");
				int sat_athle1_set = rs.getInt("sat_athle1_set");
				String sat_athle2_name = rs.getString("sat_athle2_name");
				int sat_athle2_many = rs.getInt("sat_athle2_many");
				int sat_athle2_set = rs.getInt("sat_athle2_set");
				String sat_meal = rs.getString("sat_meal");
				String sun_athle1_name = rs.getString("sun_athle1_name");
				int sun_athle1_many = rs.getInt("sun_athle1_many");
				int sun_athle1_set = rs.getInt("sun_athle1_set");
				String sun_athle2_name = rs.getString("sun_athle2_name");
				int sun_athle2_many = rs.getInt("sun_athle2_many");
				int sun_athle2_set = rs.getInt("sun_athle2_set");
				String sun_meal = rs.getString("sun_meal");
				
				data.setNum(num);
				data.setMon_athle1_name(mon_athle1_name);
				data.setMon_athle1_many(mon_athle1_many);
				data.setMon_athle1_set(mon_athle1_set);
				data.setMon_athle2_name(mon_athle2_name);
				data.setMon_athle2_many(mon_athle2_many);
				data.setMon_athle2_set(mon_athle2_set);
				data.setMon_meal(mon_meal);
				data.setTue_athle1_name(tue_athle1_name);
				data.setTue_athle1_many(tue_athle1_many);
				data.setTue_athle1_set(tue_athle1_set);
				data.setTue_athle2_name(tue_athle2_name);
				data.setTue_athle2_many(tue_athle2_many);
				data.setTue_athle2_set(tue_athle2_set);
				data.setTue_meal(tue_meal);
				data.setWed_athle1_name(wed_athle1_name);
				data.setWed_athle1_many(wed_athle1_many);
				data.setWed_athle1_set(wed_athle1_set);
				data.setWed_athle2_name(wed_athle2_name);
				data.setWed_athle2_many(wed_athle2_many);
				data.setWed_athle2_set(wed_athle2_set);
				data.setWed_meal(wed_meal);
				data.setThu_athle1_name(thu_athle1_name);
				data.setThu_athle1_many(thu_athle1_many);
				data.setThu_athle1_set(thu_athle1_set);
				data.setThu_athle2_name(thu_athle2_name);
				data.setThu_athle2_many(thu_athle2_many);
				data.setThu_athle2_set(thu_athle2_set);
				data.setThu_meal(thu_meal);
				data.setFri_athle1_name(fri_athle1_name);
				data.setFri_athle1_many(fri_athle1_many);
				data.setFri_athle1_set(fri_athle1_set);
				data.setFri_athle2_name(fri_athle2_name);
				data.setFri_athle2_many(fri_athle2_many);
				data.setFri_athle2_set(fri_athle2_set);
				data.setFri_meal(fri_meal);
				data.setSat_athle1_name(sat_athle1_name);
				data.setSat_athle1_many(sat_athle1_many);
				data.setSat_athle1_set(sat_athle1_set);
				data.setSat_athle2_name(sat_athle2_name);
				data.setSat_athle2_many(sat_athle2_many);
				data.setSat_athle2_set(sat_athle2_set);
				data.setSat_meal(sat_meal);
				data.setSun_athle1_name(sun_athle1_name);
				data.setSun_athle1_many(sun_athle1_many);
				data.setSun_athle1_set(sun_athle1_set);
				data.setSun_athle2_name(sun_athle2_name);
				data.setSun_athle2_many(sun_athle2_many);
				data.setSun_athle2_set(sun_athle2_set);
				data.setSun_meal(sun_meal);
			}
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return data;
	}
}