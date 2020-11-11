package com.DongHang_ComeFunny.www.model.vo;

public class AnswerImg {
	private int aiNo;
	private int aiAbNo;
	private String aiOriginImgName;
	private String aiStoredImgName;
	private int aiSize;
	private String aiSavePath;
	private int aiIsDel;
	@Override
	public String toString() {
		return "AnswerImg [aiNo=" + aiNo + ", aiAbNo=" + aiAbNo + ", aiOriginImgName=" + aiOriginImgName
				+ ", aiStoredImgName=" + aiStoredImgName + ", aiSize=" + aiSize + ", aiSavePath=" + aiSavePath
				+ ", aiIsDel=" + aiIsDel + "]";
	}
	public int getAiNo() {
		return aiNo;
	}
	public void setAiNo(int aiNo) {
		this.aiNo = aiNo;
	}
	public int getAiAbNo() {
		return aiAbNo;
	}
	public void setAiAbNo(int aiAbNo) {
		this.aiAbNo = aiAbNo;
	}
	public String getAiOriginImgName() {
		return aiOriginImgName;
	}
	public void setAiOriginImgName(String aiOriginImgName) {
		this.aiOriginImgName = aiOriginImgName;
	}
	public String getAiStoredImgName() {
		return aiStoredImgName;
	}
	public void setAiStoredImgName(String aiStoredImgName) {
		this.aiStoredImgName = aiStoredImgName;
	}
	public int getAiSize() {
		return aiSize;
	}
	public void setAiSize(int aiSize) {
		this.aiSize = aiSize;
	}
	public String getAiSavePath() {
		return aiSavePath;
	}
	public void setAiSavePath(String aiSavePath) {
		this.aiSavePath = aiSavePath;
	}
	public int getAiIsDel() {
		return aiIsDel;
	}
	public void setAiIsDel(int aiIsDel) {
		this.aiIsDel = aiIsDel;
	}
	
	

}
