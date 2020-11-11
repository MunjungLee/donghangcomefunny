package com.DongHang_ComeFunny.www.model.vo;

public class QuestionFile {
	private int qfNo; 
	private int qfQbNo;
	private String qfOriginFileName;
	private String qfStoredFileName;
	private int qfSize;
	private String qfSavePath;
	private int qfIsDel;
	@Override
	public String toString() {
		return "QuestionFile [qfNo=" + qfNo + ", qfQbNo=" + qfQbNo + ", qfOriginFileName=" + qfOriginFileName
				+ ", qfStoredFileName=" + qfStoredFileName + ", qfSize=" + qfSize + ", qfSavePath=" + qfSavePath
				+ ", qfIsDel=" + qfIsDel + "]";
	}
	public int getQfNo() {
		return qfNo;
	}
	public void setQfNo(int qfNo) {
		this.qfNo = qfNo;
	}
	public int getQfQbNo() {
		return qfQbNo;
	}
	public void setQfQbNo(int qfQbNo) {
		this.qfQbNo = qfQbNo;
	}
	public String getQfOriginFileName() {
		return qfOriginFileName;
	}
	public void setQfOriginFileName(String qfOriginFileName) {
		this.qfOriginFileName = qfOriginFileName;
	}
	public String getQfStoredFileName() {
		return qfStoredFileName;
	}
	public void setQfStoredFileName(String qfStoredFileName) {
		this.qfStoredFileName = qfStoredFileName;
	}
	public int getQfSize() {
		return qfSize;
	}
	public void setQfSize(int qfSize) {
		this.qfSize = qfSize;
	}
	public String getQfSavePath() {
		return qfSavePath;
	}
	public void setQfSavePath(String qfSavePath) {
		this.qfSavePath = qfSavePath;
	}
	public int getQfIsDel() {
		return qfIsDel;
	}
	public void setQfIsDel(int qfIsDel) {
		this.qfIsDel = qfIsDel;
	}
	
	

}
