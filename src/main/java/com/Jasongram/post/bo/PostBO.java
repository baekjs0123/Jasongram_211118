package com.Jasongram.post.bo;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.Jasongram.common.FileManagerService;
import com.Jasongram.post.dao.PostDAO;
import com.Jasongram.post.model.Post;

@Service
public class PostBO {

	@Autowired
	private PostDAO postDAO;
	
	@Autowired
	private FileManagerService fileManagerService;
	
	public List<Post> getPostList() {
		return postDAO.selectPostList();
	}
	
	public int getPostCountByUserId(int userId) {
		return postDAO.selectPostCountByUserId(userId);
	}
	
	public int addPost(int userId, String content, MultipartFile file) {
		
		String imagePath = null;
		if (file != null) {
			try {
				imagePath = fileManagerService.saveFile(userId, file);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
		
		return postDAO.insertPost(userId, content, imagePath);
		
	}
}
