package com.javaex.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.PostVo;

@Repository
public class PostDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public PostVo getPost(int max){
		return sqlSession.selectOne("post.getPost", max);
	}
	
	public int postWrite(PostVo postVo) {
		return sqlSession.insert("post.postWrite", postVo);
	}
	
	public List<PostVo> postList(int max){
		return sqlSession.selectList("post.postList", max);
	}
}
