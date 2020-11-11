package com.DongHang_ComeFunny.www.model.vo;

public class NoticeImg {
	private int niNo;
	private int niNbNo;
	private String niOriginImgName;
	private String niStoredImgName;
	private int niSize;
	private String niSavePath;
	private int niIsDel;
	@Override
	public String toString() {
		return "NoticeImg [niNo=" + niNo + ", niNbNo=" + niNbNo + ", niOriginImgName=" + niOriginImgName
				+ ", niStoredImgName=" + niStoredImgName + ", niSize=" + niSize + ", niSavePath=" + niSavePath
				+ ", niIsDel=" + niIsDel + "]";
	}
	public int getNiNo() {
		return niNo;
	}
	public void setNiNo(int niNo) {
		this.niNo = niNo;
	}
	public int getNiNbNo() {
		return niNbNo;
	}
	public void setNiNbNo(int niNbNo) {
		this.niNbNo = niNbNo;
	}
	public String getNiOriginImgName() {
		return niOriginImgName;
	}
	public void setNiOriginImgName(String niOriginImgName) {
		this.niOriginImgName = niOriginImgName;
	}
	public String getNiStoredImgName() {
		return niStoredImgName;
	}
	public void setNiStoredImgName(String niStoredImgName) {
		this.niStoredImgName = niStoredImgName;
	}
	public int getNiSize() {
		return niSize;
	}
	public void setNiSize(int niSize) {
		this.niSize = niSize;
	}
	public String getNiSavePath() {
		return niSavePath;
	}
	public void setNiSavePath(String niSavePath) {
		this.niSavePath = niSavePath;
	}
	public int getNiIsDel() {
		return niIsDel;
	}
	public void setNiIsDel(int niIsDel) {
		this.niIsDel = niIsDel;
	}

	
	
	

}
