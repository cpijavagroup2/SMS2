package com.dao.impl;

import java.sql.SQLException;
import java.util.Map;

import com.dao.UserDao;
import com.ibatis.sqlmap.client.SqlMapClient;

public class UserDaoImpl implements UserDao{
	
	private SqlMapClient sqlMapClient;
	
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	@Override
	public String validateLogin(Map<String, Object> params) throws SQLException {
		return (String) this.getSqlMapClient().queryForObject("validateLogin", params);
	}
	
	@Override
	public void updateUser(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			System.out.println(">> "+params);
			this.sqlMapClient.update("updateLogin",params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}finally{
			this.getSqlMapClient().endTransaction();
		}
	}

}
