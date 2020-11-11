package com.DongHang_ComeFunny.www.model.vo;

public class UserImg {
	private int uiNo;
	private int uiUNo;
	private String uiOriginImgName;
	private String uiStoredImgName;
	private int uiSize;
	private String uiSavePath;
	private int uiIsDel;
	public int getUiNo() {
		return uiNo;
	}
	public void setUiNo(int uiNo) {
		this.uiNo = uiNo;
	}
	public int getUiUNo() {
		return uiUNo;
	}
	public void setUiUNo(int uiUNo) {
		this.uiUNo = uiUNo;
	}
	public String getUiOriginImgName() {
		return uiOriginImgName;
	}
	public void setUiOriginImgName(String uiOriginImgName) {
		this.uiOriginImgName = uiOriginImgName;
	}
	public String getUiStoredImgName() {
		return uiStoredImgName;
	}
	public void setUiStoredImgName(String uiStoredImgName) {
		this.uiStoredImgName = uiStoredImgName;
	}
	public int getUiSize() {
		return uiSize;
	}
	public void setUiSize(int uiSize) {
		this.uiSize = uiSize;
	}
	public String getUiSavePath() {
		return uiSavePath;
	}
	public void setUiSavePath(String uiSavePath) {
		this.uiSavePath = uiSavePath;
	}
	public int getUiIsDel() {
		return uiIsDel;
	}
	public void setUiIsDel(int uiIsDel) {
		this.uiIsDel = uiIsDel;
	}
	@Override
	public String toString() {
		return "UserImg [uiNo=" + uiNo + ", uiUNo=" + uiUNo + ", uiOriginImgName=" + uiOriginImgName
				+ ", uiStoredImgName=" + uiStoredImgName + ", uiSize=" + uiSize + ", uiSavePath=" + uiSavePath
				+ ", uiIsDel=" + uiIsDel + "]";
	}
	
	
	

}
