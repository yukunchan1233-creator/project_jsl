package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BlogDao;
import model.BlogDto;
import model.Command;
import model.ReplyDto;

public class BlogView implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		int bno = Integer.parseInt(request.getParameter("bno"));
		BlogDao dao = new BlogDao();
		dao.viewCount(bno);
		//조회수증가를 먼저하고 증가된 dto객체를 가져와서
		BlogDto dto = dao.getSelectByBno(bno);
		//출력하려면 request속성에 담아서 forward한다.
		request.setAttribute("viewdto", dto);
		
		// 댓글 리스트 가져오기
		List<ReplyDto> replyList = dao.getReplyList(bno);
		request.setAttribute("replyList", replyList);
	}

}




