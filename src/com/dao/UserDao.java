package com.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.entity.Users;

public interface UserDao {
	
	public String searchUser(Map<String, Object> params) throws SQLException;
	void addUser(Map<String, Object> params) throws SQLException;
	void updateUser(Map<String, Object> params) throws SQLException;
	void changePassword(Map<String, Object> params) throws SQLException;
	List<Users> getSMSUsers() throws SQLException;
	List<Users> getSearchResults(Map<String, Object> params) throws SQLException;

}
