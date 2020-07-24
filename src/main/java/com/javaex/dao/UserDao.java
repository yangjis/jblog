package com.javaex.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.UsersVo;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public UsersVo idcheck(String id) {
		return sqlSession.selectOne("users.idcheck", id); 
	}
	
	public int userInsert(UsersVo userVo) {
		return sqlSession.insert("users.userInsert", userVo);
	}
	
	public UsersVo login(UsersVo userVo) {
		
		return sqlSession.selectOne("users.login", userVo);
	}
	
	public String getUserName(String id) {
		return sqlSession.selectOne("users.getUserName", id);
	}
	
}
