package common.util;

import java.io.File;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import common.exception.FileException;

public class FileUtil {
	
	public List<Map<String, Object>> fileUpload(
			List<MultipartFile> files, String root
		) throws FileException {
	//renameFIleName에 붙을 인덱스
	int idx = 0;
	//빈 리스트 객체 생성
	List<Map<String, Object>> filedata = new ArrayList<Map<String, Object>>();
	
	for(MultipartFile mf : files) {
		//빈 파일을 생성할 경로
		String savePath = root + "resources/upload";
//		System.out.println(savePath);
		
		//----------------------------------------
		//tb_file에 넣을 데이터 추출
		//originFileName, renameFileName, SavePath
		String originFileName = mf.getOriginalFilename();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		//저장할 파일 이름 생성
		String storedFileName = sdf.format(
				new Date(System.currentTimeMillis() ) ) + idx +"."
				+ originFileName.substring(originFileName.lastIndexOf(".")+1);
		Long fileSize = mf.getSize();
		
		idx++;
		//파일 저장 위치
		savePath += "/" + storedFileName;
		
		//파일에 대한 정보를 map에 저장
		HashMap<String, Object> map = new HashMap<>();
		map.put("originFileName", originFileName);
		map.put("storedFileName", storedFileName);
		map.put("savePath", savePath);
		map.put("fileSize", fileSize);
		
		//완성된 map을 list에 담음
		filedata.add(map);
		
		//사용자가 등록한 파일의 이름으로 빈 파일을 생성
		File file = new File(savePath);
		try {
			//생성된 빈파일을 사용해 사용자가 업료드한 파일을 저장
			mf.transferTo(file);
//		} catch (IllegalStateException | IOException e) {
		} catch (Exception e) {
			e.printStackTrace();
			throw new FileException("F_ERROR_01");
		}
	}
	
	return filedata;
	}
	
	public void deleteFile(String path) {
		File file = new File(path);
		file.delete();
	}
}
