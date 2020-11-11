package com.DongHang_ComeFunny.www.model.service.message;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.DongHang_ComeFunny.www.model.vo.Message;
import com.DongHang_ComeFunny.www.model.vo.User;





public interface MessageService {


	public Map<String, Object> selectMessageList(User logUser, int cPage, int cntPerPage);

	public int deleteArray(String[] arr);

	public int delete(String res);

	public int storeArray(String[] arr);

	public int store(String res);

	public Map<String, Object> selectMessage(int msno);

	public User selectUserIdById(String string);

	public User selectUserIdByNick(String string);

	public int sendMailList(String[] arr, User sender, Message sendMessage);

	public int SendMail(String receiverId, User sender, Message sendMessage);

	public Map<String, Object> selectMyMsgList(User logUser, int cPage, int cntPerPage);

	public Map<String, Object> selectStoreMsgList(User logUser, int cPage, int cntPerPage);

	public Map<String, Object> selectSendList(User logUser, int cPage, int cntPerPage);

	
}
