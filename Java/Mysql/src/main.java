import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class main {
	// STEP 1: DB Configuration
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_address = "jdbc:mysql://localhost:3306/hw2?useSSL=false";
	
	static final String USER = "root";
	static final String PASS = "";
	
	public static void main(String[] args){
		Connection conn = null;
		
		try{
			Class.forName(JDBC_DRIVER);
			
			conn = DriverManager.getConnection(DB_address, USER, PASS);
			
			Statement stmt = conn.createStatement();
			
			String sql;
			
			sql = "insert into simple_re values (12, 20000000, 30), (13, 5000000, 7)";
			stmt.executeUpdate(sql);
			
			sql = "update manage_branch set branch_num = 6 where company_num = 12";
			stmt.executeUpdate(sql);
			
			sql = "select * from company_emp where company like '%o%'";
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3));
			}
			
			rs.close();
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error occured.");
		}
	}
}
