package com.DongHang_ComeFunny.www.model.vo;

public class DoCheck {
	private int dcNo;
	private int dcDbNo;
	private String dcCate; //카테고리 
	private String dcValue; //값
	
	//------실제 DB에는 존재하지 않지만 name구분위해 사용함---------
	private String dcAgeGroup;
	private String dcTheme;
	
	
	@Override
	public String toString() {
		return "DoCheck [dcNo=" + dcNo + ", dcDbNo=" + dcDbNo + ", dcAgeGroup=" + dcAgeGroup + ", dcTheme=" + dcTheme
				+ "]";
	}
	
	
	public String getDcCate() {
		return dcCate;
	}

	public void setDcCate(String dcCate) {
		this.dcCate = dcCate;
	}

	public String getDcValue() {
		return dcValue;
	}

	public void setDcValue(String dcValue) {
		this.dcValue = dcValue;
	}


	public int getDcNo() {
		return dcNo;
	}
	public void setDcNo(int dcNo) {
		this.dcNo = dcNo;
	}
	public int getDcDbNo() {
		return dcDbNo;
	}
	public void setDcDbNo(int dcDbNo) {
		this.dcDbNo = dcDbNo;
	}
	public String getDcAgeGroup() {
		return dcAgeGroup;
	}
	public void setDcAgeGroup(String dcAgeGroup) {
		this.dcAgeGroup = dcAgeGroup;
	}
	public String getDcTheme() {
		return dcTheme;
	}
	public void setDcTheme(String dcTheme) {
		this.dcTheme = dcTheme;
	}
	
	

}
