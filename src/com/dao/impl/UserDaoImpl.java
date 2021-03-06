package com.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.dao.UserDao;
import com.entity.Users;
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
	public void addUser(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("addRec", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}finally{
			this.sqlMapClient.endTransaction();
		}
		
	}

	@Override
	public void updateUser(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("updateRec", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}finally{
			this.sqlMapClient.endTransaction();
		}
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Users> getSMSUsers() throws SQLException {
		return (List<Users>) this.getSqlMapClient().queryForList("getSMSUsers");
	}
	
	@Override
	public void changePassword(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("changePass", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}finally{
			this.sqlMapClient.endTransaction();
		}
		
	}

	@Override
	public String searchUser(Map<String, Object> params) throws SQLException {
		return (String) this.getSqlMapClient().queryForObject("searchUser", params);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Users> getSearchResults(Map<String, Object> params) throws SQLException {
		return (List<Users>) this.getSqlMapClient().queryForList("getSearchResults", params);
	}


}
