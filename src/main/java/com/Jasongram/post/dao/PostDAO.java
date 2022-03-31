package com.Jasongram.post.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.Jasongram.post.model.Post;

@Repository
public interface PostDAO {

	public List<Post> selectPostList();
	
	public Post selectPostByPostId(int postId);
	
	public int selectPostCountByUserId(int userId);
	
	public int insertPost(
			@Param("userId") int userId,
			@Param("content") String content,
			@Param("imagePath") String imagePath);
	
	public int deletePost(
			@Param("postId") int postId,
			@Param("userId") int userId);
}
