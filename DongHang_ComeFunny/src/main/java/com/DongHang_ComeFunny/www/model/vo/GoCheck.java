package com.DongHang_ComeFunny.www.model.vo;


public class GoCheck {
	private int gcNo; //체크박스번호
	private int gcGbNo; //게시글번호
	private String gcCate; //카테고리 
	private String gcValue; //값
	
	//------실제 DB에는 존재하지 않지만 name구분위해 사용함---------
	private String gcAgeGroup; //모집연령대
	private String gcTheme; //모집테마
	
	@Override
	public String toString() {
		return "GoCheck [gcNo=" + gcNo + ", gcGbNo=" + gcGbNo + ", gcAgeGroup=" + gcAgeGroup + ", gcTheme=" + gcTheme + "]";
	}

	
	public String getGcCate() {
		return gcCate;
	}


	public void setGcCate(String gcCate) {
		this.gcCate = gcCate;
	}


	public String getGcValue() {
		return gcValue;
	}


	public void setGcValue(String gcValue) {
		this.gcValue = gcValue;
	}


	public int getGcNo() {
		return gcNo;
	}

	public void setGcNo(int gcNo) {
		this.gcNo = gcNo;
	}

	public int getGcGbNo() {
		return gcGbNo;
	}

	public void setGcGbNo(int gcGbNo) {
		this.gcGbNo = gcGbNo;
	}

	public String getGcAgeGroup() {
		return gcAgeGroup;
	}

	public void setGcAgeGroup(String gcAgeGroup) {
		this.gcAgeGroup = gcAgeGroup;
	}

	public String getGcTheme() {
		return gcTheme;
	}

	public void setGcTheme(String gcTheme) {
		this.gcTheme = gcTheme;
	}

}
