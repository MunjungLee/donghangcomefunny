package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class ReviewDhTicket {
	private int dhtNo;
	private int dhtRbNo;
	private int dhtUNo;
	private int dhtStatus;
	private Date dhtUsedDate;
	
	public ReviewDhTicket() {	}

	@Override
	public String toString() {
		return "ReviewDhTicket [dhtNo=" + dhtNo + ", dhtRbNo=" + dhtRbNo + ", dhtUNo=" + dhtUNo + ", dhtStatus="
				+ dhtStatus + ", dhtUsedDate=" + dhtUsedDate + "]";
	}

	public int getDhtNo() {
		return dhtNo;
	}

	public void setDhtNo(int dhtNo) {
		this.dhtNo = dhtNo;
	}

	public int getDhtRbNo() {
		return dhtRbNo;
	}

	public void setDhtRbNo(int dhtRbNo) {
		this.dhtRbNo = dhtRbNo;
	}

	public int getDhtUNo() {
		return dhtUNo;
	}

	public void setDhtUNo(int dhtUNo) {
		this.dhtUNo = dhtUNo;
	}

	public int getDhtStatus() {
		return dhtStatus;
	}

	public void setDhtStatus(int dhtStatus) {
		this.dhtStatus = dhtStatus;
	}

	public Date getDhtUsedDate() {
		return dhtUsedDate;
	}

	public void setDhtUsedDate(Date dhtUsedDate) {
		this.dhtUsedDate = dhtUsedDate;
	}

	
	
	

}
