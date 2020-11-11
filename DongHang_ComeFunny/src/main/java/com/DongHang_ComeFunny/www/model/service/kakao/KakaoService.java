package com.DongHang_ComeFunny.www.model.service.kakao;

import java.util.HashMap;

import com.DongHang_ComeFunny.www.model.vo.User;

public interface KakaoService {
	
	public String getAccessToken (String authorize_code);
	public HashMap<String, Object> getUserInfo (String access_Token);
	public User selectKakaoMember(HashMap<String, Object> userInfo);
	public int insertKakaoUser(User user);
}
