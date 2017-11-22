package com.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.entity.SuppliesStocks;

public interface StockService {
	List<SuppliesStocks> getAllStocks() throws SQLException;
	List<SuppliesStocks> getAllItems() throws SQLException;
	List<SuppliesStocks> getStock(HttpServletRequest request) throws SQLException;
	List<SuppliesStocks> searchStock(HttpServletRequest request) throws SQLException;
	void addStock(HttpServletRequest request) throws SQLException;
	void updateStock(HttpServletRequest request) throws SQLException;
}
