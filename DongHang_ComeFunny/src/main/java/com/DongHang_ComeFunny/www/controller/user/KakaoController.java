package com.DongHang_ComeFunny.www.controller.user;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Controller;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class KakaoController {

  private final static String K_CLIENT_ID = "55deebfe6e9f733314183edf1a04228e";
  private final static String K_REDIRECT_URI = "http://localhost:8088";

  public String getAuthorizationUrl(HttpSession session) {

    String kakaoUrl = "https://kauth.kakao.com/oauth/authorize?"
        + "client_id=" + K_CLIENT_ID + "&redirect_uri="
        + K_REDIRECT_URI + "&response_type=code";
    return kakaoUrl;
  }

  public String getAccessToken(String autorize_code) {

    final String RequestUrl = "https://kauth.kakao.com/oauth/token";
    final List<NameValuePair> postParams = new ArrayList<NameValuePair>();
    postParams.add(new BasicNameValuePair("grant_type", "authorization_code"));
    postParams.add(new BasicNameValuePair("client_id", "55deebfe6e9f733314183edf1a04228e")); // REST API KEY
    postParams.add(new BasicNameValuePair("redirect_uri", "http://localhost:8088")); // 리다이렉트 URI
    postParams.add(new BasicNameValuePair("code", autorize_code)); // 로그인 과정 중 얻은 code 값

    final HttpClient client = HttpClientBuilder.create().build();
    final HttpPost post = new HttpPost(RequestUrl);
    JsonNode returnNode = null;

    try {

      post.setEntity(new UrlEncodedFormEntity(postParams));
      final HttpResponse response = client.execute(post);
      final int responseCode = response.getStatusLine().getStatusCode();

      // JSON 형태 반환값 처리

      ObjectMapper mapper = new ObjectMapper();
      returnNode = mapper.readTree(response.getEntity().getContent());

    } catch (UnsupportedEncodingException e) {

      e.printStackTrace();

    } catch (ClientProtocolException e) {

      e.printStackTrace();

    } catch (IOException e) {

      e.printStackTrace();

    } finally {
      // clear resources
    }
    return returnNode.get("access_token").toString();
  }

  public JsonNode getKakaoUserInfo(String autorize_code) {

    final String RequestUrl = "https://kapi.kakao.com/v1/user/me";
    //String CLIENT_ID = K_CLIENT_ID; // REST API KEY
    //String REDIRECT_URI = K_REDIRECT_URI; // 리다이렉트 URI
    //String code = autorize_code; // 로그인 과정중 얻은 토큰 값
    final HttpClient client = HttpClientBuilder.create().build();
    final HttpPost post = new HttpPost(RequestUrl);
    String accessToken = getAccessToken(autorize_code);
    // add header
    post.addHeader("Authorization", "Bearer " + accessToken);

    JsonNode returnNode = null;

    try {

      final HttpResponse response = client.execute(post);
      final int responseCode = response.getStatusLine().getStatusCode();
      System.out.println("\nSending 'POST' request to URL : " + RequestUrl);
      System.out.println("Response Code : " + responseCode);

      // JSON 형태 반환값 처리
      ObjectMapper mapper = new ObjectMapper();
      returnNode = mapper.readTree(response.getEntity().getContent());
    } catch (UnsupportedEncodingException e) {

      e.printStackTrace();
    } catch (ClientProtocolException e) {

      e.printStackTrace();
    } catch (IOException e) {

      e.printStackTrace();
    } finally {

      // clear resources
    }
    return returnNode;
  }
}

//--------------------------------

