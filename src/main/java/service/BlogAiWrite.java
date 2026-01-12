package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Command;

public class BlogAiWrite implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");

		String tt = request.getParameter("title");

		AiService ai = new AiService();
		String content = "";
		try {
			content = ai.makeBlogContent(tt);
		} catch (Exception e) {
			e.printStackTrace();
		}

		// JSON 형식으로 호출한 곳으로 리턴하는 방법
		response.setContentType("application/json; charset=utf-8");
		JSONObject json = new JSONObject();
		json.put("content", content);

		response.getWriter().print(json.toString());
	}

}




