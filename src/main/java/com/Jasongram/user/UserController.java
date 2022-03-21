package com.Jasongram.user;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@RequestMapping("/user")
@Controller
public class UserController {

	@RequestMapping("/sign_in_view")
	public String userLoginView() {
		return "user/sign_in_view";
	}
	
	@RequestMapping("/sign_up_view")
	public String userSignUpView() {
		return "user/sign_up_view";
	}
}
