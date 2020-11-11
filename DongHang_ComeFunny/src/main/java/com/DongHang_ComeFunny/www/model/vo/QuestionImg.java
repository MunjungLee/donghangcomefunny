package com.DongHang_ComeFunny.www.model.vo;

public class QuestionImg {
	private int qiNo;
	private int qiQbNo;
	private String qiOriginImgName;
	private String qiStoredImgName;
	private int qqiSize;
	private String qiSavePath;
	private int qiIsDel;
	@Override
	public String toString() {
		return "QuestionImg [qiNo=" + qiNo + ", qiQbNo=" + qiQbNo + ", qiOriginImgName=" + qiOriginImgName
				+ ", qiStoredImgName=" + qiStoredImgName + ", qqiSize=" + qqiSize + ", qiSavePath=" + qiSavePath
				+ ", qiIsDel=" + qiIsDel + "]";
	}
	public int getQiNo() {
		return qiNo;
	}
	public void setQiNo(int qiNo) {
		this.qiNo = qiNo;
	}
	public int getQiQbNo() {
		return qiQbNo;
	}
	public void setQiQbNo(int qiQbNo) {
		this.qiQbNo = qiQbNo;
	}
	public String getQiOriginImgName() {
		return qiOriginImgName;
	}
	public void setQiOriginImgName(String qiOriginImgName) {
		this.qiOriginImgName = qiOriginImgName;
	}
	public String getQiStoredImgName() {
		return qiStoredImgName;
	}
	public void setQiStoredImgName(String qiStoredImgName) {
		this.qiStoredImgName = qiStoredImgName;
	}
	public int getQqiSize() {
		return qqiSize;
	}
	public void setQqiSize(int qqiSize) {
		this.qqiSize = qqiSize;
	}
	public String getQiSavePath() {
		return qiSavePath;
	}
	public void setQiSavePath(String qiSavePath) {
		this.qiSavePath = qiSavePath;
	}
	public int getQiIsDel() {
		return qiIsDel;
	}
	public void setQiIsDel(int qiIsDel) {
		this.qiIsDel = qiIsDel;
	}
	
	
	
	 
	

}
