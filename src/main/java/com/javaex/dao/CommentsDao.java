package com.javaex.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.javaex.vo.CommentsVo;
import com.javaex.vo.PostVo;

@Repository
public class CommentsDao {
	
	@Autowired
	private SqlSession sqlSession;
	
	public int commentsInsert(CommentsVo commentsVo) {
		return sqlSession.insert("comments.commentsInsert", commentsVo);
	}
	
	public List<CommentsVo> commentsList(PostVo postVo){
		return sqlSession.selectList("comments.commentsList", postVo);
	}
	
	public CommentsVo getComments(int cmtNo) {
		return sqlSession.selectOne("comments.getComments", cmtNo);
	}
	
	public int commentsDel(int cmtNo) {
		return sqlSession.delete("comments.commentsDel", cmtNo);
	}

}
