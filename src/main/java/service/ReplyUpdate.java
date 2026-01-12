package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BlogDao;
import model.Command;

/**
 * [댓글 수정 서비스 - ReplyUpdate]
 * 설명: 사용자가 수정한 댓글을 데이터베이스에 업데이트하는 서비스입니다.
 * 작성자만 자신의 댓글을 수정할 수 있습니다.
 * 
 * 흐름:
 * 1. view.jsp에서 "저장" 버튼 클릭 → AJAX로 /port/replyUpdate.do 요청
 * 2. BlogController에서 ReplyUpdate.doCommand() 호출
 * 3. Session에서 userid 확인 (로그인 체크)
 * 4. 파라미터 받기 (bno, replytext)
 * 5. BlogDao.replyUpdate() 호출하여 DB에 업데이트 (작성자만 수정 가능)
 * 6. AJAX 응답으로 "success" 또는 에러 메시지 반환
 */
public class ReplyUpdate implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		
		// 1단계: Session에서 userid 가져오기
		HttpSession session = request.getSession();
		String userid = (String) session.getAttribute("userid");
		
		System.out.println("=== 댓글 수정 시도 ===");
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
		String replytext = request.getParameter("replytext");
		
		System.out.println("bno: " + bno);
		System.out.println("replytext: " + replytext);
		
		// 4단계: 댓글 내용 검증
		if(replytext == null || replytext.trim().isEmpty()) {
			response.setContentType("text/plain; charset=utf-8");
			response.getWriter().write("empty_content");
			return;
		}
		
		// 5단계: BlogDao를 통해 DB에 댓글 수정 (작성자만 수정 가능)
		BlogDao dao = new BlogDao();
		boolean result = dao.replyUpdate(bno, userid, replytext);
		
		// 6단계: 결과에 따른 응답
		response.setContentType("text/plain; charset=utf-8");
		if(result) {
			System.out.println("댓글 수정 성공");
			response.getWriter().write("success");
		} else {
			// 수정 실패: 작성자가 아니거나 DB 오류
			System.out.println("댓글 수정 실패 (작성자가 아니거나 DB 오류)");
			response.getWriter().write("permission_denied");
		}
	}
}




