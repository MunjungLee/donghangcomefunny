package com.DongHang_ComeFunny.www.model.vo;

public class UserFile {
	private int ufNo; 
	private int ufUNo;
	private String ufOriginFileName;
	private String ufStoredFileName;
	private int ufSize;
	private String ufSavePath;
	private int ufIsDel;
	@Override
	public String toString() {
		return "UserFile [ufNo=" + ufNo + ", ufUNo=" + ufUNo + ", ufOriginFileName=" + ufOriginFileName
				+ ", ufStoredFileName=" + ufStoredFileName + ", ufSize=" + ufSize + ", ufSavePath=" + ufSavePath
				+ ", ufIsDel=" + ufIsDel + "]";
	}
	public int getUfNo() {
		return ufNo;
	}
	public void setUfNo(int ufNo) {
		this.ufNo = ufNo;
	}
	public int getUfUNo() {
		return ufUNo;
	}
	public void setUfUNo(int ufUNo) {
		this.ufUNo = ufUNo;
	}
	public String getUfOriginFileName() {
		return ufOriginFileName;
	}
	public void setUfOriginFileName(String ufOriginFileName) {
		this.ufOriginFileName = ufOriginFileName;
	}
	public String getUfStoredFileName() {
		return ufStoredFileName;
	}
	public void setUfStoredFileName(String ufStoredFileName) {
		this.ufStoredFileName = ufStoredFileName;
	}
	public int getUfSize() {
		return ufSize;
	}
	public void setUfSize(int ufSize) {
		this.ufSize = ufSize;
	}
	public String getUfSavePath() {
		return ufSavePath;
	}
	public void setUfSavePath(String ufSavePath) {
		this.ufSavePath = ufSavePath;
	}
	public int getUfIsDel() {
		return ufIsDel;
	}
	public void setUfIsDel(int ufIsDel) {
		this.ufIsDel = ufIsDel;
	}
	
	

}
