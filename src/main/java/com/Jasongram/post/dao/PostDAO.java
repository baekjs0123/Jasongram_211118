package com.Jasongram.post.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.Jasongram.post.model.Post;

@Repository
public interface PostDAO {

	public List<Post> selectPostList();
}
