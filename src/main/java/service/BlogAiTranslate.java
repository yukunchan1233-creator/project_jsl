package service;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import model.Command;

public class BlogAiTranslate implements Command {

	@Override
	public void doCommand(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("utf-8");
		
		String lang = request.getParameter("lang");
		String content = request.getParameter("content");
		//AI가 글쓴내용을 읽어 와라

		AiService ai = new AiService();
		String translated = "";
		try {
			if(lang.equals("jp")) {
				translated = ai.translateToJp(content);
			}
			if(lang.equals("en")) {
				translated = ai.translateToEnglish(content);
			}
			if(lang.equals("ch")) {
				translated = ai.translateToChinese(content);
			}
			//글쓴내용을 선택한 언어로 번역해서 저장
		} catch (Exception e) {
			e.printStackTrace();
		}

		// JSON 형식으로 호출한 곳으로 리턴하는 방법
		response.setContentType("application/json; charset=utf-8");
		JSONObject json = new JSONObject();
		json.put("translated", translated);

		response.getWriter().print(json.toString());
	}

}




