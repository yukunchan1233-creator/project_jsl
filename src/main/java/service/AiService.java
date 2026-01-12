package service;

import java.awt.im.InputContext;
import java.io.InputStream;
import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.util.Properties;

import javax.management.RuntimeErrorException;

import org.json.JSONObject;

public class AiService { //groq기능만 담당하는 Service
	
	private String apiKey;
	
	public AiService() {
		try {
			//config.properties 에 저장된 groq api 키 호출 방법
			Properties prop = new Properties();
			//설정파일을 읽기 위한 객체 만들고
			InputStream is = getClass().getClassLoader().getResourceAsStream("config.properties");
			//WEB-INF/classes 폴더안에 있는 config.properties 파일의 내용을 읽어와라.
			prop.load(is);
			//읽어온 파일의 내용을 메모리로 로딩해라
			
			apiKey = prop.getProperty("groq.api.key"); // API 키를 가져와서 저장
		} catch (Exception e) {
			e.printStackTrace();
		}
	}//
	
	private String callGroq(String prompt) throws Exception {
		//groq가 만든 글을 String타입으로 보주는 역할을 하는 메서드
		
		String safePrompt = prompt.replace("\\", "\\\\").replace("\"", "\\\"").replace("\n","\\n");
		
		String jsonBody = """
				{
					"model":"llama-3.1-8b-instant",
					"messages": [
						{"role":"user","content": "%s"}
					]
				}
				
				""".formatted(safePrompt);
		//""" : 텍스트 블록 줄바꿈 허용. 즉, \n안써도된다는 뜻. JSON데이터 코딩할때 편리하다.
		//%s : safePrompt 값을 넣겠다.
		
		HttpClient client = HttpClient.newHttpClient();
		//외부 서버랑 통신하고 싶을 때. 전화기라고 생각하면 됨. HttpRequest 젆놔내용, HttpResponse 상대방답변
		//HttpClient는 인터페이스이므로 new 키워드 없이 newHttpClient() 정적 메서드 사용
		
		HttpRequest request = HttpRequest.newBuilder()
				.uri(URI.create("https://api.groq.com/openai/v1/chat/completions"))
				//전화걸 주소
				.header("Content-Type", "application/json")
				//json형식으로 보낸다.
				.header("Authorization", "Bearer "+ apiKey)
				//내api키로 인증한다 (Bearer 뒤에 공백 필요!)
				.POST(HttpRequest.BodyPublishers.ofString(jsonBody))
				//보낼내용 json문자열
				.build();
		
		HttpResponse<String> response = client.send(request, HttpResponse.BodyHandlers.ofString());
		//client.send() 응답내용을 String으로 보내주세요.
		
		System.out.println("Groq response");
		System.out.println(response.body());
		
		JSONObject json = new JSONObject(response.body());
		//문자열(json) - 자바객체로 변환
		
		if(json.has("error")) {
			throw new RuntimeException(json.getJSONObject("error").getString("message"));
		}
		return json.getJSONArray("choices")		//choices 배열 꺼내고
				.getJSONObject(0)				//첫번째 응답 선택하고
				.getJSONObject("message")		//message객체 꺼내고
				.getString("content");			//Ai가 쓴 글 내용만 추출한다.
	}
	
	//블로그 글 생성
	public String makeBlogContent(String title) throws Exception {
		String prompt = "다음 제목으로 블로그 글을 작성해줘:\n" +title;
		return callGroq(prompt);
		
	}
	//한글 -> 일본어 번역
	public String translateToJp(String text) throws Exception {
		String prompt =
				"You are a translation engine.\n" +
				"Translate the following Korean text into Japanese.\n" +
				"Output ONLY Japanese. Do NOT include Korean. Do NOT explain.\n\n" +
				text;
		return callGroq(prompt);
	}
	
	//영어 번역
	public String translateToEnglish(String text) throws Exception {
		String prompt =
				"You are a professional translation engine.\n" +
				"Translate the following Korean text into natural English.\n" +
				"Output ONLY English.\n" +
				"Do NOT include Korean.\n" +
				"Do NOT explain.\n\n" +
				text;
		return callGroq(prompt);
	}
	
	//중국어 번역
	public String translateToChinese(String text) throws Exception {
		String prompt =
				"You are a professional translation engine.\n" +
				"Translate the following Korean text into Simplified Chinese.\n" +
				"Output ONLY Simplified Chinese.\n" +
				"Do NOT include Korean.\n" +
				"Do NOT explain.\n\n" +
				text;
		return callGroq(prompt);
	}
}




