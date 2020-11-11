package com.DongHang_ComeFunny.www.model.vo;

public class FreeImg {
	private int fiNo;
	private int fiFbNo;
	private String fiOriginImgName;
	private String fiStoredImgName;
	private int fiSize;
	private String fiSavePath;
	private int fiIsDel;
	@Override
	public String toString() {
		return "FreeImg [fiNo=" + fiNo + ", fiFbNo=" + fiFbNo + ", fiOriginImgName=" + fiOriginImgName
				+ ", fiStoredImgName=" + fiStoredImgName + ", fiSize=" + fiSize + ", fiSavePath=" + fiSavePath
				+ ", fiIsDel=" + fiIsDel + "]";
	}
	public int getFiNo() {
		return fiNo;
	}
	public void setFiNo(int fiNo) {
		this.fiNo = fiNo;
	}
	public int getFiFbNo() {
		return fiFbNo;
	}
	public void setFiFbNo(int fiFbNo) {
		this.fiFbNo = fiFbNo;
	}
	public String getFiOriginImgName() {
		return fiOriginImgName;
	}
	public void setFiOriginImgName(String fiOriginImgName) {
		this.fiOriginImgName = fiOriginImgName;
	}
	public String getFiStoredImgName() {
		return fiStoredImgName;
	}
	public void setFiStoredImgName(String fiStoredImgName) {
		this.fiStoredImgName = fiStoredImgName;
	}
	public int getFiSize() {
		return fiSize;
	}
	public void setFiSize(int fiSize) {
		this.fiSize = fiSize;
	}
	public String getFiSavePath() {
		return fiSavePath;
	}
	public void setFiSavePath(String fiSavePath) {
		this.fiSavePath = fiSavePath;
	}
	public int getFiIsDel() {
		return fiIsDel;
	}
	public void setFiIsDel(int fiIsDel) {
		this.fiIsDel = fiIsDel;
	}
	
	
	

}
