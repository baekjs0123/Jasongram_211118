package com.Jasongram.post;

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
import org.springframework.web.multipart.MultipartFile;

import com.Jasongram.post.bo.PostBO;

@RequestMapping("/post")
@RestController
public class PostRestController {

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostBO postBO;
	
	/**
	 * 글쓰기
	 * @param content
	 * @param file
	 * @param request
	 * @return
	 */
	@PostMapping("/create")
	public Map<String, Object> create(
			@RequestParam("content") String content,
			@RequestParam("file") MultipartFile file,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		Integer userId = (Integer)session.getAttribute("userId");
		
		// BO create
		int row = postBO.addPost(userId, content, file);
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "게시물 업로드에 실패했습니다. 다시 시도해주세요.");
		}
		
		return result;
	}
	 /**
	  * 글 삭제
	  * @param postId
	  * @param session
	  * @return
	  */
	@DeleteMapping("/delete")
	public Map<String, Object> delete(
			@RequestParam("postId") int postId,
			HttpSession session) {
		
		Map<String, Object> result = new HashMap<>();
		result.put("result", "success");
		
		Integer userId = (Integer)session.getAttribute("userId");
		if (userId == null) {
			logger.error("[post delete] not found login session. postId:{}", postId);
			result.put("result", "error");
			result.put("error_message", "로그인을 다시해주세요.");
			return result;
		}
		
		// DB postBO
		int row = postBO.deletePost(postId, userId);
		if (row < 1) {
			result.put("result", "error");
			result.put("error_message", "게시물 삭제에 실패했습니다. 다시 시도해주세요.");
		}
		
		return result;
	}
}
