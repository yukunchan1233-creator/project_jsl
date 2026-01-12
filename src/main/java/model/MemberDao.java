package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBManager;

public class MemberDao {
	
	//아이디 중복체크
	public int userIdCheck(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from htm_member where userid = ?";
		int result = 0;
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				result= 1; //아이디존재
			}else {
				result= -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	
	/**
	 * [회원가입 저장 메서드 - memberSave()]
	 * 설명: MemberDto 객체에 담긴 회원 정보를 DB의 htm_member 테이블에 저장합니다.
	 * 
	 * 흐름:
	 * 1. MemberSave 서비스에서 호출됨
	 * 2. DB 연결
	 * 3. INSERT SQL 실행
	 * 4. 리소스 해제
	 * 
	 * @param dto 저장할 회원 정보가 담긴 MemberDto 객체
	 */
	public void memberSave(MemberDto dto) {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		// SQL: htm_member 테이블에 회원 정보 삽입
		String sql = "insert into htm_member (writer,userid, password, phone,email) values (?,?,?,?,?)";
		
		try {
			// 1단계: DB 연결
			conn = DBManager.getInstance();
			
			// 2단계: SQL 문 준비
			pstmt = conn.prepareStatement(sql);
			
			// 3단계: 파라미터 설정 (순서대로 ?에 값 대입)
			pstmt.setString(1, dto.getWriter());   // 사용자명
			pstmt.setString(2, dto.getUserid());    // 아이디
			
			// password가 null일 수 있음 (구글 로그인의 경우)
			// 구글 로그인 사용자는 비밀번호가 없을 수 있으므로 NULL로 저장
			if (dto.getPassword() == null || dto.getPassword().isEmpty()) {
				pstmt.setNull(3, java.sql.Types.VARCHAR);
			} else {
				pstmt.setString(3, dto.getPassword()); // 암호화된 비밀번호
			}
			
			pstmt.setString(4, dto.getPhone());     // 전화번호
			pstmt.setString(5, dto.getEmail());     // 이메일
			
			// 4단계: SQL 실행 (INSERT, UPDATE, DELETE는 executeUpdate() 사용)
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 5단계: 리소스 해제
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
	}

	//아이디존재여부
	public MemberDto searchUserId(String userid) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from htm_member where userid = ?";
		MemberDto dto = null;
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,userid);
			rs=pstmt.executeQuery();
			
		if(rs.next()) {
			dto = new MemberDto();
			dto.setWriter(rs.getString("writer"));
			dto.setUserid(rs.getString("userid"));
			dto.setPassword(rs.getString("password"));
			dto.setPhone(rs.getString("phone"));
			dto.setEmail(rs.getString("email"));
		}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto;
	}

	// 이메일로 회원 찾기 (구글 로그인용) - 추가
	public MemberDto searchUserByEmail(String email) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "select * from htm_member where email = ?";
		MemberDto dto = null;
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, email);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new MemberDto();
				dto.setWriter(rs.getString("writer"));
				dto.setUserid(rs.getString("userid"));
				dto.setPassword(rs.getString("password"));
				dto.setPhone(rs.getString("phone"));
				dto.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return dto; 
	}
	
	
	//찜 삭제
	public boolean deleteWish(int wish_bno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		String sql = "delete from htm_mywish where wish_bno = ?";
		
		boolean result = false;
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, wish_bno);
			int row = pstmt.executeUpdate(); //insert, delete, update
			result = (row > 0);		//row가 0보다 크면 result에 true
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
		
	}
	
	
	

	
}




