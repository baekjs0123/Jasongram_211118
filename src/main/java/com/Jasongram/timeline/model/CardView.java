package com.Jasongram.timeline.model;

import java.util.List;

import com.Jasongram.comment.model.CommentView;
import com.Jasongram.post.model.Post;
import com.Jasongram.user.model.User;

// 하나의 카드를 의미
public class CardView {
	// 글 하나
	private Post post;
	// 댓글들
	private List<CommentView> commentList;
	// 좋아요 수
	private int count;
	// 로그인 된 사용자가 좋아요 눌렀는지 여부
	private boolean filledLike;
	
	public void setFilledLike(boolean filledLike) {
		this.filledLike = filledLike;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public boolean isFilledLike() {
		return filledLike;
	}
	public void setFiledLike(boolean filledLike) {
		this.filledLike = filledLike;
	}
	// 글쓴이 정보 => 글에 대한 
	private User user;
	
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Post getPost() {
		return post;
	}
	public void setPost(Post post) {
		this.post = post;
	}
	public List<CommentView> getCommentList() {
		return commentList;
	}
	public void setCommentList(List<CommentView> commentList) {
		this.commentList = commentList;
	}
}
