package com.DongHang_ComeFunny.www.model.vo;

public class NoticeFile {
	private int nfNo; 
	private int nfNbNo;
	private String nfOriginFileName;
	private String nfStoredFileName;
	private int nfSize;
	private String nfSavePath;
	private int nfIsDel;
	@Override
	public String toString() {
		return "NoticeFile [nfNo=" + nfNo + ", nfNbNo=" + nfNbNo + ", nfOriginFileName=" + nfOriginFileName
				+ ", nfStoredFileName=" + nfStoredFileName + ", nfSize=" + nfSize + ", nfSavePath=" + nfSavePath
				+ ", nfIsDel=" + nfIsDel + "]";
	}
	public int getNfNo() {
		return nfNo;
	}
	public void setNfNo(int nfNo) {
		this.nfNo = nfNo;
	}
	public int getNfNbNo() {
		return nfNbNo;
	}
	public void setNfNbNo(int nfNbNo) {
		this.nfNbNo = nfNbNo;
	}
	public String getNfOriginFileName() {
		return nfOriginFileName;
	}
	public void setNfOriginFileName(String nfOriginFileName) {
		this.nfOriginFileName = nfOriginFileName;
	}
	public String getNfStoredFileName() {
		return nfStoredFileName;
	}
	public void setNfStoredFileName(String nfStoredFileName) {
		this.nfStoredFileName = nfStoredFileName;
	}
	public int getNfSize() {
		return nfSize;
	}
	public void setNfSize(int nfSize) {
		this.nfSize = nfSize;
	}
	public String getNfSavePath() {
		return nfSavePath;
	}
	public void setNfSavePath(String nfSavePath) {
		this.nfSavePath = nfSavePath;
	}
	public int getNfIsDel() {
		return nfIsDel;
	}
	public void setNfIsDel(int nfIsDel) {
		this.nfIsDel = nfIsDel;
	}
	
	

}
