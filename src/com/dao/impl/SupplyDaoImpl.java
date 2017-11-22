package com.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.dao.SupplyDao;
import com.entity.Supply;
import com.ibatis.sqlmap.client.SqlMapClient;

public class SupplyDaoImpl implements SupplyDao {

	private SqlMapClient sqlMapClient;
	
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}

	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Supply> getAllSupply() throws SQLException {
		// TODO Auto-generated method stub
		return (List<Supply>) this.getSqlMapClient().queryForList("getAllUsers");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Supply> getAllTypeName() throws SQLException {
		// TODO Auto-generated method stub
		return (List<Supply>) this.getSqlMapClient().queryForList("getAllTypeName");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Supply> populateFields(Map<String, Object> params) throws SQLException {
		// TODO Auto-generated method stub
		return (List<Supply>) this.getSqlMapClient().queryForList("populateFields", params);
	}

	
	@Override
	public void updateSupply(Map<String, Object> params) throws SQLException {
		// TODO Auto-generated method stub
		try {
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("updateRecSupply", params);
			System.out.println(params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		} catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			System.out.println(e);
			throw e;
		}finally {
			this.getSqlMapClient().endTransaction();
		}
	}

	@Override
	public void addSupply(Map<String, Object> params) throws SQLException {
		// TODO Auto-generated method stub
		try {
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			System.out.println(params);
			this.sqlMapClient.update("addRecSupply", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			this.sqlMapClient.getCurrentConnection().rollback();
			throw e;
		}finally{
			this.getSqlMapClient().endTransaction();
		}
		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Supply> searchSupply(Map<String, Object> params) throws SQLException {
		// TODO Auto-generated method stub
		return (List<Supply>) this.getSqlMapClient().queryForList("searchSupply", params);
	}
}
