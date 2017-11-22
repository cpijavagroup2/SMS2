package com.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.entity.Users;

public interface LoginUserDao {
	
	
	public String validateLogin(Map<String, Object> params) throws SQLException;
	public void updateUser(Map<String, Object> params) throws SQLException;
	public List<Users> getUser(Map<String, Object> params) throws SQLException;
	public void addAttemp(Map<String, Object> params) throws SQLException;
	public void lockAccount(Map<String, Object> params) throws SQLException;
	public void resetAttemp(Map<String, Object> params) throws SQLException;

}
