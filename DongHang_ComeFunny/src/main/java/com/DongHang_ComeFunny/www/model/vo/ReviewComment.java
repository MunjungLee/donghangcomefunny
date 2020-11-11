package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class ReviewComment {
	private int rcNo;
	private int rcRbNo;
	private int rcUNo;
	private String rcContent;
	private Date rcWrittenDate;
	private int rcIsDel;
	
	public ReviewComment() {	}
	
	@Override
	public String toString() {
		return "ReviewComment [rcNo=" + rcNo + ", rcRbNo=" + rcRbNo + ", rcUNo=" + rcUNo + ", rcContent=" + rcContent
				+ ", rcWrittenDate=" + rcWrittenDate + ", rcIsDel=" + rcIsDel + "]";
	}
	public int getRcNo() {
		return rcNo;
	}
	public void setRcNo(int rcNo) {
		this.rcNo = rcNo;
	}
	public int getRcRbNo() {
		return rcRbNo;
	}
	public void setRcRbNo(int rcRbNo) {
		this.rcRbNo = rcRbNo;
	}
	public int getRcUNo() {
		return rcUNo;
	}
	public void setRcUNo(int rcUNo) {
		this.rcUNo = rcUNo;
	}
	public String getRcContent() {
		return rcContent;
	}
	public void setRcContent(String rcContent) {
		this.rcContent = rcContent;
	}
	public Date getRcWrittenDate() {
		return rcWrittenDate;
	}
	public void setRcWrittenDate(Date rcWrittenDate) {
		this.rcWrittenDate = rcWrittenDate;
	}
	public int getRcIsDel() {
		return rcIsDel;
	}
	public void setRcIsDel(int rcIsDel) {
		this.rcIsDel = rcIsDel;
	}
	
	
	
}
