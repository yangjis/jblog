package com.javaex.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.PostService;
import com.javaex.service.UserService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.CategoryVo;
import com.javaex.vo.PostVo;

@RequestMapping("/{id}")
@Controller
public class BlogController {
	
	@Autowired
	private BlogService blogService;
	
	@Autowired
	private CategoryService categoryService;
	
	@Autowired
	private PostService postService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/")
	public String BlogMain(@PathVariable String id, Model model) {
		System.out.println("블로그 메인");
		
		boolean idcheck = userService.idcheck(id);
		
		if(idcheck == true) {
			return "/error/403";
		}
		
		BlogVo blogVo = blogService.blogInformation(id);
		
		List<CategoryVo> cateList = categoryService.list(id); 
		
		PostVo getPost = postService.getPost(categoryService.maxCategory(id));
		System.out.println(getPost.toString());
		
		List<PostVo> postList = postService.postList(categoryService.maxCategory(id));
		
		model.addAttribute("blogVo", blogVo);
		model.addAttribute("cateList", cateList);
		model.addAttribute("postVo", getPost);
		model.addAttribute("userName", userService.getUserName(id));
		model.addAttribute("postList", postList);
		return "/blog/blog-main";
	}
}
