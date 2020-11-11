package common.exception;

//상수를 다루기 위해서 Java 1.5버전 부터 추가
//코드(에러코드, 상태코드, 회원등급코드...)를 다루기 위해서 사용
//연관된 데이터들을 한번에 다룰 수가 있다.
public enum ErrorCode {
	
	//메일 에러코드 등록
	M_ERROR_01("메일 전송 중 에러가 발생하였습니다."
				, "join"	),
	//파일 에러코드 등록
	F_ERROR_01("파일 등록 중 에러가 발생하였습니다."
				, "freelist");
	
	private String msg;
	private String url;
	
	ErrorCode(String msg, String url) {
		this.msg =msg;
		this.url =url;
	}

	public String getMsg() {
		return msg;
	}

	public String getUrl() {
		return url;
	}
	
	

}
