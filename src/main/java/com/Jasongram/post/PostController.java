package com.Jasongram.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.Jasongram.post.bo.PostBO;
import com.Jasongram.post.model.Post;

@RequestMapping("/post")
@Controller
public class PostController {

	@Autowired
	private PostBO postBO;
	
	@RequestMapping("/post_list_view")
	public String postListView(Model model) {
		List<Post> postList = postBO.getPostList();
		model.addAttribute("postList", postList);
		return "template/layout";
	}
}
