package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Command;
import model.ProductDao;
import model.ProductDto;
import util.FileUploadUtil;
import util.RedirectUtil;

/**
 * [상품 수정 서비스 - ProductUpdate]
 * 설명: 관리자가 수정한 상품 정보를 DB에 업데이트합니다.
 */
public class ProductUpdate implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 1단계: 파라미터 받기
		String pnoStr = request.getParameter("pno");
		String category = request.getParameter("category");
		String subcategory = request.getParameter("subcategory");
		String site_name = request.getParameter("site_name");
		String product_name = request.getParameter("product_name");
		String priceStr = request.getParameter("price");
		String review_countStr = request.getParameter("review_count");
		String image_path = request.getParameter("image_path");
		String buy_link = request.getParameter("buy_link");
		
		if(pnoStr == null || pnoStr.isEmpty()) {
			RedirectUtil.redirect(request, response, "/portfolio.do?sub=" + subcategory);
			return;
		}
		
		int pno = Integer.parseInt(pnoStr);
		
		// 2단계: ProductDto 객체 생성 및 값 설정
		ProductDto dto = new ProductDto();
		dto.setPno(pno);
		dto.setCategory(category);
		dto.setSubcategory(subcategory);
		dto.setSite_name(site_name);
		dto.setProduct_name(product_name);
		
		if(priceStr != null && !priceStr.isEmpty()) {
			dto.setPrice(Integer.parseInt(priceStr));
		} else {
			dto.setPrice(0);
		}
		
		if(review_countStr != null && !review_countStr.isEmpty()) {
			dto.setReview_count(Integer.parseInt(review_countStr));
		} else {
			dto.setReview_count(0);
		}
		
		// 이미지 파일 업로드 처리
		String uploadedImagePath = FileUploadUtil.uploadFile(request, "image_file");
		if(uploadedImagePath != null && !uploadedImagePath.isEmpty()) {
			// 새 이미지가 업로드된 경우, 기존 이미지 삭제
			ProductDao tempDao = new ProductDao();
			ProductDto existingProduct = tempDao.selectProduct(pno);
			if(existingProduct != null && existingProduct.getImage_path() != null) {
				FileUploadUtil.deleteFile(request, existingProduct.getImage_path());
			}
			image_path = uploadedImagePath;
		} else if(image_path == null || image_path.isEmpty()) {
			// 기존 상품 정보 조회하여 기존 이미지 경로 사용
			ProductDao tempDao = new ProductDao();
			ProductDto existingProduct = tempDao.selectProduct(pno);
			if(existingProduct != null) {
				image_path = existingProduct.getImage_path();
			} else {
				image_path = "images/default.jpg";
			}
		}
		dto.setImage_path(image_path);
		dto.setDetail_images(image_path); // 상세 이미지는 대표 이미지와 동일하게
		
		dto.setBuy_link(buy_link);
		
		// 3단계: ProductDao를 통해 DB 업데이트
		ProductDao dao = new ProductDao();
		int result = dao.updateProduct(dto);
		
		// 4단계: 결과에 따라 리다이렉트
		if(result > 0) {
			// 성공: 상품 목록 페이지로 이동
			RedirectUtil.redirect(request, response, "/portfolio.do?sub=" + subcategory);
		} else {
			// 실패: 에러 메시지와 함께 다시 수정 폼으로
			request.setAttribute("error", "상품 수정에 실패했습니다.");
			request.setAttribute("product", dto);
			request.setAttribute("subcategory", subcategory);
			request.getRequestDispatcher("/admin/product_form.jsp").forward(request, response);
		}
	}

}
