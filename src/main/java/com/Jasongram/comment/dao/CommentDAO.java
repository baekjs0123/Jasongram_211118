package com.Jasongram.comment.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.Jasongram.comment.model.Comment;

@Repository
public interface CommentDAO {
	public List<Comment> selectCommentListByPostId(int postId);
	
	public int createComment(
			@Param("postId") int postId,
			@Param("userId") int userId,
			@Param("content") String content);
}
