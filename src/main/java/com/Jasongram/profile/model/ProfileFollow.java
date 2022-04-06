package com.Jasongram.profile.model;

import com.Jasongram.follow.model.Follow;
import com.Jasongram.user.model.User;

public class ProfileFollow {

	// 팔로우 하나
	private Follow follow;
	
	// 팔로워 유저
	private User follower;

	// 팔로잉 유저
	private User following;

	// 팔로워 수
	private int followerCount;

	// 팔로우 수
	private int followCount;

	public Follow getFollow() {
		return follow;
	}

	public void setFollow(Follow follow) {
		this.follow = follow;
	}
	
	public User getFollower() {
		return follower;
	}

	public void setFollower(User follower) {
		this.follower = follower;
	}

	public User getFollowing() {
		return following;
	}

	public void setFollowing(User following) {
		this.following = following;
	}

	public int getFollowerCount() {
		return followerCount;
	}

	public void setFollowerCount(int followerCount) {
		this.followerCount = followerCount;
	}

	public int getFollowCount() {
		return followCount;
	}

	public void setFollowCount(int followCount) {
		this.followCount = followCount;
	}
}
