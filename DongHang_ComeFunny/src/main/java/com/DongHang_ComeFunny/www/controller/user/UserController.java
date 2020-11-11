package com.DongHang_ComeFunny.www.controller.user;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.DongHang_ComeFunny.www.model.service.kakao.KakaoService;
import com.DongHang_ComeFunny.www.model.service.user.UserService;
import com.DongHang_ComeFunny.www.model.vo.User;

import common.util.Coolsms;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	public KakaoService kakaoService;
	
	@Autowired
	public UserService userService;
	
    @RequestMapping(value = "/sendSms", method=RequestMethod.POST)
    public String sendSms(HttpServletRequest request) throws Exception {

      String api_key = "NCSIDYQ0HSU27S93"; //위에서 받은 api key를 추가
      String api_secret = "DM4AFZ9YRSQBBBURE1ZFMYEL0COLNYP3";  //위에서 받은 api secret를 추가

      Coolsms coolsms = new Coolsms(api_key, api_secret);
      //이 부분은 홈페이지에서 받은 자바파일을 추가한다음 그 클래스를 import해야 쓸 수 있는 클래스이다.
      

      HashMap<String, String> set = new HashMap<String, String>();
      set.put("to", "01050429097"); // 수신번호

      set.put("from", (String)request.getParameter("from")); // 발신번호, jsp에서 전송한 발신번호를 받아 map에 저장한다.
      set.put("text", (String)request.getParameter("text")); // 문자내용, jsp에서 전송한 문자내용을 받아 map에 저장한다.
      set.put("type", "sms"); // 문자 타입

      System.out.println(set);

      JSONObject result = coolsms.send(set); // 보내기&전송결과받기

      if ((boolean)result.get("status") == true) {

        // 메시지 보내기 성공 및 전송결과 출력
        System.out.println("성공");
        System.out.println(result.get("group_id")); // 그룹아이디
        System.out.println(result.get("result_code")); // 결과코드
        System.out.println(result.get("result_message")); // 결과 메시지
        System.out.println(result.get("success_count")); // 메시지아이디
        System.out.println(result.get("error_count")); // 여러개 보낼시 오류난 메시지 수
      } else {

        // 메시지 보내기 실패
        System.out.println("실패");
        System.out.println(result.get("code")); // REST API 에러코드
        System.out.println(result.get("message")); // 에러메시지
      }

      return "user/login"; //문자 메시지 발송 성공했을때 number페이지로 이동함
    }

	
	@RequestMapping(value="/login", method=RequestMethod.GET)
	public ModelAndView login() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/login");
		return mav;
	}
	//카카오 로그인
	@RequestMapping(value = "/kakaologin", produces = "application/json")
    public String kakaoLogin(@RequestParam("code") String code , Model model, HttpSession session) {
     
     String token = kakaoService.getAccessToken(code);
     HashMap<String, Object> userInfo = kakaoService.getUserInfo(token);
     System.out.println("[userInfo] : " + userInfo);
     
     User res = kakaoService.selectKakaoMember(userInfo);
     
     if(res != null) {
    	 session.setAttribute("logInInfo", res);
    	 model.addAttribute("alertMsg", "로그인 성공");    	 
    	 model.addAttribute("url", "/");
    	 return "common/result";
     } else {
    	 model.addAttribute("alertMsg", "추가정보 입력 페이지로 이동합니다.");
    	 
    	 model.addAttribute("url", "kakaoLogin");
    	 model.addAttribute("user", userInfo);
    	 return "/user/kakaoLogin";
     }
    }
	
	//카카오 추가정보 입력
	@RequestMapping(value="/kakaojoin", method={RequestMethod.GET, RequestMethod.POST})
	public String kakaoJoin(Model model, HttpServletRequest request ) {
		String root = request.getContextPath();
		User user = new User();
		user.setUserId(request.getParameter("userId"));
		user.setuPw(request.getParameter("uPw"));
		user.setuName(request.getParameter("uName"));
		user.setuNick(request.getParameter("uNick"));
		user.setuPhone(request.getParameter("uPhone"));

		// 생일값 불러와서 넣기(년/월/일)
		String birthYear = request.getParameter("uBirthyy");
		String birthMonth = request.getParameter("uBirthmm");
		String birthDay = request.getParameter("uBirthdd");
		user.setuBirth(birthYear+birthMonth+birthDay);
		
		user.setuGender(Integer.parseInt(request.getParameter("uGender")));
		user.setuMail(request.getParameter("uMail"));
		// 주소값 불러와서 넣기(검색한 주소 / 상세주소 / 우편번호)
		String postNumber = request.getParameter("addr1");
		String defaultAddress = request.getParameter("addr2");
		String detailAddress =  user.getuAddress();
		if(detailAddress!= null) {
		user.setuAddress(defaultAddress +", "+detailAddress+" 우)"+postNumber);
		} else {
		user.setuAddress(defaultAddress +", "+ "우)"+postNumber);
		}
		int res = kakaoService.insertKakaoUser(user);
		
		 if(res > 0) { //addAttribute : ModelAndView의 addObject와 같다
		 model.addAttribute("alertMsg", "회원가입에 성공했습니다."); model.addAttribute("url",
		 root+"/");
		 
		 } else { model.addAttribute("alertMsg", "회원가입에 실패했습니다.");
		 model.addAttribute("url", root+"/user/login");
		 
		 }
		 
		
		return "common/result";
		
	}

	
	@RequestMapping(value="/loginimple", method=RequestMethod.POST)
	public String loginImpl(
			@RequestParam Map<String, Object> commandMap
			, HttpSession session
			, Model model
			) {
//		User res = userService.selectMember(commandMap);
		User res = userService.selectNKMember(commandMap);
		//로그인에 성공한다면
		if(res != null) {
			session.setAttribute("logInInfo", res);
			model.addAttribute("alertMsg", "로그인 성공~!");
			model.addAttribute("url", "/");
		} else {
			model.addAttribute("alertMsg", "로그인 실패~!");
			model.addAttribute("url", "login");
		}

		return "/common/result";

	}
	
	@RequestMapping(value="/join", method=RequestMethod.GET)
	public ModelAndView join() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/user/join");
		return mav;
	} 

	@RequestMapping(value="/joinimple", method=RequestMethod.POST)
	public String joinimpl(@ModelAttribute User user, Model model, HttpServletRequest request) {
		String root = request.getContextPath();
		// 생일값 불러와서 넣기(년/월/일)
		String birthYear = request.getParameter("uBirthyy");
		String birthMonth = request.getParameter("uBirthmm");
		String birthDay = request.getParameter("uBirthdd");
		user.setuBirth(birthYear+birthMonth+birthDay);
		
		// 주소값 불러와서 넣기(검색한 주소 / 상세주소 / 우편번호)
		String postNumber = request.getParameter("addr1");
		String defaultAddress = request.getParameter("addr2");
		String detailAddress =  user.getuAddress();
		user.setuAddress(defaultAddress +", "+detailAddress+" 우)"+postNumber+"");
		
		int res = userService.insertUser(user);
		if(res > 0) {
			//addAttribute : ModelAndView의 addObject와 같다
			model.addAttribute("alertMsg", "회원가입에 성공했습니다.");
			model.addAttribute("url", root+"/user/login");

		} else {
			model.addAttribute("alertMsg", "회원가입에 실패했습니다.");
			model.addAttribute("url", root+"/user/join");

		}

		return "common/result";

	}
	
	//아이디 중복 체크
	@RequestMapping(value="/idChk", method = RequestMethod.POST)
	@ResponseBody
	public void idChk(@RequestParam("userid")String user, HttpServletResponse response) throws Exception {
		userService.idChk(user, response);
	}
	
	//아이디 찾기 페이지
	@RequestMapping(value="/fId", method=RequestMethod.GET)
	public String fId() {
		return "/user/fId";
	}
	
	//아이디 찾기 액션
	@RequestMapping(value="/fId", method=RequestMethod.POST)
	@ResponseBody
	public String fId(@RequestParam Map<String, Object> commandMap) {
		
		//requestparm uname umail을 담을 빈 User 객체 생성
		User user = new User();
		user.setuName(commandMap.get("uName").toString());
		user.setuMail(commandMap.get("uMail").toString());
		String result = userService.fId(user);
		System.out.println("[controller] fid result : " + result);
		
		return result;
	}
		
	//비밀번호 찾기 페이지
	@RequestMapping(value="/fPw", method=RequestMethod.GET)
	public ModelAndView fPw(HttpSession session) {
			ModelAndView mav = new ModelAndView();
			int ran = new Random().nextInt(900000) + 100000;
			String random = String.valueOf(ran);
			session.setAttribute("random", random);
			mav.setViewName("/user/fPw");
			mav.addObject("random",random);
		return mav;
	}
	
	@RequestMapping(value="/createEmailCheck", method=RequestMethod.GET)
	@ResponseBody
	public boolean createEmailCheck(@RequestParam String uEmail, HttpServletRequest req){
	//이메일 인증 - 인증번호 발송
		HttpSession session = req.getSession(true);
		String sendEmailId = "donghangcome@gmail.com";
		String authCode = (String) session.getAttribute("random");
		session.setAttribute("authCode", authCode);
		String subject = "회원가입 인증 코드 발급 안내 입니다.";
		StringBuilder sb = new StringBuilder();
		sb.append("귀하의 인증 코드는 " + authCode + "입니다.");
		return userService.send(subject, sb.toString(), sendEmailId, uEmail);
	}

	//이메일 인증 - 인증번호 확인
	@RequestMapping(value="/emailAuth", method=RequestMethod.GET)
	@ResponseBody
		public ResponseEntity<String> emailAuth(HttpSession session){
		String originalJoinCode = (String) session.getAttribute("authCode");
		String originalRandom = (String) session.getAttribute("random");
		if(originalJoinCode.equals(originalRandom))
		return new ResponseEntity<String>("complete", HttpStatus.OK);
		else return new ResponseEntity<String>("false", HttpStatus.OK);
	}

	//인증메일 보내기위한 조회
	@RequestMapping(value="userChk", method = RequestMethod.GET)
	@ResponseBody
	public String userChk(String uName, String userId, String uEmail) {
		
		//uName, userId, uMail을 담을 객체 생성
		User user = new User();
		user.setuName(uName);
		user.setUserId(userId);
		user.setuMail(uEmail);

		String result = userService.userChk(user);
		if(result == null || result == "") {

			return "0";
		}
		else {
			return "1";
		}
	}
	
	//비밀번호 변경 페이지
	@RequestMapping(value="/fPwChange", method=RequestMethod.GET)
	public String fPwChange() {
		return "/user/fPwChange";
	}

	//비밀번호 변경
	@RequestMapping(value="/changePassword", method = RequestMethod.POST)
	public String changePassword(@RequestParam String userId
			, String uPw, Model model) {

		User user = new User();
		user.setUserId(userId);
		user.setuPw(uPw);
		System.out.println(user);
		
		int res = userService.updateUser(user);
		System.out.println("result = " + res);
		
		if(res > 0) {
			model.addAttribute("alertMsg", "비밀번호 변경에 성공했습니다.");
			model.addAttribute("url", "/user/login");
			
//			sessionUser.setuPw(user.getuPw());
		} else {
			model.addAttribute("alertMsg", "비밀번호 변경에 실패했습니다.");
			model.addAttribute("url", "/user/fPwChange");
		}
		
//		userService.changePassword(user);
		
		return "common/result";

	}
	
    @RequestMapping("/logout")
    public String logout(Model model, HttpSession session) {
        session.invalidate();
        model.addAttribute("alertMsg", "로그아웃 되었습니다.");
		model.addAttribute("url", "/user/login");
        return "common/result";
    }


	
	
	
}
