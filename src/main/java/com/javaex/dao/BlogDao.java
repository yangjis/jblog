package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;

@Repository
public class BlogDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public int blogInsert(BlogVo blogVo) {
		return sqlSession.insert("blog.blogInsert", blogVo);
	}
	
	public BlogVo blogInformation(String id) {
		return sqlSession.selectOne("blog.blogInformation", id);
	}
	
	public int blogModify(BlogVo blogVo) {
		return sqlSession.update("blog.blogModify", blogVo);
	}
}
