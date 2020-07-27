package com.javaex.api.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.javaex.service.CategoryService;
import com.javaex.service.CommentsService;
import com.javaex.service.UserService;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.CommentsVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UsersVo;


@RequestMapping("/api")
@Controller
public class ApiController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private CommentsService commentsService;
	
	@ResponseBody
	@RequestMapping("/idcheck")
	public boolean idcheck(@RequestBody UsersVo vo) {
		System.out.println("아작스/아이디 체크");
		System.out.println(vo.toString());
		return userService.idcheck(vo);
	}
	
	@ResponseBody
	@RequestMapping("/cateInsert")
	public CategoryVo cateInsert(@RequestBody CategoryVo categoryVo) {
		System.out.println("카테고리 추가 api컨트롤러");
		return categoryService.cateInsert(categoryVo);
	}
	
	@ResponseBody
	@RequestMapping("/cateDelete")
	public int cateDelete(@RequestBody CategoryVo categoryVo) {
		System.out.println("카테고리 삭제 api컨트롤러");
		return categoryService.cateDelete(categoryVo);
	}
	
	@ResponseBody
	@RequestMapping("/commentsInsert")
	public CommentsVo commentsInsert(@RequestBody CommentsVo commentsVo) {
		System.out.println("댓글등록 api컨트롤러");
		return commentsService.commentsInsert(commentsVo);
	}
	
	@ResponseBody
	@RequestMapping("/commentsList")
	public List<CommentsVo> commentsList(@RequestBody PostVo postVo){
		System.out.println("블로그 메인 댓글리스트 api컨트롤러 ");
		return commentsService.commentsList(postVo);
	}
	
	@ResponseBody
	@RequestMapping("/commentsDel")
	public int commentsDel(@RequestBody int cmtNo) {
		return commentsService.commentsDel(cmtNo);
	}
	
	@ResponseBody
	@RequestMapping("/search")
	public List<UsersVo> search(@RequestParam("keyword") String keyword,
								@RequestParam("radio") String radio){
		System.out.println("검색기능 api");
		System.out.println(keyword);
		System.out.println(radio);
		return userService.search(keyword, radio);
	}
}
