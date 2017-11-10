package com.dao;

import java.sql.SQLException;
import java.util.Map;

public interface UserDao {
	

	public String validateLogin(Map<String, Object> params) throws SQLException;
	public void updateUser(Map<String, Object> params) throws SQLException;

}
