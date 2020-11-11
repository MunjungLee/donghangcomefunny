package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class FreeComment {
	private int fcNo;
	private int fcFbNo;
	private int fcUNo;
	private String fcContent;
	private Date fcWrittenDate;
	private int fcIsDel;
	@Override
	public String toString() {
		return "FreeComment [fcNo=" + fcNo + ", fcFbNo=" + fcFbNo + ", fcUNo=" + fcUNo + ", fcContent=" + fcContent
				+ ", fcWrittenDate=" + fcWrittenDate + ", fcIsDel=" + fcIsDel + "]";
	}
	public int getFcNo() {
		return fcNo;
	}
	public void setFcNo(int fcNo) {
		this.fcNo = fcNo;
	}
	public int getFcFbNo() {
		return fcFbNo;
	}
	public void setFcFbNo(int fcFbNo) {
		this.fcFbNo = fcFbNo;
	}
	public int getFcUNo() {
		return fcUNo;
	}
	public void setFcUNo(int fcUNo) {
		this.fcUNo = fcUNo;
	}
	public String getFcContent() {
		return fcContent;
	}
	public void setFcContent(String fcContent) {
		this.fcContent = fcContent;
	}
	public Date getFcWrittenDate() {
		return fcWrittenDate;
	}
	public void setFcWrittenDate(Date fcWrittenDate) {
		this.fcWrittenDate = fcWrittenDate;
	}
	public int getFcIsDel() {
		return fcIsDel;
	}
	public void setFcIsDel(int fcIsDel) {
		this.fcIsDel = fcIsDel;
	}
	
	

}
