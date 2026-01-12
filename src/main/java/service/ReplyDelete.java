package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BlogDao;
import model.Command;

/**
 * [댓글 삭제 서비스 - ReplyDelete]
 * 설명: 사용자가 댓글을 삭제하는 서비스입니다.
 * 작성자만 자신의 댓글을 삭제할 수 있습니다.
 * 
 * 흐름:
 * 1. view.jsp에서 "삭제" 버튼 클릭 → AJAX로 /port/replyDelete.do 요청
 * 2. BlogController에서 ReplyDelete.doCommand() 호출
 * 3. Session에서 userid 확인 (로그인 체크)
 * 4. 파라미터 받기 (bno)
 * 5. BlogDao.replyDelete() 호출하여 DB에서 삭제 (작성자만 삭제 가능)
 * 6. AJAX 응답으로 "success" 또는 에러 메시지 반환
 */
public class ReplyDelete implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 1단계: Session에서 userid 가져오기
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		System.out.println("=== 댓글 삭제 시도 ===");
		System.out.println("userid: " + userid);
		
		// 2단계: 로그인하지 않은 경우
		if(userid == null || userid.trim().isEmpty()) {
			System.out.println("로그인하지 않음");
			response.setContentType("text/plain; charset=utf-8");
			response.getWriter().write("login_required");
			return;
		}
		
		// 3단계: 파라미터 받기
		int bno = Integer.parseInt(request.getParameter("bno"));
		
		System.out.println("bno: " + bno);
		
		// 4단계: BlogDao를 통해 DB에서 댓글 삭제 (작성자만 삭제 가능)
		BlogDao dao = new BlogDao();
		boolean result = dao.replyDelete(bno, userid);
		
		// 5단계: 결과에 따른 응답
		response.setContentType("text/plain; charset=utf-8");
		if(result) {
			System.out.println("댓글 삭제 성공");
			response.getWriter().write("success");
		} else {
			// 삭제 실패: 작성자가 아니거나 DB 오류
			System.out.println("댓글 삭제 실패 (작성자가 아니거나 DB 오류)");
			response.getWriter().write("permission_denied");
		}
	}
}




