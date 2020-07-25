package com.javaex.service;

import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.dao.BlogDao;
import com.javaex.vo.BlogVo;

@Service
public class BlogService {
	
	@Autowired
	BlogDao blogDao;
	
	public BlogVo blogInformation(String id) {
		return blogDao.blogInformation(id);
	}
	
	public int blogModify(BlogVo blogVo, MultipartFile file, String id) {
		
		if(file.getSize() == 0) {
			BlogVo saveBlogValue = blogDao.blogInformation(id);
			blogVo.setLogoFile(saveBlogValue.getLogoFile());
			blogVo.setId(id);
			
		}else {
		
			///// 데이터 추출 //////////////////////////////////
			String saveDir = "C:\\javaStudy\\upload";
				
			//원파일이름
			String orgName =  file.getOriginalFilename();
				
			//확장자
			String exName = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf("."));
			
			//저장파일이름
			String saveName = System.currentTimeMillis() + UUID.randomUUID().toString() + exName;    // 영문과 숫자가 겹친 임의의 문자를 줌
				
			//파일경로
			String filePath = saveDir + "\\" + saveName;
				
			//파일사이즈
			long fileSize = file.getSize();
				
				
			///// 파일 서버에 복사 ///////////////////////////////////////////////
			try{
				byte[]  fileData = file.getBytes();
				OutputStream out = new FileOutputStream(filePath);
				BufferedOutputStream bout = new BufferedOutputStream(out);
					
				bout.write(fileData);
				bout.close();
					
			} catch (IOException e) {
					e.printStackTrace();
			}
			blogVo.setLogoFile(saveName);
			
			blogVo.setId(id);
		}
		return blogDao.blogModify(blogVo);
	}

}
