package haker;

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
	
	/* MySQL 연결정보 */
	String jdbc_driver = "com.mysql.cj.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost:3306/jspdb?serverTimezone=UTC"; 
	
	// DB연결 메서드
	void connect() {
		try {
			Class.forName(jdbc_driver);

			con = DriverManager.getConnection(jdbc_url,"root","dbqldhk@038");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	void disconnect() {
		if(pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}


public ArrayList<BoardDTO> list(){
	ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	ResultSet rs = null;
	
	try {
		connect();
		
		String query = "SELECT num, author, nickname, age, title, content, date_format(writeday, '%Y%M%D') writeday, readcnt, repRoot, repStep, repIndent FROM board order by repRoot desc, repStep asc";
		
		pstmt = con.prepareStatement(query);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			int num = rs.getInt("num");
			String author = rs.getString("author");
			String nickname = rs.getString("nickname");
			String age = rs.getString("age");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writeday = rs.getString("writeday");
			int readcnt = rs.getInt("readcnt");
			int repRoot = rs.getInt("repRoot");
			int repStep = rs.getInt("repStep");
			int repIndent = rs.getInt("repIndent");
			
			BoardDTO data = new BoardDTO();
			data.setNum(num);
			data.setAuthor(author);
			data.setNickname(nickname);
			data.setAge(age);
			data.setTitle(title);
			data.setContent(content);
			data.setWriteday(writeday);
			data.setReadcnt(readcnt);
			data.setRepRoot(repRoot);
			data.setRepStep(repStep);
			data.setRepIndent(repIndent);
			list.add(data);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
	return list;
}

public void write(String _title, String _author, String _nickname, String _age, String _content) {
	
	
	try {
		connect();
		String query = "INSERT INTO board (author, nickname, age, title, content, writeday, readcnt, repRoot, repStep, repIndent) values (?, ?, ?, ?, ?, now(), 0, 0, 0, 0)";
		
		pstmt = con.prepareStatement(query);
		
		pstmt.setString(1, _author);
		pstmt.setString(2, _nickname);
		pstmt.setString(3, _age);
		pstmt.setString(4, _title);
		pstmt.setString(5, _content);
		
		int n = pstmt.executeUpdate();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
}
public void update(String _num, String _title, String _author, String _content, String _nickname, String _age) {
    
    try {
       connect();
       String query = "UPDATE board SET title = ?, nickname=?, age=?, author = ?, content = ? WHERE num = ?";
       
       pstmt = con.prepareStatement(query);
       
       pstmt.setString(1, _title);
       pstmt.setString(2, _nickname);
       pstmt.setString(3, _age);
       pstmt.setString(4, _author);
       pstmt.setString(5, _content);
       pstmt.setInt(6, Integer.parseInt(_num));
       
       int n = pstmt.executeUpdate();
       
                
       
    }catch(Exception e) {
       e.printStackTrace();
    }finally {
       disconnect();       
    }
}
public void delete(String _num)
{   
   try {
      connect();
      String query = "Delete FROM board WHERE num = ?";
      
      pstmt = con.prepareStatement(query);
      pstmt.setInt(1,Integer.parseInt(_num));
      int n=pstmt.executeUpdate();
   }catch(Exception e) {
      e.printStackTrace();
   }finally {
      disconnect();
   }
}


public void readCount(String _num) {
	
	
	try {
		connect();
		String query = "UPDATE board SET readcnt = readcnt + 1 WHERE num="+_num;
		pstmt = con.prepareStatement(query);
		int n = pstmt.executeUpdate();
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
}
public BoardDTO retrieve(String _num) {
	readCount(_num);
	
	ResultSet rs = null;
	BoardDTO data = new BoardDTO();
	
	try {
		connect();
		String query = "SELECT * FROM board WHERE num = ?";
		pstmt = con.prepareStatement(query);
		pstmt.setInt(1, Integer.parseInt(_num));
		rs = pstmt.executeQuery();
		
		if(rs.next()) {
			int num = rs.getInt("num");
			String title = rs.getString("title");
			String author = rs.getString("author");
			String content = rs.getString("content");
			String writeday = rs.getString("writeday");
			String nickname = rs.getString("nickname");
			String age = rs.getString("age");
			int readcnt = rs.getInt("readcnt");
			
			data.setNum(num);
			data.setAuthor(author);
			data.setNickname(nickname);
			data.setAge(age);
			data.setTitle(title);
			data.setContent(content);
			data.setWriteday(writeday);
			data.setReadcnt(readcnt);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
	return data;
}
public ArrayList<BoardDTO> search(String _searchName,String _searchvalue){
    
	   ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	   ResultSet rs = null;
	   
	   try {
	      connect();
	      
	      String query = "SELECT num, author,nickname, age, title,content,date_format(writeday,'%Y%M%D')writeday,readcnt FROM board";
	      
	      if( _searchName.equals("title"))
	      {
	         query+="   WHERE    title LIKE ?";
	      }else {
	         
	         query+="   WHERE author LIKE ?";
	      }
	      
	      pstmt = con.prepareStatement(query);
	      pstmt.setString(1, "%"+_searchvalue+"%");
	      
	      rs=pstmt.executeQuery();
	      while(rs.next()) {
	         int num = rs.getInt("num");
	         String author = rs.getString("author");
	         String nickname = rs.getString("nickname");
	         String age = rs.getString("age");
	         String title = rs.getString("title");
	         String content = rs.getString("content");
	         String writeday = rs.getString("writeday");
	         int readcnt = rs.getInt("readcnt");
	         
	         BoardDTO data = new BoardDTO();
	         data.setNum(num);
	         data.setAuthor(author);
	         data.setNickname(nickname);
	         data.setAge(age);
	         data.setTitle(title);
	         data.setContent(content);
	         data.setWriteday(writeday);
	         data.setReadcnt(readcnt);
	         
	         list.add(data);
	      }
	   }catch(Exception e) {
	      e.printStackTrace();
	   }finally {
	      disconnect();
	   }
	   
	   return list;
}
public int totalCount() {
	int count = 0;
	ResultSet rs = null;
	
	try {
		connect();
		String query = "SELECT count(*) FROM board";
		pstmt = con.prepareStatement(query);
		rs=pstmt.executeQuery();
		
		if(rs.next()) {
			count=rs.getInt(1);
		}
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
	return count;
}
public PageTO page(int curPage) {
	PageTO to = new PageTO();
	int totalCount = totalCount();
	
	ArrayList<BoardDTO> list = new ArrayList<BoardDTO>();
	ResultSet rs = null;
	
	try {
		connect();
		
		String query = "SELECT num, author, nickname, age, title, content, date_format(writeday, '%Y%M%D') writeday, readcnt, repRoot, repStep, repIndent FROM board order by repRoot desc, repStep asc";
		pstmt = con.prepareStatement(query, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		rs = pstmt.executeQuery();
		
		int perPage = to.getPerPage();
		
		int skip = (curPage - 1)*perPage;
		if(skip>0) {
			rs.absolute(skip);
		}
		
		for(int i=0; i<perPage && rs.next(); i++) {
			int num = rs.getInt("num");
			String author = rs.getString("author");
			String nickname = rs.getString("nickname");
			String age = rs.getString("age");
			String title = rs.getString("title");
			String content = rs.getString("content");
			String writeday = rs.getString("writeday");
			int readcnt = rs.getInt("readcnt");
			int repRoot = rs.getInt("repRoot");
			int repStep = rs.getInt("repStep");
			int repIndent = rs.getInt("repIndent");
			
			BoardDTO data = new BoardDTO();
			data.setNum(num);
			data.setAuthor(author);
			data.setNickname(nickname);
			data.setAge(age);
			data.setTitle(title);
			data.setContent(content);
			data.setWriteday(writeday);
			data.setReadcnt(readcnt);
			data.setRepRoot(repRoot);
			data.setRepStep(repStep);
			data.setRepIndent(repIndent);
			list.add(data);
		}
		to.setList(list);
		to.setTotalCount(totalCount);
		to.setCurPage(curPage);
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		disconnect();
	}
	
	return to;
}
}