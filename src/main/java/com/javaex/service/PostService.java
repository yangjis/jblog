package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CategoryDao;
import com.javaex.dao.PostDao;
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
			System.out.println("카테고리 파람값만 있을 경우");
			postVo.setPostNo(postDao.maxPostNo(postVo.getCateNo()));
			return postDao.selectPost(postVo); 
		}else{ 
			System.out.println("파람값없음."); 
			return postDao.getPost(categoryDao.maxCategory(id));
		}
	}
	
	public int postWrite(PostVo postVo, String id) {
		postVo.setId(id);
		return postDao.postWrite(postVo);
	}
	
	public List<PostVo> postList(String id, PostVo postVo) {
		if(postVo.getCateNo() != 0) return postDao.postList(postVo.getCateNo());
		else return postDao.postList(categoryDao.maxCategory(id));
	}

}
