package com.Jasongram.user;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Jasongram.user.bo.UserBO;

@RequestMapping("/user")
@RestController
public class UserRestContorller {

	@Autowired
	private UserBO userBO;
	
	/**
	 * 중복확인
	 * @param loginId
	 * @return
	 */
	@RequestMapping("/is_duplicated_id")
	public Map<String, Boolean> isDuplicatedId(
			@RequestParam("loginId") String loginId) {
		
		Map<String, Boolean> result = new HashMap<>();
		
		result.put("result", userBO.existUserByLoginId(loginId));
		return result;
	}
	
	@PostMapping("/sign_up")
	public Map<String, Object> signUp(
			@RequestParam("loginId") String loginId,
			@RequestParam("password") String password,
			@RequestParam("name") String name,
			@RequestParam("email") String email) {
		
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		int row = userBO.addUser(loginId, password, name, email, email);
		
		if (row < 1) {
			result.put("result", "error");
		}
		
		return result;
		
	}
}
