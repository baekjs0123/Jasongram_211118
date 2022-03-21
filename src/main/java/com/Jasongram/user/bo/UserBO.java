package com.Jasongram.user.bo;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.Jasongram.user.dao.UserDAO;

@Service
public class UserBO {

	@Autowired
	private UserDAO userDAO;
	
	public boolean existUserByLoginId(String loginId) {
		return userDAO.existUserByLoginId(loginId);
	}
	
	public int addUser(String loginId, String password, String name, String email,
			String profileImagePath) {
		return userDAO.insertUser(loginId, password, name, email);
	}
}
