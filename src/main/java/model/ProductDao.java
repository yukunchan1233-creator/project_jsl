package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

// ProductDao : 운동기구 제품 관련 데이터베이스 작업을 수행하는 DAO 클래스
public class ProductDao {
	
	// 카테고리별 하위카테고리 목록 조회 (예: 가슴 -> 벤치프레스, 딥스 등)
	public List<String> selectSubcategories(String category) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT DISTINCT subcategory FROM TBL_PRODUCT WHERE category = ? ORDER BY subcategory";
		List<String> list = new ArrayList<String>();
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getString("subcategory"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 하위카테고리별 제품 목록 조회 (예: 벤치프레스 -> 모든 벤치프레스 제품)
	public List<ProductDto> selectProducts(String category, String subcategory) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT pno, site_name, product_name, price, review_count, image_path, buy_link "
				   + "FROM TBL_PRODUCT "
				   + "WHERE category = ? AND subcategory = ? "
				   + "ORDER BY price";
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, category);
			pstmt.setString(2, subcategory);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setPno(rs.getInt("pno"));
				dto.setSite_name(rs.getString("site_name"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setReview_count(rs.getInt("review_count"));
				dto.setImage_path(rs.getString("image_path"));
				dto.setBuy_link(rs.getString("buy_link"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 제품 상세 정보 조회 (제품번호로)
	public ProductDto selectProduct(int pno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String sql = "SELECT * FROM TBL_PRODUCT WHERE pno = ?";
		ProductDto dto = null;
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				dto = new ProductDto();
				dto.setPno(rs.getInt("pno"));
				dto.setCategory(rs.getString("category"));
				dto.setSubcategory(rs.getString("subcategory"));
				dto.setSite_name(rs.getString("site_name"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setReview_count(rs.getInt("review_count"));
				dto.setImage_path(rs.getString("image_path"));
				dto.setDetail_images(rs.getString("detail_images"));
				dto.setBuy_link(rs.getString("buy_link"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return dto;
	}
	
	// java02 계정이 등록한 제품 목록 조회 (정렬 옵션 포함)
	public List<ProductDto> selectProductsByAdmin(String subcategory, String sortType) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		// 정렬 옵션에 따른 ORDER BY 절 설정
		String orderBy = "ORDER BY ";
		if("popular".equals(sortType)) {
			// 인기상품순: 후기 개수 내림차순
			orderBy += "review_count DESC";
		} else if("price_low".equals(sortType)) {
			// 낮은가격순: 가격 오름차순
			orderBy += "price ASC";
		} else if("price_high".equals(sortType)) {
			// 높은가격순: 가격 내림차순
			orderBy += "price DESC";
		} else {
			// 기본값: 인기상품순
			orderBy += "review_count DESC";
		}
		
		String sql = "SELECT pno, category, subcategory, site_name, product_name, price, review_count, image_path, buy_link, userid, TO_CHAR(regdate, 'YYYY.MM.DD') as regdate "
				   + "FROM TBL_PRODUCT "
				   + "WHERE userid = 'java02' AND subcategory = ? "
				   + orderBy;
		
		List<ProductDto> list = new ArrayList<ProductDto>();
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subcategory);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDto dto = new ProductDto();
				dto.setPno(rs.getInt("pno"));
				dto.setCategory(rs.getString("category"));
				dto.setSubcategory(rs.getString("subcategory"));
				dto.setSite_name(rs.getString("site_name"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setPrice(rs.getInt("price"));
				dto.setReview_count(rs.getInt("review_count"));
				dto.setImage_path(rs.getString("image_path"));
				dto.setBuy_link(rs.getString("buy_link"));
				dto.setUserid(rs.getString("userid"));
				dto.setRegdate(rs.getString("regdate"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	
	// 상품 추가 (INSERT)
	public int insertProduct(ProductDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = "INSERT INTO TBL_PRODUCT (pno, category, subcategory, site_name, product_name, price, review_count, image_path, detail_images, buy_link, userid, regdate) "
				   + "VALUES (SEQ_PRODUCT.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, SYSDATE)";
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getSubcategory());
			pstmt.setString(3, dto.getSite_name());
			pstmt.setString(4, dto.getProduct_name());
			pstmt.setInt(5, dto.getPrice());
			pstmt.setInt(6, dto.getReview_count());
			pstmt.setString(7, dto.getImage_path());
			pstmt.setString(8, dto.getDetail_images());
			pstmt.setString(9, dto.getBuy_link());
			pstmt.setString(10, dto.getUserid());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 상품 수정 (UPDATE)
	public int updateProduct(ProductDto dto) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = "UPDATE TBL_PRODUCT SET category=?, subcategory=?, site_name=?, product_name=?, price=?, review_count=?, image_path=?, detail_images=?, buy_link=? WHERE pno=?";
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getCategory());
			pstmt.setString(2, dto.getSubcategory());
			pstmt.setString(3, dto.getSite_name());
			pstmt.setString(4, dto.getProduct_name());
			pstmt.setInt(5, dto.getPrice());
			pstmt.setInt(6, dto.getReview_count());
			pstmt.setString(7, dto.getImage_path());
			pstmt.setString(8, dto.getDetail_images());
			pstmt.setString(9, dto.getBuy_link());
			pstmt.setInt(10, dto.getPno());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
	
	// 상품 삭제 (DELETE)
	public int deleteProduct(int pno) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;
		
		String sql = "DELETE FROM TBL_PRODUCT WHERE pno=?";
		
		try {
			conn = DBManager.getInstance();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pno);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return result;
	}
}







