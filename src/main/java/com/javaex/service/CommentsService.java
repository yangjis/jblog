package com.javaex.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.javaex.dao.CommentsDao;
import com.javaex.vo.CommentsVo;
import com.javaex.vo.PostVo;

@Service
public class CommentsService {
	
	@Autowired
	private CommentsDao commentsDao;
	
	public CommentsVo commentsInsert(CommentsVo commentsVo) {
		commentsDao.commentsInsert(commentsVo);
		return commentsDao.getComments(commentsVo.getCmtNo());
	}
	
	public List<CommentsVo> commentsList(PostVo postVo){
		return commentsDao.commentsList(postVo);
	}
	
	public int commentsDel(int cmtNo) {
		return commentsDao.commentsDel(cmtNo);
	}

}
