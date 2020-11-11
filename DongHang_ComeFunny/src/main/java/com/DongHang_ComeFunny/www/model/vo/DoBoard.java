package com.DongHang_ComeFunny.www.model.vo;

import java.sql.Date;

public class DoBoard {
	private String dbWriter;
	private int dbNo; //함께해요 게시글번호
	private int dbUNo; //함께해요게시글작성자번호
	private String dbTitle; //게시글제목
	private String dbContent; //게시글내용
	private Date dbWrittenDate; //게시글작성날짜
	private int dbLikeCnt; //게시글찜수
	private int dbIsDel; //게시글삭제여부
	private String dbRecruitDate; //모집날짜
	private String dbRecruitArea; //모집지역
	private int dbRecruitStatus; //모집상태
	private int dbRecruitNumber; //모집인원수
	private int dbRecruitGender; //모집성별
	private int dbRecruitCost; //모집회비
	private int dbDhstarAvg;
	private int dbHoststarAvg;
	private int dbStarCnt;
	private String dbCateGory;
	private int dbRecruitCnt;
	
	
	
	@Override
	public String toString() {
		return "DoBoard [dbWriter=" + dbWriter + ", dbNo=" + dbNo + ", dbUNo=" + dbUNo + ", dbTitle=" + dbTitle
				+ ", dbContent=" + dbContent + ", dbWrittenDate=" + dbWrittenDate + ", dbLikeCnt=" + dbLikeCnt
				+ ", dbIsDel=" + dbIsDel + ", dbRecruitDate=" + dbRecruitDate + ", dbRecruitArea=" + dbRecruitArea
				+ ", dbRecruitStatus=" + dbRecruitStatus + ", dbRecruitNumber=" + dbRecruitNumber + ", dbRecruitGender="
				+ dbRecruitGender + ", dbRecruitCost=" + dbRecruitCost + ", dbDhstarAvg=" + dbDhstarAvg
				+ ", dbHoststarAvg=" + dbHoststarAvg + ", dbStarCnt=" + dbStarCnt + ", dbCateGory=" + dbCateGory
				+ ", dbRecruitCnt=" + dbRecruitCnt + "]";
	}


	public int getDbRecruitCnt() {
		return dbRecruitCnt;
	}


	public void setDbRecruitCnt(int dbRecruitCnt) {
		this.dbRecruitCnt = dbRecruitCnt;
	}


	public int getDbDhstarAvg() {
		return dbDhstarAvg;
	}

	public void setDbDhstarAvg(int dbDhstarAvg) {
		this.dbDhstarAvg = dbDhstarAvg;
	}

	public int getDbHoststarAvg() {
		return dbHoststarAvg;
	}



	public void setDbHoststarAvg(int dbHoststarAvg) {
		this.dbHoststarAvg = dbHoststarAvg;
	}



	public int getDbStarCnt() {
		return dbStarCnt;
	}



	public void setDbStarCnt(int dbStarCnt) {
		this.dbStarCnt = dbStarCnt;
	}



	public String getDbCateGory() {
		return dbCateGory;
	}



	public void setDbCateGory(String dbCateGory) {
		this.dbCateGory = dbCateGory;
	}



	public int getDbRecruitCost() {
		return dbRecruitCost;
	}

	public void setDbRecruitCost(int dbRecruitCost) {
		this.dbRecruitCost = dbRecruitCost;
	}


	public int getDbNo() {
		return dbNo;
	}
	public void setDbNo(int dbNo) {
		this.dbNo = dbNo;
	}
	public int getDbUNo() {
		return dbUNo;
	}
	public void setDbUNo(int dbUNo) {
		this.dbUNo = dbUNo;
	}
	public String getDbTitle() {
		return dbTitle;
	}
	public void setDbTitle(String dbTitle) {
		this.dbTitle = dbTitle;
	}
	public String getDbContent() {
		return dbContent;
	}
	public void setDbContent(String dbContent) {
		this.dbContent = dbContent;
	}
	public Date getDbWrittenDate() {
		return dbWrittenDate;
	}
	public void setDbWrittenDate(Date dbWrittenDate) {
		this.dbWrittenDate = dbWrittenDate;
	}
	public int getDbLikeCnt() {
		return dbLikeCnt;
	}
	public void setDbLikeCnt(int dbLikeCnt) {
		this.dbLikeCnt = dbLikeCnt;
	}
	public int getDbIsDel() {
		return dbIsDel;
	}
	public void setDbIsDel(int dbIsDel) {
		this.dbIsDel = dbIsDel;
	}
	public String getDbRecruitDate() {
		return dbRecruitDate;
	}
	public void setDbRecruitDate(String dbRecruitDate) {
		this.dbRecruitDate = dbRecruitDate;
	}
	public String getDbRecruitArea() {
		return dbRecruitArea;
	}
	public void setDbRecruitArea(String dbRecruitArea) {
		this.dbRecruitArea = dbRecruitArea;
	}
	public int getDbRecruitStatus() {
		return dbRecruitStatus;
	}
	public void setDbRecruitStatus(int dbRecruitStatus) {
		this.dbRecruitStatus = dbRecruitStatus;
	}
	public int getDbRecruitNumber() {
		return dbRecruitNumber;
	}
	public void setDbRecruitNumber(int dbRecruitNumber) {
		this.dbRecruitNumber = dbRecruitNumber;
	}
	public int getDbRecruitGender() {
		return dbRecruitGender;
	}
	public void setDbRecruitGender(int dbRecruitGender) {
		this.dbRecruitGender = dbRecruitGender;
	}


	public String getDbWriter() {
		return dbWriter;
	}


	public void setDbWriter(String dbWriter) {
		this.dbWriter = dbWriter;
	}
	
	

}