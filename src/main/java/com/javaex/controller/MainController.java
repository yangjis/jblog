package com.javaex.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class MainController {
	
	@RequestMapping("")
	public String index() {
		System.out.println("메인");
		
		return "/main/index";
	}
	
	@RequestMapping("/test")
	public String test() {
		System.out.println("test");
		return "/test";
	}
}
