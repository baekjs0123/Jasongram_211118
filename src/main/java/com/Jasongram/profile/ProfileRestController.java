package com.Jasongram.profile;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.Jasongram.user.bo.UserBO;

@RequestMapping("/profile")
@RestController
public class ProfileRestController {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	UserBO userBO;
	
	/**
	 * 프로필 이미지 업로드
	 * @param model
	 * @param file
	 * @param session
	 * @return
	 */
	@PutMapping("/update")
	public Map<String, Object> updateProfileImage(
			Model model,
			@RequestParam("file") MultipartFile file,
			HttpSession session) {
		Integer userId = (Integer)session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		// DB userBO
		int row = userBO.updateUserProfileImagePathByUserId(userId, file);
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "프로필 이미지 업로드에 실패했습니다. 다시 시도해주세요.");
		}
		
		return result;
	}
	
	@PutMapping("/delete_profile_image")
	public Map<String, Object> deleteProfileImage(
			@RequestParam("userId") int userId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		Integer sessionUserId = (Integer)session.getAttribute("userId");
		if (sessionUserId == null) {
			logger.error("[user profileImage delete] not found login session. userId:{}", userId);
			result.put("result", "error");
			result.put("error_message", "로그인을 다시해주세요.");
			return result;
		}
		
		// DB userBO
		int row = userBO.deleteUserProfileImagePathByUserId(userId);
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "프로필 이미지 삭제에 실패했습니다. 다시 시도해주세요.");
		}
		
		return result;
	}
}
