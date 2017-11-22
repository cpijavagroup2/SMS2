package com.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.dao.UserDao;
import com.entity.Users;
import com.service.UserService;

public class UserServiceImpl implements UserService{
	
	private UserDao userDao;
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}

	@Override
	public void addUser(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("username", request.getParameter("username"));
		params.put("password", request.getParameter("password"));
		params.put("firstname", request.getParameter("firstname"));
		params.put("lastname", request.getParameter("lastname"));
		params.put("middlename", request.getParameter("middlename"));
		params.put("email", request.getParameter("email"));
		params.put("activetag", request.getParameter("activetag"));
		params.put("accesslevel", request.getParameter("accesslevel"));
		
		this.getUserDao().addUser(params);
	}

	@Override
	public void updateUser(HttpServletRequest request, String user) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("username", request.getParameter("username"));
		params.put("firstname", request.getParameter("firstname"));
		params.put("lastname", request.getParameter("lastname"));
		params.put("middlename", request.getParameter("middlename"));
		params.put("email", request.getParameter("email"));
		params.put("activetag", request.getParameter("activetag"));
		params.put("accesslevel", request.getParameter("accesslevel"));
		params.put("updatedby", user);
		
		this.getUserDao().updateUser(params);
	}


	@Override
	public List<Users> getSMSUsers() throws SQLException {
		return this.getUserDao().getSMSUsers();
	}
	@Override
	public void changePassword(HttpServletRequest request, String user) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("username", user);
		params.put("newpassword", request.getParameter("newpassword"));
		params.put("updatedby", user);
		
		this.getUserDao().changePassword(params);
	}

	@Override
	public String searchUser(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("search", request.getParameter("search"));
				
		return this.getUserDao().searchUser(params);
	}

	@Override
	public List<Users> getSearchResults(String user) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("search", user);
		return this.getUserDao().getSearchResults(params);
	}

	
}
