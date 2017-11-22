package com.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.dao.IssuanceDao;
import com.entity.IssuanceFields;
import com.ibatis.sqlmap.client.SqlMapClient;

public class IssuanceDaoImpl implements IssuanceDao{
	
	private SqlMapClient sqlMapClient;

	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@Override
	public void addIssue(Map<String, Object> params) throws SQLException {
		// TODO Auto-generated method stub
		
		try {
			//System.out.println("1");
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			System.out.println("1"+params);
			this.sqlMapClient.update("addRecIssue", params);
			
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
			this.sqlMapClient.getCurrentConnection().rollback();
		}finally{
			this.getSqlMapClient().endTransaction();
		}
		
	}

	@Override
	public void updateIssue(Map<String, Object> params) throws SQLException {
		try {
			//System.out.println("1");
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			System.out.println("update"+params);
			this.sqlMapClient.update("updateRecIssue", params);
			
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		} catch (SQLException e) {
			// TODO: handle exception
			e.printStackTrace();
			this.sqlMapClient.getCurrentConnection().rollback();
		}finally{
			this.getSqlMapClient().endTransaction();
		}
		
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IssuanceFields> getSupplyIdFields() throws SQLException {
		// TODO Auto-generated method stub
		return (List<IssuanceFields>)this.getSqlMapClient().queryForList("getSupplyIdFields");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IssuanceFields> getDeptIdFields() throws SQLException {
		// TODO Auto-generated method stub
		return (List<IssuanceFields>)this.getSqlMapClient().queryForList("getDeptIdFields");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IssuanceFields> getAllFields() throws SQLException {
		// TODO Auto-generated method stub
		return (List<IssuanceFields>)this.getSqlMapClient().queryForList("getAllFields");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<IssuanceFields> searchIssue(Map<String, Object> params) throws SQLException {
		return(List<IssuanceFields>) this.getSqlMapClient().queryForList("searchIssue", params);
	}




/*	@SuppressWarnings("unchecked")
	@Override
	public List<IssuanceFields> getAllUsers() throws SQLException {
		// TODO Auto-generated method stub
		return (List<IssuanceFields>)this.getSqlMapClient().queryForList("getAllUsers");//Fields
	}*/
}
