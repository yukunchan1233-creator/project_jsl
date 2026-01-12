package model;

import java.sql.Connection;
import java.sql.DriverManager;

// DBManager : 데이터베이스 연결을 관리하는 클래스
public class DBManager {
	
	public static Connection getInstance() {
		Connection conn = null;
		
		String driver = "oracle.jdbc.driver.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "jsl26";
		String pw = "1234";
		
		try {
			Class.forName(driver);
			conn = DriverManager.getConnection(url, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
}







