package com.DongHang_ComeFunny.www.model.vo;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.springframework.web.multipart.MultipartFile;

 public class DoFileUtil {

	  public List<Map<String,String>> fileUpload(List<MultipartFile> files, String root){
		 
		  List<Map<String,String>> fileData 
		  			= new ArrayList<Map<String,String>>();
		  int idx = 0;
		  
		  for(MultipartFile mf : files) {
			  
			String savePath = root + "resources/upload/";
			String originFileName = mf.getOriginalFilename();
		    String renameFileName = getRenameFileName(originFileName, idx);
			HashMap<String,String> map = new HashMap<>();
			
			savePath += renameFileName;
			map.put("diOriginImgName", originFileName);
			map.put("diStoredImgName", renameFileName);
			map.put("diSavePath", savePath);
			
			fileData.add(map);
			saveFile(mf,savePath);
			idx++;
		}
		  return fileData;
	  }
	  
	  public void saveFile(MultipartFile mf, String savePath) {
		//사용자가 등록한 파일의 이름으로 빈 파일을 생성
		File fileData = new File(savePath);
		//생성된 빈파일을 사용해 사용자가 업로드한 파일을 저장
		try {
			mf.transferTo(fileData);
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	  }
	  
	  public String getRenameFileName(String originFileName, int idx) {
		  SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		  String renameFileName 
			= sdf.format(new Date(System.currentTimeMillis()))+ idx + "."
			+ originFileName.substring(originFileName.lastIndexOf(".") + 1);
		  
		  return renameFileName;
	  }
	  
	  public void deleteFile(String path) {
		  File file = new File(path);
		  file.delete();
	  }
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
	  
  }
		 