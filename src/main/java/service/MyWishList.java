package service;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.BlogDao;
import model.Command;
import model.WishDto;

public class MyWishList implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession(false);
		String userid = (String)session.getAttribute("userid");
		
		if(userid == null) {
			// hometraining context path를 고려한 리다이렉트
			response.sendRedirect(request.getContextPath() + "/port/list.do");
			return;
		}
		
		List<WishDto > list = new BlogDao().myWishList(userid);
		request.setAttribute("wishlist", list);
	}

}




