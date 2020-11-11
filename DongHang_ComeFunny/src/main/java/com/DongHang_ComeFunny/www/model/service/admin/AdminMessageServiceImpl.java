package com.DongHang_ComeFunny.www.model.service.admin;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.vo.Admin;
import com.DongHang_ComeFunny.www.model.vo.Message;

@Service
public class AdminMessageServiceImpl implements AdminMessageService {

	@Override
	public void writeMessage(Message writeMessageInfo) {
		Map<Object, String> writeMessage = new HashMap<>();
		
		writeMessage.put("msTitle", writeMessageInfo.getMsTitle());
		writeMessage.put("msContent", writeMessageInfo.getMsContent());
		writeMessage.put("msUNo", Integer.toString(writeMessageInfo.getMsUNo()));
		
		
	}

}
