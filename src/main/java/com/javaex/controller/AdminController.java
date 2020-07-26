package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.javaex.service.BlogService;
import com.javaex.service.CategoryService;
import com.javaex.service.PostService;
import com.javaex.vo.BlogVo;
import com.javaex.vo.PostVo;
import com.javaex.vo.UsersVo;

@RequestMapping("/{id}/admin")
@Controller
public class AdminController {
	
	@Autowired
	BlogService blogService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	PostService postService;
	
	@RequestMapping("/basic")
	public String basic(Model model, @PathVariable String id, HttpSession session) {
		
		if(session == null || session.equals(null)) return "/error/403";
		else {
			UsersVo loginUser = (UsersVo) session.getAttribute("authUser");
			if(!loginUser.getId().equals(id)) {
				return "/error/403";
			}
		}
		System.out.println("블로그 관리자 기본 페이지");

		model.addAttribute("blogVo", blogService.blogInformation(id));
		return "/blog/admin/blog-admin-basic";
	}
	
	@RequestMapping("/blogModify")
	public String blogModify(@RequestParam("file") MultipartFile file,
							 @ModelAttribute BlogVo blogVo,
							 @PathVariable String id,
							 HttpSession session) {
		
		if(session == null || session.equals(null)) return "/error/403";
		else {
			UsersVo loginUser = (UsersVo) session.getAttribute("authUser");
			if(!loginUser.getId().equals(id)) {
				return "/error/403";
			}
		}
		System.out.println("관리자 블로그 기본설정변경 페이지");
		
		blogService.blogModify(blogVo, file, id);
		
		return "redirect:/"+id+"?pg=1";
	}
	
	@RequestMapping("/category")
	public String category(Model model, @PathVariable String id, HttpSession session) {
		
		if(session == null || session.equals(null))return "/error/403";
		else {
			UsersVo loginUser = (UsersVo) session.getAttribute("authUser");
			if(!loginUser.getId().equals(id)) {
				return "/error/403";
			}
		}
		
		
		model.addAttribute("blogVo", blogService.blogInformation(id));
		model.addAttribute("cataList", categoryService.cateList(id));
		return "/blog/admin/blog-admin-cate";
	}
	
	@RequestMapping("/writeForm")
	public String writeForm(Model model, @PathVariable String id, HttpSession session) {
		
		if(session == null || session.equals(null)) return "/error/403";
		else {
			UsersVo loginUser = (UsersVo) session.getAttribute("authUser");
			if(!loginUser.getId().equals(id)) {
				return "/error/403";
			}
		}
		
		model.addAttribute("cateVo", categoryService.cateList(id));
		model.addAttribute("blogVo", blogService.blogInformation(id));
		return "/blog/admin/blog-admin-write";
	}
	
	@RequestMapping("/write")
	public String write(@ModelAttribute PostVo postVo, @PathVariable String id, HttpSession session) {
		
		if(session == null || session.equals(null)) return "/error/403";
		else {
			UsersVo loginUser = (UsersVo) session.getAttribute("authUser");
			if(!loginUser.getId().equals(id)) {
				return "/error/403";
			}
		}
		
		System.out.println("포스트 등록");
		postService.postWrite(postVo, id);
		
		return "redirect:/"+id+"?pg=1"; 
	}
	
}
