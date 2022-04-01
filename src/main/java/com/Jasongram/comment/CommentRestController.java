package com.Jasongram.comment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.Jasongram.comment.bo.CommentBO;
@RequestMapping("/comment")
@RestController
public class CommentRestController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private CommentBO commentBO;
	
	/**
	 * 댓글 쓰기
	 * @param postId
	 * @param content
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> createComment(
			@RequestParam("postId") int postId,
			@RequestParam("content") String content,
			HttpServletRequest request) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		HttpSession session = request.getSession();
		Integer userId = (Integer) session.getAttribute("userId");
		if (userId == null) {
			result.put("result", "error");
			result.put("error_message", "로그인을 다시 해주세요.");
			return result;
		}
		
		commentBO.createComment(userId, postId, content);
		
		return result;
	}
	
	/**
	 * 댓글 삭제
	 * @param commentId
	 * @param session
	 * @return
	 */
	@DeleteMapping("/delete")
	public Map<String, Object> deleteComment(
			@RequestParam("commentId") int commentId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			logger.error("[comment delete] not found login session. commentId:{}", commentId);
			result.put("result", "error");
			result.put("error_message", "로그인을 다시해주세요.");
			return result;
		}
		// DB
		int row = commentBO.deleteComment(commentId, userId);
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "댓글 삭제에 실패했습니다. 다시 시도해주세요.");
		}
		return result;
	}
}
