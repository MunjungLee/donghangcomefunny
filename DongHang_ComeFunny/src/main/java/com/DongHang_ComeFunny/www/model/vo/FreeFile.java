package com.DongHang_ComeFunny.www.model.vo;

public class FreeFile {
	private int ffNo; 
	private int ffFbNo;
	private String ffOriginFileName;
	private String ffStoredFileName;
	private int ffSize;
	private String ffSavePath;
	private int ffIsDel;
	@Override
	public String toString() {
		return "FreeFile [ffNo=" + ffNo + ", ffFbNo=" + ffFbNo + ", ffOriginFileName=" + ffOriginFileName
				+ ", ffStoredFileName=" + ffStoredFileName + ", ffSize=" + ffSize + ", ffSavePath=" + ffSavePath
				+ ", ffIsDel=" + ffIsDel + "]";
	}
	public int getFfNo() {
		return ffNo;
	}
	public void setFfNo(int ffNo) {
		this.ffNo = ffNo;
	}
	public int getFfFbNo() {
		return ffFbNo;
	}
	public void setFfFbNo(int ffFbNo) {
		this.ffFbNo = ffFbNo;
	}
	public String getFfOriginFileName() {
		return ffOriginFileName;
	}
	public void setFfOriginFileName(String ffOriginFileName) {
		this.ffOriginFileName = ffOriginFileName;
	}
	public String getFfStoredFileName() {
		return ffStoredFileName;
	}
	public void setFfStoredFileName(String ffStoredFileName) {
		this.ffStoredFileName = ffStoredFileName;
	}
	public int getFfSize() {
		return ffSize;
	}
	public void setFfSize(int ffSize) {
		this.ffSize = ffSize;
	}
	public String getFfSavePath() {
		return ffSavePath;
	}
	public void setFfSavePath(String ffSavePath) {
		this.ffSavePath = ffSavePath;
	}
	public int getFfIsDel() {
		return ffIsDel;
	}
	public void setFfIsDel(int ffIsDel) {
		this.ffIsDel = ffIsDel;
	}
	
	
	

}
