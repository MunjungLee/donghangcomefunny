package com.DongHang_ComeFunny.www.model.service.admin;

import org.springframework.stereotype.Service;

import com.DongHang_ComeFunny.www.model.vo.Message;

@Service
public interface AdminMessageService {

	void writeMessage(Message writeMessageInfo);

}
