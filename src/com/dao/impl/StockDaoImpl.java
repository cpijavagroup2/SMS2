package com.dao.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.dao.StockDao;
import com.entity.SuppliesStocks;
import com.ibatis.sqlmap.client.SqlMapClient;

public class StockDaoImpl implements StockDao{
	private SqlMapClient sqlMapClient;
	
	public SqlMapClient getSqlMapClient() {
		return sqlMapClient;
	}
	public void setSqlMapClient(SqlMapClient sqlMapClient) {
		this.sqlMapClient = sqlMapClient;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<SuppliesStocks> getAllStocks() throws SQLException {
		return(List<SuppliesStocks>) this.getSqlMapClient().queryForList("getAllStocks");
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<SuppliesStocks> getItemStocks() throws SQLException {
		return(List<SuppliesStocks>) this.getSqlMapClient().queryForList("getAllItems");
	}
	
	@Override
	public void addStock(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("addStock", params);
			System.out.println();
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			e.printStackTrace();
			this.sqlMapClient.getCurrentConnection().rollback();
		}finally{
			this.getSqlMapClient().endTransaction();
		}
	}
	@SuppressWarnings("unchecked")
	@Override
	
	public List<SuppliesStocks> getStock(Map<String, Object> params) throws SQLException {
		return(List<SuppliesStocks>) this.getSqlMapClient().queryForList("getStock", params);
	}
	
	@Override
	public void updateStock(Map<String, Object> params) throws SQLException {
		try{
			this.sqlMapClient.startTransaction();
			this.sqlMapClient.getCurrentConnection().setAutoCommit(false);
			this.sqlMapClient.startBatch();
			this.sqlMapClient.update("updateStock", params);
			this.sqlMapClient.executeBatch();
			this.sqlMapClient.getCurrentConnection().commit();
		}catch(SQLException e){
			e.printStackTrace();
			this.sqlMapClient.getCurrentConnection().rollback();
		}finally{
			this.getSqlMapClient().endTransaction();
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<SuppliesStocks> searchStock(Map<String, Object> params) throws SQLException {
		return(List<SuppliesStocks>) this.getSqlMapClient().queryForList("searchStock", params);
	}

}
