package com.DongHang_ComeFunny.www.controller.user;

import java.util.Random;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.DongHang_ComeFunny.www.model.service.user.CoolSMSService;


@Controller
public class CoolSMSController {

	@Autowired CoolSMSService coolservice;
	
	@RequestMapping(value = "/sms_authentication", method = RequestMethod.GET)
	public String main() {
		System.out.println("[GET] /");
		return "/user/coolsms";
	}

	// 동행 요청 수락
	@RequestMapping(value = "/sms_authentication/sendmsg", method = RequestMethod.POST)
	@ResponseBody
	public String sendSMS(String phoneNumber) {
//      System.out.println("phoneNumber = " + phoneNumber);
		
		Random rand  = new Random();
		String numStr = "";
		for(int i=0; i<6; i++) {
			String ran = Integer.toString(rand.nextInt(10));
			numStr += ran;
		}

//		System.out.println("인증번호 : " + numStr);
		coolservice.sendMsg(phoneNumber,numStr);
		
		return numStr;

	}

}
