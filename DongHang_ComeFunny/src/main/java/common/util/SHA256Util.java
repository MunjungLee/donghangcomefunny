package common.util;

import java.util.Random;

public class SHA256Util {

	/**
	 * SALT를 얻어온다.
	 * @return
	 */
	public static String generateSalt() {
		Random random = new Random();
		
		byte[] salt = new byte[8];
		random.nextBytes(salt);
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < salt.length; i++) {
			// byte 값을 Hex 값으로 바꾸기.
			sb.append(String.format("%02x", salt[i]));
		}
		
		
		return sb.toString();
		
	}
	
}
