package com.javaex.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.PostDao;
import com.javaex.vo.PostVo;

@Service
public class PostService {
	
	@Autowired
	private PostDao postDao;
	
	public PostVo getPost(int max) {
		return postDao.getPost(max);
	}
	
	public int postWrite(PostVo postVo, String id) {
		postVo.setId(id);
		return postDao.postWrite(postVo);
	}
	
	public List<PostVo> postList(int max) {
		return postDao.postList(max);
	}
}
