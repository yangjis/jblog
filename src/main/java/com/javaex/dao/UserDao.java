package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.UsersVo;

@Repository
public class UserDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int idcheck(UsersVo vo) {
		return sqlSession.selectOne("users.idcheck", vo); 
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
	
	public List<UsersVo> titleSearch(String keyword){
		return sqlSession.selectList("users.titleSearch", keyword);
	}
	
	public List<UsersVo> nameSearch(String keyword){
		return sqlSession.selectList("users.nameSearch", keyword);
	}
}
