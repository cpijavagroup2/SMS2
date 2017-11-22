package com.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.entity.Users;

public interface UserService {
	
	public String searchUser(HttpServletRequest request) throws SQLException;
	void addUser(HttpServletRequest request) throws SQLException;
	void updateUser(HttpServletRequest request, String user) throws SQLException;
	void changePassword(HttpServletRequest request, String user) throws SQLException;
	List<Users> getSMSUsers() throws SQLException;
	List<Users> getSearchResults(String user) throws SQLException;


}
