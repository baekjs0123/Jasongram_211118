package com.Jasongram.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@RequestMapping("/sign_in_view")
	public String userLoginView(Model model) {
		model.addAttribute("viewName", "user/sign_in");
		
		return "template/layout";
	}
	
	@RequestMapping("/sign_up_view")
	public String userSignUpView(Model model) {
		model.addAttribute("viewName", "user/sign_up");
		
		return "template/layout";
	}
	
	@RequestMapping("/sign_out")
	public String signOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		// 로그아웃 할 때 세션에 있는 모든 것들을 비운다.
		session.removeAttribute("userId");
		session.removeAttribute("userName");
		session.removeAttribute("userLoginId");
		
		return "redirect:/timeline/timeline_view";
	}
}
