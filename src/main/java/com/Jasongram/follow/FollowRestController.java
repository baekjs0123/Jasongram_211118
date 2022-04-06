package com.Jasongram.follow;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Jasongram.follow.bo.FollowBO;

@RequestMapping("/follow")
@RestController
public class FollowRestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private FollowBO followBO; 
	
	/**
	 * 팔로우
	 * @param userId
	 * @param session
	 * @return
	 */
	@PostMapping("/follow")
	public Map<String, Object> addFollow(
			@RequestParam("userId") int userId,
			HttpSession session) {
		Map<String, Object> result = new HashMap<>();
		
		Integer followerId = (Integer)session.getAttribute("userId");
		if (followerId == null) {
			logger.error("[user add follow] not found login session. userId:{}", userId);
			result.put("result", "error");
			result.put("error_message", "로그인을 다시해주세요.");
			return result;
		} else {
			// DB FollowBO
			followBO.follow(userId, followerId);
			result.put("result", "success");
		}
		
		return result;
	}
	
	/**
	 * 팔로우 취소
	 * @param userId
	 * @param session
	 * @return
	 */
	@DeleteMapping("/follow_delete")
	public Map<String, Object> deleteFollow(
			@RequestParam("userId") int userId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		Integer followerId = (Integer)session.getAttribute("userId");
		if (followerId == null) {
			logger.error("[user add follow] not found login session. userId:{}", userId);
			result.put("result", "error");
			result.put("error_message", "로그인을 다시해주세요.");
			return result;
		} else {
			// DB FollowBO
			followBO.deleteFollow(userId, followerId);
			result.put("result", "success");
		}
		
		return result;
	}
}
