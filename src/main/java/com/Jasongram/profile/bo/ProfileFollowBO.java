package com.Jasongram.profile.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Jasongram.follow.bo.FollowBO;
import com.Jasongram.profile.model.ProfileFollow;
import com.Jasongram.user.bo.UserBO;

@Service
public class ProfileFollowBO {

	@Autowired
	private FollowBO followBO;
	
	@Autowired
	private UserBO userBO;
	
	public List<ProfileFollow> generateFollowList(int userId) {
		List<ProfileFollow> followAndFollowerList = new ArrayList<>();
		
		ProfileFollow profileFollow = new ProfileFollow();
		
			// 팔로워 수
			profileFollow.setFollowerCount(followBO.getFollowerCountByUserId(userId));
			
			// 팔로우 수
			profileFollow.setFollowCount(followBO.getFollowCountByUserId(userId));
			
			// 팔로워 유저
			profileFollow.setFollower(userBO.getUserByUserId(userId));
			
			// 팔로잉 유저
			profileFollow.setFollowing(userBO.getUserByUserId(userId));
			
			followAndFollowerList.add(profileFollow);
			
		return followAndFollowerList;
	}
}
