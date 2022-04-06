package com.Jasongram.follow.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.Jasongram.follow.model.Follow;

@Repository
public interface FollowDAO {

	public List<Follow> selectFollowList();
	
	public int selectFollowerCountByUserId(int userId);

	public int selectFollowCountByUserId(int userId);
	
	public boolean isFollowerCheck(
			@Param("userId") int userId,
			@Param("followerId") int followerId);
	
	public void insertFollowByUserIdAndFollowerId(
			@Param("userId") int userId,
			@Param("followerId") Integer followerId);
	
	public void insertFollowerByUserIdAndFollowerId(
			@Param("userId") int userId,
			@Param("followerId") Integer followerId);
	
	public void deleteFollowByUserIdAndFollowerId(
			@Param("userId") int userId,
			@Param("followerId") Integer followerId);
	
	public void deleteFollowerByUserIdAndFollowerId(
			@Param("userId") int userId,
			@Param("followerId") Integer followerId);
	
}
