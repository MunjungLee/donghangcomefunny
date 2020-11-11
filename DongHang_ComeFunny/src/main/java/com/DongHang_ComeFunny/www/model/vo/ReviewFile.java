package com.DongHang_ComeFunny.www.model.vo;

public class ReviewFile {
	private int rfNo; 
	private int rfRbNo;
	private String rfOriginFileName;
	private String rfStoredFileName;
	private int rfSize;
	private String rfSavePath;
	private int rfIsDel;
	@Override
	public String toString() {
		return "ReviewFile [rfNo=" + rfNo + ", rfRbNo=" + rfRbNo + ", rfOriginFileName=" + rfOriginFileName
				+ ", rfStoredFileName=" + rfStoredFileName + ", rfSize=" + rfSize + ", rfSavePath=" + rfSavePath
				+ ", rfIsDel=" + rfIsDel + "]";
	}
	public int getRfNo() {
		return rfNo;
	}
	public void setRfNo(int rfNo) {
		this.rfNo = rfNo;
	}
	public int getRfRbNo() {
		return rfRbNo;
	}
	public void setRfRbNo(int rfRbNo) {
		this.rfRbNo = rfRbNo;
	}
	public String getRfOriginFileName() {
		return rfOriginFileName;
	}
	public void setRfOriginFileName(String rfOriginFileName) {
		this.rfOriginFileName = rfOriginFileName;
	}
	public String getRfStoredFileName() {
		return rfStoredFileName;
	}
	public void setRfStoredFileName(String rfStoredFileName) {
		this.rfStoredFileName = rfStoredFileName;
	}
	public int getRfSize() {
		return rfSize;
	}
	public void setRfSize(int rfSize) {
		this.rfSize = rfSize;
	}
	public String getRfSavePath() {
		return rfSavePath;
	}
	public void setRfSavePath(String rfSavePath) {
		this.rfSavePath = rfSavePath;
	}
	public int getRfIsDel() {
		return rfIsDel;
	}
	public void setRfIsDel(int rfIsDel) {
		this.rfIsDel = rfIsDel;
	}
	
	

}
