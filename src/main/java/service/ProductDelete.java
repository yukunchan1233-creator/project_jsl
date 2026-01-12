package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Command;
import model.ProductDao;
import util.RedirectUtil;

/**
 * [상품 삭제 서비스 - ProductDelete]
 * 설명: 관리자가 선택한 상품을 DB에서 삭제합니다.
 */
public class ProductDelete implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 1단계: 파라미터 받기
		String pnoStr = request.getParameter("pno");
		String subcategory = request.getParameter("sub");
		
		if(pnoStr == null || pnoStr.isEmpty()) {
			RedirectUtil.redirect(request, response, "/portfolio.do?sub=" + subcategory);
			return;
		}
		
		int pno = Integer.parseInt(pnoStr);
		
		// 2단계: ProductDao를 통해 DB에서 삭제
		ProductDao dao = new ProductDao();
		int result = dao.deleteProduct(pno);
		
		// 3단계: 결과에 따라 리다이렉트
		if(result > 0) {
			// 성공: 상품 목록 페이지로 이동
			RedirectUtil.redirect(request, response, "/portfolio.do?sub=" + subcategory);
		} else {
			// 실패: 에러 메시지와 함께 목록 페이지로
			RedirectUtil.redirect(request, response, "/portfolio.do?sub=" + subcategory + "&error=delete_failed");
		}
	}

}
