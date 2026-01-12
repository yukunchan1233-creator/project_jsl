package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * [리다이렉트 유틸리티]
 * jslhrd가 ROOT(/)로 설정되어 있어서 hometraining으로 강제 리다이렉트
 */
public class RedirectUtil {
	
	public static void redirect(HttpServletRequest request, HttpServletResponse response, String path) throws IOException {
		// jslhrd가 ROOT(/)로 설정되어 있어서 무조건 /hometraining 사용
		response.sendRedirect("/hometraining" + path);
	}
}
