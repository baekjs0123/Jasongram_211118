package com.Jasongram.follow.bo;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Jasongram.follow.dao.FollowDAO;
import com.Jasongram.follow.model.Follow;

@Service
public class FollowBO {

	@Autowired
	private FollowDAO followDAO;
	
	public List<Follow> getFollowList() {
		return followDAO.selectFollowList();
	}
	
	public boolean isFollowerCheck(int userId, int followerId) {
		return followDAO.isFollowerCheck(userId, followerId);
	}
	
	public int getFollowerCountByUserId(int userId) {
		return followDAO.selectFollowerCountByUserId(userId);
	}
	
	public int getFollowCountByUserId(int userId) {
		return followDAO.selectFollowCountByUserId(userId);
	}
	
	public void follow(int userId, int followerId) {
		followDAO.insertFollowByUserIdAndFollowerId(userId, followerId);
		followDAO.insertFollowerByUserIdAndFollowerId(userId, followerId);
	}
	
	public void deleteFollow(int userId, int followerId) {
		followDAO.deleteFollowByUserIdAndFollowerId(userId, followerId);
		followDAO.deleteFollowerByUserIdAndFollowerId(userId, followerId);
	}
}
