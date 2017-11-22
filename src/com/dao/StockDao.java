package com.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.entity.SuppliesStocks;


public interface StockDao {
	List<SuppliesStocks> getAllStocks() throws SQLException;
	List<SuppliesStocks> getItemStocks() throws SQLException;
	List<SuppliesStocks> getStock(Map<String, Object> params) throws SQLException;
	List<SuppliesStocks> searchStock(Map<String, Object> params) throws SQLException;
	void addStock(Map<String, Object> params) throws SQLException;
	void updateStock(Map<String, Object> params) throws SQLException;
}