//@Autowired
//SqlSession sql;
//
//@RequestMapping("/login")
//public void login(HttpServletRequest req, HttpServletResponse res) {
//
//		try {
//			String url = "https://kauth.kakao.com/oauth/authorize";
//			url += "?client_id=5e45e7bcbf5c5c786829735f9be1f6ac&redirect_uri=";
//			url += URLEncoder.encode("http://localhost:8080/KakaoLogin", "UTF-8");
//			url += "&response_type=code";
//			System.out.println("/login : " + url);
//			res.sendRedirect(url);
//			
//		} catch (UnsupportedEncodingException e) {
//			e.printStackTrace();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//}
//
//@RequestMapping("/KakaoLogin")
//public void kakao(HttpServletRequest req, HttpServletResponse res) {
//	try {
//		String code = req.getParameter("code");
//		System.out.println("code : " + code);
//		String url = "https://kauth.kakao.com/oauth/token";
//		url += "?client_id=5e45e7bcbf5c5c786829735f9be1f6ac&redirect_uri=";
//		url += URLEncoder.encode("http://localhost:8080/KakaoLogin", "UTF-8");
//		url += "&code=" + code;
//		url += "&grant_type=authorization_code";
//		System.out.println("/kakaoLogin : " + url);
//		
//		URL u = new URL(url);
//		HttpURLConnection urlConnect = (HttpURLConnection) u.openConnection();
//		urlConnect.setRequestMethod("POST");
//		int resCode = urlConnect.getResponseCode();
//		//System.out.println(resCode);
//		//400 문법오류
//		//500 네트워크 오류
//		if(resCode == 200) {
//			InputStream input = urlConnect.getInputStream();
//			InputStreamReader inputReader = new InputStreamReader(input, "UTF-8");
//			BufferedReader br = new BufferedReader(inputReader);
//			String line = "";
//			String result = "";
//			while((line = br.readLine()) != null) {
//				result += line;
//			}
//			System.out.println("result : " + result);
//			
//			JSONObject jObject = JSONObject.fromObject(result);
//			String access_token = jObject.getString("access_token");
//			System.out.println("access_token : " + access_token);
//			
//			String userUrl = "https://kapi.kakao.com/v2/user/me";
//			userUrl += "?access_token=" + access_token;
//			System.out.println("userUrl : " + userUrl);
//			
//			u = new URL(userUrl);
//			urlConnect = (HttpURLConnection)u.openConnection();
//			urlConnect.setRequestMethod("POST");
//			resCode = urlConnect.getResponseCode();
//			if(resCode == 200) {
//				input = urlConnect.getInputStream();
//				inputReader = new InputStreamReader(input, "UTF-8");
//			    br = new BufferedReader(inputReader);
//				line = "";
//				result = "";
//				while((line = br.readLine()) != null) {
//					result += line;
//				}
//				System.out.println("userUrl result : " + result);
//				JSONObject jsonUser = JSONObject.fromObject(result);
//				
//				String id = jsonUser.get("id").toString();
//				JSONObject properties = (JSONObject) jsonUser.get("properties");
//				
//				String nickname = properties.getString("nickname");
//				String profile_image = properties.getString("profile_image");
//				String thumbnail_image = properties.getString("thumbnail_image");
//				
//				HashMap<String, Object> resultMap = new HashMap<String, Object>();
//				resultMap.put("id", id);
//				resultMap.put("nickname", nickname);
//				resultMap.put("profile_image", profile_image);
//				resultMap.put("thumbnail_image", thumbnail_image);
////				System.out.println("resultMap : " + resultMap.toString());
//				
////				HttpSession session = req.getSession();
////				session.setAttribute("id", id);
////				String sessionId = session.getAttribute("id").toString();
////				System.out.println("sessionId : " + sessionId);
//				
////				String checkId = sql.select("user.select", (String) resultMap.get(id));
//				System.out.println(id);
////				System.out.println(checkId);
////				if(id != checkId) {
////					sql.insert("user.insert", resultMap);
////				}
//			}
//			
//			input.close();
//		}
//		res.sendRedirect("/");
//	} catch (UnsupportedEncodingException e) {
//		e.printStackTrace();
//	} catch (IOException e) {
//		e.printStackTrace();
//	}
//
//}