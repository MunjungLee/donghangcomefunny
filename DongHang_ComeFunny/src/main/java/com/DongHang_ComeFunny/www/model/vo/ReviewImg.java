package com.DongHang_ComeFunny.www.model.vo;

public class ReviewImg {
	private int riNo;
	private int riRbNo;
	private String riOriginImgName;
	private String riStoredImgName;
	private int riSize;
	private String riSavePath;
	private int riIsDel;
	@Override
	public String toString() {
		return "ReviewImg [riNo=" + riNo + ", riRbNo=" + riRbNo + ", riOriginImgName=" + riOriginImgName
				+ ", riStoredImgName=" + riStoredImgName + ", riSize=" + riSize + ", riSavePath=" + riSavePath
				+ ", riIsDel=" + riIsDel + "]";
	}
	public int getRiNo() {
		return riNo;
	}
	public void setRiNo(int riNo) {
		this.riNo = riNo;
	}
	public int getRiRbNo() {
		return riRbNo;
	}
	public void setRiRbNo(int riRbNo) {
		this.riRbNo = riRbNo;
	}
	public String getRiOriginImgName() {
		return riOriginImgName;
	}
	public void setRiOriginImgName(String riOriginImgName) {
		this.riOriginImgName = riOriginImgName;
	}
	public String getRiStoredImgName() {
		return riStoredImgName;
	}
	public void setRiStoredImgName(String riStoredImgName) {
		this.riStoredImgName = riStoredImgName;
	}
	public int getRiSize() {
		return riSize;
	}
	public void setRiSize(int riSize) {
		this.riSize = riSize;
	}
	public String getRiSavePath() {
		return riSavePath;
	}
	public void setRiSavePath(String riSavePath) {
		this.riSavePath = riSavePath;
	}
	public int getRiIsDel() {
		return riIsDel;
	}
	public void setRiIsDel(int riIsDel) {
		this.riIsDel = riIsDel;
	}
	
	

}
