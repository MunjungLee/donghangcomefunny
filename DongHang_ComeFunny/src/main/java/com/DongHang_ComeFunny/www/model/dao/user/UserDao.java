package com.DongHang_ComeFunny.www.model.dao.user;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.DongHang_ComeFunny.www.model.vo.User;

@Repository
public class UserDao {
	@Autowired
	SqlSessionTemplate session;
	
	public User selectMember(
			Map<String, Object> commandMap) {
		
		return session.selectOne("USER.selectMember", commandMap);
	}
	
	public int insertUser(User user) {
		System.out.println("dao >>>>> : " + user);
		
		return session.insert("USER.insertUser", user);
	}
	
	public User selectMemberByUserId(String userid) {
		return session.selectOne("USER.selectMemberByUserId",userid);
	}

	public User selectMemberByUno(int uno) {
		return session.selectOne("USER.selectMemberByUno", uno);
	}

	public User selectMemberByUserNick(String nick) {
		return session.selectOne("USER.selectMemberByNick",nick);
	}
	
	public int idChk(String user) throws Exception {
		return session.selectOne("USER.idChk", user);
	}
	
	public User fId(User user) {
		return session.selectOne("USER.selectFindId", user);
	}
	
	public User findPassword(String umail) {
		return session.selectOne("USER.findPassword", umail);
	}
	
	public void changePassword(User user) throws Exception {
		session.update("USER.changePassword", user);
	}

	public int updateUser(User user) {
		return session.update("USER.changePassword", user);
	}

	public User userChk(User user) {
		return session.selectOne("USER.userChk", user);
	}
	
	public int updateDHBG(HashMap<String, Integer> param) {
		return session.update("USER.UpdataDHBGByUno", param);
	}
	
	public User selectKakaoMember(HashMap<String, Object> userInfo) {
		return session.selectOne("USER.selectMember", userInfo);
	}

	public int insertKakaoUser(User user) {
		System.out.println("dao >>>>> : " + user);
		
		return session.insert("USER.insertKakaoUser", user);
	}

	public User selectNKMember(Map<String, Object> commandMap) {
		return session.selectOne("USER.selectNKMember", commandMap);
	}

}
