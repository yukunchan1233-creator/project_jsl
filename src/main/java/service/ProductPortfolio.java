package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Command;
import model.ProductDao;
import model.ProductDto;

/**
 * [포트폴리오 페이지 제품 조회 서비스 - ProductPortfolio]
 * 설명: java02 계정이 등록한 제품 목록을 조회하는 서비스입니다.
 * 
 * 흐름:
 * 1. ProductPortfolioController에서 호출됨
 * 2. ProductDao를 통해 DB에서 java02 계정의 제품 목록 조회
 * 3. 조회된 목록을 request 속성에 저장하여 JSP로 전달
 */
public class ProductPortfolio implements Command {

	/**
	 * 포트폴리오 페이지용 제품 목록 조회 메서드
	 * 설명: DB에서 java02 계정이 등록한 제품을 조회하여 request에 저장합니다.
	 */
	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		// 1단계: 파라미터 받기
		String subcategory = request.getParameter("sub");
		String sortType = request.getParameter("sort");
		
		// 기본값 설정
		if(subcategory == null || subcategory.isEmpty()) {
			subcategory = "런닝머신";
		}
		if(sortType == null || sortType.isEmpty()) {
			sortType = "popular"; // 기본값: 인기상품순
		}
		
		// 2단계: ProductDao 객체 생성
		ProductDao dao = new ProductDao();
		
		// 3단계: selectProductsByAdmin() 메서드를 호출하여 DB에서 제품 목록 조회
		List<ProductDto> list = dao.selectProductsByAdmin(subcategory, sortType);
		
		// 4단계: 조회된 목록과 파라미터를 request 속성에 저장
		request.setAttribute("list", list);
		request.setAttribute("subcategory", subcategory);
		request.setAttribute("sortType", sortType);
	}

}
