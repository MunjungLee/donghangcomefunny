package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class NoticeBoard {
	private int nbNo;
	private String nbTitle;
	private String nbContent;
	private Date nbWrittenDate;
	private int nbHitsCnt;
	private int nbIsDel;
	@Override
	public String toString() {
		return "NoticeBoard [nbNo=" + nbNo + ", nbTitle=" + nbTitle + ", nbContent=" + nbContent + ", nbWrittenDate="
				+ nbWrittenDate + ", nbHitsCnt=" + nbHitsCnt + ", nbIsDel=" + nbIsDel + ", nbOriFileName="+
				"]";
	}
	public int getNbNo() {
		return nbNo;
	}
	public void setNbNo(int nbNo) {
		this.nbNo = nbNo;
	}
	public String getNbTitle() {
		return nbTitle;
	}
	public void setNbTitle(String nbTitle) {
		this.nbTitle = nbTitle;
	}
	public String getNbContent() {
		return nbContent;
	}
	public void setNbContent(String nbContent) {
		this.nbContent = nbContent;
	}
	public Date getNbWrittenDate() {
		return nbWrittenDate;
	}
	public void setNbWrittenDate(Date nbWrittenDate) {
		this.nbWrittenDate = nbWrittenDate;
	}
	public int getNbHitsCnt() {
		return nbHitsCnt;
	}
	public void setNbHitsCnt(int nbHitsCnt) {
		this.nbHitsCnt = nbHitsCnt;
	}
	public int getNbIsDel() {
		return nbIsDel;
	}
	public void setNbIsDel(int nbIsDel) {
		this.nbIsDel = nbIsDel;
	}
	
	

}
