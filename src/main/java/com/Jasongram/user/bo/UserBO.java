package com.Jasongram.user.bo;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.Jasongram.common.FileManagerService;
import com.Jasongram.user.dao.UserDAO;
import com.Jasongram.user.model.User;

@Service
public class UserBO {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Autowired
	private UserDAO userDAO;
	
	@Autowired
	FileManagerService fileManagerService;
	
	public boolean existUserByLoginId(String loginId) {
		return userDAO.existUserByLoginId(loginId);
	}
	
	public User getUserByLoginIdAndPassword(String loginId, String password) {
		return userDAO.selectUserByLoginIdAndPassword(loginId, password);
	}
	
	public User getUserByUserId(int userId) {
		return userDAO.selectUserByUserId(userId);
	}
	
	public int addUser(String loginId, String password, String name, String email) {
		return userDAO.insertUser(loginId, password, name, email);
	}
	
	public int updateUserProfileImagePathByUserId(int userId, MultipartFile file) {
		String profileImagePath = null;
		
		try {
			profileImagePath = fileManagerService.saveFile(userId, file);
		} catch (IOException e) {
			logger.error("[userBO updateUser] 프로필 이미지 업로드 실패 userId:{}", userId);
		}
		
		return userDAO.updateUserProfileImagePathByUserId(userId, profileImagePath);
	}
	
	public int deleteUserProfileImagePathByUserId(int userId) {
		// select user
		User user = getUserByUserId(userId);
		String profileImagePath = user.getProfileImagePath();
		
		// user profileImagePath null 검사 => null이면 logger, 0 return
		if (profileImagePath == null) {
			logger.error("[userBO updateUserProfileImagePath] profileImagePath is Null");
			return 0;
		}
		
		// 이미지 삭제
		try {
			fileManagerService.deleteFile(user.getProfileImagePath());
		} catch (IOException e) {
			logger.error("[delete user] 이미지 삭제 실패. userId:{}", userId);
			return 0;
		}
		
		return userDAO.deleteUserProfileImagePathByUserId(userId);
	}
	
	
}
