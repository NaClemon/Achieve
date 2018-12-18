package com.dev.dao;

import java.sql.*;
import java.util.ArrayList;

import com.dev.vo.MemberVO;


public class MemberDAO {
	
	private static MemberDAO dao = new MemberDAO();
	private MemberDAO() {}
	public static MemberDAO getInstance() {
		return dao;
	}
	
	public Connection connect() {
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dbproject","root","tmvjswl@2877");
			System.out.println("연ㄴ결됨");
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
	
	public void memberInsert(MemberVO member)
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = connect();
			pstmt = conn.prepareStatement("insert into member values(?,?,?,?)");
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPasswd());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getMail());
			pstmt.executeUpdate();
			System.out.println("dddd");
		}catch (Exception ex)
		{
			System.out.println("오류 발생 : "+ex);
		}
		finally {
			close(conn,pstmt);
		}
	}
	
	public ArrayList<MemberVO> memberList(){
		ArrayList<MemberVO>list = new ArrayList<MemberVO>();
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		MemberVO member = null;
		try {
			conn = connect();
			pstmt = conn.prepareStatement("select * from game");
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				member = new MemberVO();
				member.setGame_id(rs.getInt(1));
				member.setGame_name(rs.getString(2));
				member.setGame_price(rs.getInt(3));
				member.setGame_date(rs.getString(4));
				member.setGame_dev(rs.getString(5));
				member.setGame_pub(rs.getString(6));
				member.setGame_cont(rs.getString(7));
				member.setImg_url(rs.getString(8));
				
				list.add(member);
			}
		}catch(Exception ex) {
			System.out.println("오류 발생 : "+ex);
		}finally {
			close(conn, pstmt,rs);
		}
		return list;
	}
}
