package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class QuestionBoard {
	
	private int qbNo;
	private int qbUNo;
	private String qbTitle;
	private String qbContent;
	private Date qbWrittenDate;
	private int qbStatus;
	private int qbIsDel;
	private String qbWriter;
	@Override
	public String toString() {
		return "QuestionBoard [qbNo=" + qbNo + ", qbUNo=" + qbUNo + ", qbTitle=" + qbTitle + ", qbContent=" + qbContent
				+ ", qbWrittenDate=" + qbWrittenDate + ", qbStatus=" + qbStatus + ", qbIsDel=" + qbIsDel + ", qbWriter="
				+ qbWriter + "]";
	}
	public int getQbNo() {
		return qbNo;
	}
	public void setQbNo(int qbNo) {
		this.qbNo = qbNo;
	}
	public int getQbUNo() {
		return qbUNo;
	}
	public void setQbUNo(int qbUNo) {
		this.qbUNo = qbUNo;
	}
	public String getQbTitle() {
		return qbTitle;
	}
	public void setQbTitle(String qbTitle) {
		this.qbTitle = qbTitle;
	}
	public String getQbContent() {
		return qbContent;
	}
	public void setQbContent(String qbContent) {
		this.qbContent = qbContent;
	}
	public Date getQbWrittenDate() {
		return qbWrittenDate;
	}
	public void setQbWrittenDate(Date qbWrittenDate) {
		this.qbWrittenDate = qbWrittenDate;
	}
	public int getQbStatus() {
		return qbStatus;
	}
	public void setQbStatus(int qbStatus) {
		this.qbStatus = qbStatus;
	}
	public int getQbIsDel() {
		return qbIsDel;
	}
	public void setQbIsDel(int qbIsDel) {
		this.qbIsDel = qbIsDel;
	}
	public String getQbWriter() {
		return qbWriter;
	}
	public void setQbWriter(String qbWriter) {
		this.qbWriter = qbWriter;
	}
	
	

}
