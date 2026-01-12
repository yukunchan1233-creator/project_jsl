package util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

/**
 * [파일 업로드 유틸리티 - FileUploadUtil]
 * 설명: 이미지 파일 업로드를 처리하는 유틸리티 클래스입니다.
 */
public class FileUploadUtil {
	
	// 업로드 디렉토리 경로 (프로젝트의 images 폴더)
	private static final String UPLOAD_DIR = "images";
	
	/**
	 * 파일 업로드 처리
	 * @param request HttpServletRequest
	 * @param partName 파트 이름 (예: "image_file")
	 * @return 업로드된 파일의 상대 경로 (예: "images/abc123.jpg")
	 */
	public static String uploadFile(HttpServletRequest request, String partName) throws IOException {
		try {
			Part part = request.getPart(partName);
			
			if(part == null || part.getSize() == 0) {
				return null; // 파일이 업로드되지 않음
			}
			
			String fileName = part.getSubmittedFileName();
			if(fileName == null || fileName.isEmpty()) {
				return null;
			}
			
			// 파일 확장자 추출
			String extension = "";
			int lastDot = fileName.lastIndexOf(".");
			if(lastDot > 0) {
				extension = fileName.substring(lastDot);
			}
			
			// 고유한 파일명 생성 (UUID 사용)
			String uniqueFileName = UUID.randomUUID().toString() + extension;
			
			// 업로드 경로 설정
			String uploadPath = request.getServletContext().getRealPath("/") + UPLOAD_DIR;
			File uploadDir = new File(uploadPath);
			if(!uploadDir.exists()) {
				uploadDir.mkdirs();
			}
			
			// 파일 저장
			String filePath = uploadPath + File.separator + uniqueFileName;
			part.write(filePath);
			
			// 상대 경로 반환
			return UPLOAD_DIR + "/" + uniqueFileName;
			
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 기존 파일 삭제
	 * @param request HttpServletRequest
	 * @param filePath 삭제할 파일의 상대 경로
	 */
	public static void deleteFile(HttpServletRequest request, String filePath) {
		if(filePath == null || filePath.isEmpty()) {
			return;
		}
		
		try {
			String realPath = request.getServletContext().getRealPath("/") + filePath;
			File file = new File(realPath);
			if(file.exists() && file.isFile()) {
				file.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
