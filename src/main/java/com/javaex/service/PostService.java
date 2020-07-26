package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CategoryDao;
import com.javaex.dao.PostDao;
import com.javaex.util.Paging;
import com.javaex.vo.PostVo;

@Service
public class PostService {
	
	@Autowired
	private PostDao postDao;
	
	@Autowired
	private CategoryDao categoryDao;
	
	public PostVo getPost(PostVo postVo, String id) {
		
		if(postVo.getCateNo() != 0 && postVo.getPostNo() != 0) {
			System.out.println("카테고리값과 포스트값이 둘 다 있을 경우"); 
			return postDao.selectPost(postVo); 
		}else if(postVo.getCateNo() != 0){
			System.out.println("카테고리값만 있을 경우");
			if(postDao.allPost(postVo.getCateNo())!= 0) {
				postVo.setPostNo(postDao.maxPostNo(postVo.getCateNo()));
			}
			return postDao.selectPost(postVo); 
		}else{ 
			System.out.println("파람값없음."); 
			return postDao.getPost(categoryDao.maxCategoryNo(id));
		}
	}
	
	public int postWrite(PostVo postVo, String id) {
		postVo.setId(id);
		return postDao.postWrite(postVo);
	}
	
	public Map<String, Object> postList(String id, PostVo postVo, int pg) {
		
		if(postVo.getCateNo() == 0) {
			postVo.setCateNo(categoryDao.maxCategoryNo(id));
		}
		
		Paging pgVo = new Paging(5, 5, postDao.allPost(postVo.getCateNo()), pg);
		
		Map<String, Object> pgMap = new HashMap<String, Object>();
		pgMap.put("start", pgVo.getWriting_Start());
		pgMap.put("end", pgVo.getWriting_End());
		pgMap.put("cateNo", postVo.getCateNo());
		List<PostVo> postList = postDao.postList(pgMap);
		
		Map<String, Object> postMap = new HashMap<String, Object>();
		postMap.put("postList", postList);
		postMap.put("pg", pgVo);
		
		return postMap;
	}

}
