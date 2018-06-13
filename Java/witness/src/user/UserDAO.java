package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.PreparedStatement;

public class UserDAO {
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/WITNESS";
			String dbID = "root";
			String dbPassword = "wodnd1234";
		    Class.forName("com.mysql.jdbc.Driver");
		    conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		   } catch (Exception e) {
		      e.printStackTrace();
		   }
	}
	
	public int login(String userID, String userPassword) {
		 String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;		//로그인을 성공한 경우
				else
					return 0;		//비밀번호가 맞지 않는 경우
			}
			return -1;		//아이디가 없어요
		}  
		catch (Exception e)
		{
			 e.printStackTrace();
			
		}
		
		//디비 연동확인---------->
		System.out.println("123123");
		return -2;		//데이터 베이스 오류 입니다
		
	}
	
	public int join(User user) {
		String SQL = " INSERT INTO USER VALUES(?,?,?,?,?,?.?)";
		try {
			pstmt=conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserName());
			pstmt.setString(4, user.getUserGender());
			pstmt.setString(5, user.getUserEmail());
			pstmt.setString(6, user.getUserHeight());
			pstmt.setString(7, user.getUserWeight());
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1;		//아이디가 없는 경우
	}
}

