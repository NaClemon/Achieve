package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;

public class UserDAO {
	ResultSet rs;
	
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
	
	
	public int login(String userID, String userPassword) {
		 
		try {
			connect();
			String SQL = "SELECT userPassword FROM schedule WHERE userID = ?";
			pstmt = con.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword))
					return 1;		//�α����� ������ ���
				else
					return 0;		//��й�ȣ�� ���� �ʴ� ���
			}
			return -1;		//���̵� �����
		}  
		catch (Exception e)
		{
			 e.printStackTrace();
			
		} finally {
			disconnect();
		}
		
		//��� ����Ȯ��---------->
		System.out.println("123123");
		return -2;		//������ ���̽� ���� �Դϴ�
		
	}
	
	public int join(User user) {
		
		try {
			connect();
			String SQL = " INSERT INTO schedule (userID, userPassword, userName, userEmail, userGender, userHeight, userWeight, number) VALUES(?,?,?,?,?,?,?,?)";
			pstmt=con.prepareStatement(SQL);
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
		} finally {
			disconnect();
		}
		return -1;		//���̵� ���� ���
	}
}

