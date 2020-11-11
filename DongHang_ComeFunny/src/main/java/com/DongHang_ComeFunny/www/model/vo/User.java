package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class User {
	private int uNo;
	private String userId;
	private String uPw;
	private String uName;
	private String uBirth;
	private int uGender;
	private String uNick;
	private String uPhone;
	private String uMail;
	private String uAddress;
	private int uDhtCnt;
	private Date uRegDate;
	private int uIsLeave;
	
	public User() { }

	@Override
	public String toString() {
		return "User [uNo=" + uNo + ", userId=" + userId + ", uPw=" + uPw + ", uName=" + uName + ", uBirth=" + uBirth
				+ ", uGender=" + uGender + ", uNick=" + uNick + ", uPhone=" + uPhone + ", uMail=" + uMail
				+ ", uAddress=" + uAddress + ", uDhtCnt=" + uDhtCnt + ", uRegDate=" + uRegDate + ", uIsLeave="
				+ uIsLeave + "]";
	}

	public int getuNo() {
		return uNo;
	}

	public void setuNo(int uNo) {
		this.uNo = uNo;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getuPw() {
		return uPw;
	}

	public void setuPw(String uPw) {
		this.uPw = uPw;
	}

	public String getuName() {
		return uName;
	}

	public void setuName(String uName) {
		this.uName = uName;
	}

	public String getuBirth() {
		return uBirth;
	}

	public void setuBirth(String uBirth) {
		this.uBirth = uBirth;
	}

	public int getuGender() {
		return uGender;
	}

	public void setuGender(int uGender) {
		this.uGender = uGender;
	}

	public String getuNick() {
		return uNick;
	}

	public void setuNick(String uNick) {
		this.uNick = uNick;
	}

	public String getuPhone() {
		return uPhone;
	}

	public void setuPhone(String uPhone) {
		this.uPhone = uPhone;
	}

	public String getuMail() {
		return uMail;
	}

	public void setuMail(String uMail) {
		this.uMail = uMail;
	}

	public String getuAddress() {
		return uAddress;
	}

	public void setuAddress(String uAddress) {
		this.uAddress = uAddress;
	}

	public int getuDhtCnt() {
		return uDhtCnt;
	}

	public void setuDhtCnt(int uDhtCnt) {
		this.uDhtCnt = uDhtCnt;
	}

	public Date getuRegDate() {
		return uRegDate;
	}

	public void setuRegDate(Date uRegDate) {
		this.uRegDate = uRegDate;
	}

	public int getuIsLeave() {
		return uIsLeave;
	}

	public void setuIsLeave(int uIsLeave) {
		this.uIsLeave = uIsLeave;
	}

	


	
	
}