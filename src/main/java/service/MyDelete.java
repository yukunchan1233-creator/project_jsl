package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Command;
import model.MemberDao;

public class MyDelete implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");//db연동시 한글깨지는것 방지.
		
		int wishBno = Integer.parseInt(request.getParameter("wishBno"));
		boolean result = new MemberDao().deleteWish(wishBno);
		
		response.getWriter().write(result?"success":"fail");
		//ajax 호출한 곳(wishlist.jsp)으로 참이면 success, 거짓이면 fail 글자를 비동기식으로 보내줘라.
	}

}




