package com.DongHang_ComeFunny.www.model.vo;

public class Admin {
	
	private int aNo;
	private String aId;
	private String apw;
	private String aName;
	private String aPhone;
	private String aMail;
	private int aIsDel;
	@Override
	public String toString() {
		return "Admin [aNo=" + aNo + ", aId=" + aId + ", apw=" + apw + ", aName=" + aName + ", aPhone=" + aPhone
				+ ", aMail=" + aMail + ", aIsDel=" + aIsDel + "]";
	}
	public int getaNo() {
		return aNo;
	}
	public void setaNo(int aNo) {
		this.aNo = aNo;
	}
	public String getaId() {
		return aId;
	}
	public void setaId(String aId) {
		this.aId = aId;
	}
	public String getApw() {
		return apw;
	}
	public void setApw(String apw) {
		this.apw = apw;
	}
	public String getaName() {
		return aName;
	}
	public void setaName(String aName) {
		this.aName = aName;
	}
	public String getaPhone() {
		return aPhone;
	}
	public void setaPhone(String aPhone) {
		this.aPhone = aPhone;
	}
	public String getaMail() {
		return aMail;
	}
	public void setaMail(String aMail) {
		this.aMail = aMail;
	}
	public int getaIsDel() {
		return aIsDel;
	}
	public void setaIsDel(int aIsDel) {
		this.aIsDel = aIsDel;
	}
	
	
}
