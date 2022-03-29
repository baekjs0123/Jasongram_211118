package com.Jasongram.timeline.bo;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Jasongram.comment.bo.CommentBO;
import com.Jasongram.comment.model.CommentView;
import com.Jasongram.like.bo.LikeBO;
import com.Jasongram.post.bo.PostBO;
import com.Jasongram.post.model.Post;
import com.Jasongram.timeline.model.CardView;
import com.Jasongram.user.bo.UserBO;
import com.Jasongram.user.model.User;

@Service
public class TimelineBO {
	
	@Autowired
	private PostBO postBO;
	
	@Autowired
	private CommentBO commentBO;
	
	@Autowired
	private UserBO userBO;
	
	@Autowired
	private LikeBO likeBO;
	
	// 타임라인 회면의 경우 비로그인일대도 보여져야 하므로 Integer userId
	public List<CardView> generateCardViewList(Integer userId) {
		List<CardView> cardViewList = new ArrayList<>();
		
		// 글 List 가져온다.
		List<Post> postList = postBO.getPostList();
		for (Post post : postList) {
			CardView card = new CardView();
			
			// 글 정보
			card.setPost(post);
				
			// 글쓴이 정보
			User user = userBO.getUserByUserId(post.getUserId());
			card.setUser(user);
				
			// 댓글들 정보
			List<CommentView> commentList = commentBO.generateCommentViewList(post.getId());
			card.setCommentList(commentList);
			
			// 좋아요
			card.setFiledLike(likeBO.existLike(post.getId(), userId));
			
			// 좋아요 수
			card.setCount(likeBO.getLikeCountByPostId(post.getId()));
			cardViewList.add(card);
		}
		
		return cardViewList;
	}
}
