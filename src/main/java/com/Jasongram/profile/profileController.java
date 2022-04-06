package com.Jasongram.profile;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Jasongram.follow.bo.FollowBO;
import com.Jasongram.post.bo.PostBO;
import com.Jasongram.timeline.bo.TimelineBO;
import com.Jasongram.timeline.model.CardView;
import com.Jasongram.user.bo.UserBO;
import com.Jasongram.user.model.User;

@RequestMapping("/profile")
@Controller
public class ProfileController {

	@Autowired
	private TimelineBO timelineBO;
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private FollowBO followBO;
	
	@RequestMapping("/profile_view")
	public String profileView(Model model,
			int userId,
			HttpSession session) {
		
		Integer followerId = (Integer)session.getAttribute("userId");
		
		int postCount = postBO.getPostCountByUserId(userId);
		int followerCount = followBO.getFollowerCountByUserId(userId);
		int followCount = followBO.getFollowCountByUserId(userId);
		if (userId != followerId && followerId != null) {
			boolean followCheck = followBO.isFollowerCheck(userId, followerId);
			if (followCheck) {
				model.addAttribute("followState", true);
			} else {
				model.addAttribute("followState", false);
			}
		}
		
		
		User user = userBO.getUserByUserId(userId);
		List<CardView> cardViewList = timelineBO.generateCardViewList(userId);
		
		model.addAttribute("followCount", followCount);
		model.addAttribute("followerCount", followerCount);
		
		model.addAttribute("user", user);
		model.addAttribute("postCount", postCount);
		model.addAttribute("cardViewList", cardViewList);
		model.addAttribute("viewName", "profile/profile");
		return "template/layout";
	}
}
