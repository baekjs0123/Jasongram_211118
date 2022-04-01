package com.Jasongram.user.dao;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.Jasongram.user.model.User;

@Repository
public interface UserDAO {

	public boolean existUserByLoginId(String loginId);
	
	public User selectUserByLoginIdAndPassword(
			@Param ("loginId") String loginId,
			@Param ("password") String password);
	
	public User selectUserByUserId(int userId);
	
	public int insertUser(
			@Param("loginId") String loginId,
			@Param("password") String password,
			@Param("name") String name,
			@Param("email") String email);
	
	public int updateUserProfileImagePathByUserId(
			@Param("userId") int userId,
			@Param("profileImagePath") String profileImagePath);
	
	public int deleteUserProfileImagePathByUserId(int userId);
}
