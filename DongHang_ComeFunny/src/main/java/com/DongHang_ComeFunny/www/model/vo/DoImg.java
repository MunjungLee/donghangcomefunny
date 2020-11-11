package com.DongHang_ComeFunny.www.model.vo;

public class DoImg {
	private int diNo;
	private int diDbNo;
	private String diOriginImgName;
	private String diStoredImgName;
	private int diSize;
	private String diSavePath;
	private int diIsDel;
	@Override
	public String toString() {
		return "DoImg [diNo=" + diNo + ", diDbNo=" + diDbNo + ", diOriginImgName=" + diOriginImgName
				+ ", diStoredImgName=" + diStoredImgName + ", diSize=" + diSize + ", diSavePath=" + diSavePath
				+ ", diIsDel=" + diIsDel + "]";
	}
	public int getDiNo() {
		return diNo;
	}
	public void setDiNo(int diNo) {
		this.diNo = diNo;
	}
	public int getDiDbNo() {
		return diDbNo;
	}
	public void setDiDbNo(int diDbNo) {
		this.diDbNo = diDbNo;
	}
	public String getDiOriginImgName() {
		return diOriginImgName;
	}
	public void setDiOriginImgName(String diOriginImgName) {
		this.diOriginImgName = diOriginImgName;
	}
	public String getDiStoredImgName() {
		return diStoredImgName;
	}
	public void setDiStoredImgName(String diStoredImgName) {
		this.diStoredImgName = diStoredImgName;
	}
	public int getDiSize() {
		return diSize;
	}
	public void setDiSize(int diSize) {
		this.diSize = diSize;
	}
	public String getDiSavePath() {
		return diSavePath;
	}
	public void setDiSavePath(String diSavePath) {
		this.diSavePath = diSavePath;
	}
	public int getDiIsDel() {
		return diIsDel;
	}
	public void setDiIsDel(int diIsDel) {
		this.diIsDel = diIsDel;
	}
	
	
	

}
