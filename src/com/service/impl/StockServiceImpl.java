package com.service.impl; 

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dao.StockDao;
import com.entity.SuppliesStocks;
import com.service.StockService;

public class StockServiceImpl implements StockService{
	private StockDao stockDao;
	
	public StockDao getStockDao() {
		return stockDao; 
	}
	public void setStockDao(StockDao stockDao) {
		this.stockDao = stockDao;
	}
	
	@Override
	public List<SuppliesStocks> getAllStocks() throws SQLException {
		return this.getStockDao().getAllStocks();
	}
	
	@Override
	public List<SuppliesStocks> getAllItems() throws SQLException {
		return this.getStockDao().getItemStocks();
	}
	
	@Override
	public void addStock(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("qty", request.getParameter("qty"));
		params.put("referenceNo", request.getParameter("referenceNo"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("purchaseDate", request.getParameter("purchaseDate"));
		params.put("userName", session.getAttribute("userId"));
		this.getStockDao().addStock(params);
	}
	
	@Override
	public List<SuppliesStocks> getStock(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("stockId", request.getParameter("stockId"));
		return this.getStockDao().getStock(params);
	}
	
	@Override
	public void updateStock(HttpServletRequest request) throws SQLException {
		int countChange;
		countChange =Integer.parseInt(request.getParameter("qty")) - Integer.parseInt(request.getParameter("oldQty"));
		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		params.put("stockId", request.getParameter("stockId"));
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("qty", request.getParameter("qty"));
		params.put("referenceNo", request.getParameter("referenceNo"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("purchaseDate", request.getParameter("purchaseDate"));
		params.put("countChange", countChange);
		params.put("userName", session.getAttribute("userId"));
		this.getStockDao().updateStock(params);
	}
	@Override
	public List<SuppliesStocks> searchStock(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("searchInput", request.getParameter("searchInput").toLowerCase());
		return this.getStockDao().searchStock(params);
	}

}
