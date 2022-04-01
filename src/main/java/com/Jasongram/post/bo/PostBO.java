package com.Jasongram.post.bo;

import java.io.IOException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.Jasongram.comment.bo.CommentBO;
import com.Jasongram.common.FileManagerService;
import com.Jasongram.like.bo.LikeBO;
import com.Jasongram.post.dao.PostDAO;
import com.Jasongram.post.model.Post;

@Service
public class PostBO {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private LikeBO likeBO;
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public Post getPostByPostId(int postId) {
		return postDAO.selectPostByPostId(postId);
	}
	
	public int getPostCountByUserId(int userId) {
		return postDAO.selectPostCountByUserId(userId);
	}
	
	public int addPost(int userId, String content, MultipartFile file) {
		
		String imagePath = null;
		if (file != null) {
			try {
				imagePath = fileManagerService.saveFile(userId, file);
			} catch (IOException e) {
				logger.error("[postBO addPost] 이미지 업로드 실패 userId:{}", userId);
			}
			
		}
		
		return postDAO.insertPost(userId, content, imagePath);
		
	}
	
	public int deletePost(int postId, int userId) {
		// select post 
		Post post = getPostByPostId(postId);
		
		// post null 검사 => null이면 logger, 0 return
		if (post == null) {
			logger.error("[postBO deletePost] post is Null");
			return 0;
		}
		
		// 이미지 삭제 
		try {
			fileManagerService.deleteFile(post.getImagePath());
		} catch (IOException e) {
			logger.error("[delete post] 이미지 삭제 실패. postId:{}", postId);
			return 0;
		}
		
		// 글 삭제
		postDAO.deletePost(postId, userId);
		
		// 댓글들 삭제
		commentBO.deleteCommentListByPostId(postId);
		
		// 좋아요들 삭제 byPostId
		likeBO.deleteLikeByPostId(postId);
		
		return 1;
	}
}
