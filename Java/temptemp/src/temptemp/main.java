package temptemp;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class main {
	// STEP 1: DB Configuration
	static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
	static final String DB_address = "jdbc:mysql://localhost:3306/employees?useSSL=false";
	
	static final String USER = "root";
	static final String PASS = "";
	
	public static void main(String[] args){
		Connection conn = null;
		
		try{
			// STEP 2: Register JDBC Driver
			Class.forName(JDBC_DRIVER);
			
			// STEP 3: Open a connection
			System.out.println("Connecting to database...");
			conn = DriverManager.getConnection(DB_address, USER, PASS);
			
			// STEP 4: Create a statement object
			System.out.println("Creating statement...");
			Statement stmt = conn.createStatement();
			
			
			// STEP 5: Execute a query
			String sql;
			sql = "show databases";
			ResultSet rs = stmt.executeQuery(sql);
			
			// STEP 6: Extract data from ResultSet object
			while(rs.next()){
				System.out.println(rs.getString(1));
			}
			
			
<<<<<<< HEAD
			sql = "select first_name, gender, hire_date, title\r\n"
					+ "from emp_title where hire_date like '1995-10%'\r\n"
					+ "order by hire_date asc";
			
			ResultSet rs = stmt.executeQuery(sql);
			
			while(rs.next()) {
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3) + ", " + rs.getString(4));
			}
=======
>>>>>>> 2e5236ad0c6674f2289190251d788c992f968eb0
			
			/*
			System.out.println("----------------------------------");
			sql = "select bre.*\r\n" + 
					"from bremployee as bre\r\n" + 
					"join bremployee as brem on bre.manager_num = brem.bremp_num\r\n" + 
					"where bre.cmp_num in (select cmp_num\r\n" + 
					"						from recompany\r\n" + 
					"                        where cmp_name in ('Riot', 'Ubisoft', 'Nexon'))";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getInt(1) + ", " + rs.getString(2) + ", " + rs.getInt(3) + ", " + rs.getString(4) + ", " + rs.getInt(5) + ", " + rs.getInt(6) + ", " + rs.getInt(7));
			}
			
			System.out.println("----------------------------------");
			sql = "select rec.cmp_name, brem.br_name as branch_manager, re.re_num, regi.regi_date as registered_date\r\n" + 
					"from recompany as rec\r\n" + 
					"join register as regi on regi.cmp_num = rec.cmp_num\r\n" + 
					"join bremployee as brem on brem.cmp_num = rec.cmp_num\r\n" + 
					"join realestate as re on re.re_num = regi.re_num\r\n" + 
					"where brem.manager_num is null";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getInt(3) + ", " + rs.getDate(4));
			}
			
			System.out.println("----------------------------------");
			sql = "select rec.cmp_name as company, rec.si, rec.gu, rec.dong, avg(cmpe.cmp_salary) as avg_salary\r\n" + 
					"from recompany as rec\r\n" + 
					"join cmpemployee as cmpe on cmpe.cmp_num = rec.cmp_num\r\n" + 
					"group by cmpe.cmp_num\r\n" + 
					"having avg(cmpe.cmp_salary)\r\n" + 
					"order by avg(cmpe.cmp_salary) desc";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3) + ", " + rs.getString(4) + ", " + rs.getInt(5));
			}
			
			System.out.println("----------------------------------");
			sql = "select cmp.cmp_name as trading_company, cus.cus_name as customer,\r\n" + 
					"	left(cus.cus_birth, 4) as cus_birth_year,\r\n" + 
					"	(re.price_pyeong*re.size) as market_price, tr.price as trade_price,\r\n" + 
					"    (tr.price - (re.price_pyeong*re.size)) as profit\r\n" + 
					"from trade as tr\r\n" + 
					"join realestate as re on tr.re_num = re.re_num\r\n" + 
					"join recompany as cmp on tr.cmp_num = cmp.cmp_num\r\n" + 
					"join customer as cus on tr.cus_num = cus.cus_num";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getString(3) + ", " + rs.getInt(4) + ", " + rs.getInt(5) + ", " + rs.getInt(6));
			}
			
			System.out.println("----------------------------------");
			sql = "select cmpe.emp_name, cmpe.position as emp_position, cmpe.cmp_salary as emp_salary,\r\n" + 
					"		mento.emp_name as metor_name, mento.position as metor_position,\r\n" + 
					"        dept.dept_name as emp_department\r\n" + 
					"from cmpemployee as cmpe\r\n" + 
					"join cmpemployee as mento on mento.cmpemp_num = cmpe.mentor_num\r\n" + 
					"join department as dept on cmpe.dept_num = dept.dept_num\r\n" + 
					"where cmpe.mentor_num is not null and cmpe.emp_name like '%e%'\r\n" + 
					"order by cmpe.cmp_salary desc";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				System.out.println(rs.getString(1) + ", " + rs.getString(2) + ", " + rs.getInt(3) + ", " + rs.getString(4) + ", " + rs.getString(5) + ", " + rs.getString(6));
			}
			
			
			System.out.println("---------insert-----------");
			sql = "insert into recompany values (14, 'Valve', '서울', '강남', '대치')";
			stmt.executeUpdate(sql);
			
			System.out.println("-----------update-----------");
			sql = "update recompany set cmp_name = 'Samsung' where cmp_num = 0";
			stmt.executeUpdate(sql);
			
			
			System.out.println("----------delete--------------");
			sql = "delete from recompany where cmp_name = 'Temp'";
			stmt.executeUpdate(sql);
			*/
			
			rs.close();
			
		}catch(Exception e){
			e.printStackTrace();
			System.out.println("Error occured.");
		}
	}
}
