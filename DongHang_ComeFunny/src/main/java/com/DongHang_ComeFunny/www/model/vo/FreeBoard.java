package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class FreeBoard {
	private int fbNo;
	private int fbUNo;
	private String fbTitle;
	private String fbContent;
	private Date fbWrittenDate;
	private int fbHitsCnt;
	private int fbIsDel;
	private String fbWriter;
	
	@Override
	public String toString() {
		return "FreeBoard [fbNo=" + fbNo + ", fbUNo=" + fbUNo + ", fbTitle=" + fbTitle + ", fbContent=" + fbContent
				+ ", fbWrittenDate=" + fbWrittenDate + ", fbHitsCnt=" + fbHitsCnt + ", fbIsDel=" + fbIsDel
				+ ", fbWriter=" + fbWriter + "]";
	}
	public int getFbNo() {
		return fbNo;
	}
	public void setFbNo(int fbNo) {
		this.fbNo = fbNo;
	}
	public int getFbUNo() {
		return fbUNo;
	}
	public void setFbUNo(int fbUNo) {
		this.fbUNo = fbUNo;
	}
	public String getFbTitle() {
		return fbTitle;
	}
	public void setFbTitle(String fbTitle) {
		this.fbTitle = fbTitle;
	}
	public String getFbContent() {
		return fbContent;
	}
	public void setFbContent(String fbContent) {
		this.fbContent = fbContent;
	}
	public Date getFbWrittenDate() {
		return fbWrittenDate;
	}
	public void setFbWrittenDate(Date fbWrittenDate) {
		this.fbWrittenDate = fbWrittenDate;
	}
	public int getFbHitsCnt() {
		return fbHitsCnt;
	}
	public void setFbHitsCnt(int fbHitsCnt) {
		this.fbHitsCnt = fbHitsCnt;
	}
	public int getFbIsDel() {
		return fbIsDel;
	}
	public void setFbIsDel(int fbIsDel) {
		this.fbIsDel = fbIsDel;
	}
	public String getFbWriter() {
		return fbWriter;
	}
	public void setFbWriter(String fbWriter) {
		this.fbWriter = fbWriter;
	}
	
	
}
