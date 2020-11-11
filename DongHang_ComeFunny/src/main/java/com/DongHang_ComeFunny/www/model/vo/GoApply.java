package com.DongHang_ComeFunny.www.model.vo;

public class GoApply {
	private int gaNo; //신청번호
	private int gaGbNo; //게시글번호
	private int gaUNo; //회원번호
	private int gaStatus; //신청상태
	private String gaCategory;
	

	public GoApply() {	}


	@Override
	public String toString() {
		return "GoApply [gaNo=" + gaNo + ", gaGbNo=" + gaGbNo + ", gaUNo=" + gaUNo + ", gaStatus=" + gaStatus
				+ ", gaCategory=" + gaCategory + "]";
	}


	public int getGaNo() {
		return gaNo;
	}


	public void setGaNo(int gaNo) {
		this.gaNo = gaNo;
	}


	public int getGaGbNo() {
		return gaGbNo;
	}


	public void setGaGbNo(int gaGbNo) {
		this.gaGbNo = gaGbNo;
	}


	public int getGaUNo() {
		return gaUNo;
	}


	public void setGaUNo(int gaUNo) {
		this.gaUNo = gaUNo;
	}


	public int getGaStatus() {
		return gaStatus;
	}


	public void setGaStatus(int gaStatus) {
		this.gaStatus = gaStatus;
	}


	public String getGaCategory() {
		return gaCategory;
	}


	public void setGaCategory(String gaCategory) {
		this.gaCategory = gaCategory;
	}
	
	

	
}
