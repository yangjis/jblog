package com.javaex.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.javaex.service.UserService;
import com.javaex.vo.UsersVo;

@Controller
@RequestMapping("/user")
public class UsersController {
	
	@Autowired
	private UserService userService;
	
	@RequestMapping("/loginForm")
	public String login() {
		System.out.println("로그인 폼");
		return "/user/loginForm";
	}
	
	@RequestMapping("/joinForm")
	public String joinForm() {
		System.out.println("회원가입 폼");
		return "/user/joinForm";
	}
	
	@RequestMapping("/join")
	public String join(@ModelAttribute UsersVo userVo) {
		System.out.println("가입완료 페이지");
		
		if(userService.join(userVo) == 1) return "/user/joinSuccess";
		else return "redirect:/user/joinform";
	}
	
	@RequestMapping("/login")
	public String login(@ModelAttribute UsersVo userVo, HttpSession session) {
		System.out.println("로그인 ");
		
		UsersVo authUser = userService.login(userVo);
		
		if(authUser != null) {
			System.out.println("로그인 성공");
			session.setAttribute("authUser", authUser);
			return "redirect:/" ;
		}else{
			System.out.println("로그인 실패");
			return "redirect:/user/loginForm?result=fail";
		}
	}
	
	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();
		return "redirect:/";
	}
}
