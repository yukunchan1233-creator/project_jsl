package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BlogDao;
import model.Command;

public class mywish implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		
		String userid = request.getParameter("userid");
		int blogbno = Integer.parseInt(request.getParameter("blogbno"));
		
		int result = new BlogDao().mywishInsert(userid, blogbno);
		
		String msg= "";
		
		try {
			if(result == 1) {
				msg="찜 성공";
			}else if(result == -1) {
				msg = "찜 이미 했어요";
			} else {
				msg = "찜 실패";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		response.setContentType("text/plan; charset=utf-8");
		response.getWriter().write(msg);
	}

}




