package com.Jasongram.profile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
	@RequestMapping("/profile_view")
	public String profileView(Model model,
			int userId) {
		int postCount = postBO.getPostCountByUserId(userId);
		
		User user = userBO.getUserByUserId(userId);
		List<CardView> cardViewList = timelineBO.generateCardViewList(userId);
		
		model.addAttribute("user", user);
		model.addAttribute("postCount", postCount);
		model.addAttribute("cardViewList", cardViewList);
		model.addAttribute("viewName", "profile/profile");
		return "template/layout";
	}
}
