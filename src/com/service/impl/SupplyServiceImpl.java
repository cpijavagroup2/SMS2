package com.service.impl;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dao.SupplyDao;
import com.entity.Supply;
import com.service.SupplyService;

public class SupplyServiceImpl implements SupplyService {
	
	private SupplyDao supplyDao;
	
	public SupplyDao getSupplyDao() {
		return supplyDao;
	}

	public void setSupplyDao(SupplyDao supplyDao) {
		this.supplyDao = supplyDao;
	}

	@Override
	public List<Supply> getAllSupply() throws SQLException {
		// TODO Auto-generated method stub
		return this.getSupplyDao().getAllSupply();
	}
	
	@Override
	public List<Supply> getAllTypeName() throws SQLException {
		// TODO Auto-generated method stub
		return this.getSupplyDao().getAllTypeName();
	}

	@Override
	public List<Supply> populateFields(HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("supplyid", request.getParameter("supplyid"));
		return this.getSupplyDao().populateFields(params);
	}

	

	@Override
	public void updateSupply(HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		params.put("supplyid", request.getParameter("supplyid"));
		params.put("obsoletetag", request.getParameter("obsoletetag"));
		params.put("location", request.getParameter("location"));
		params.put("itemunit", request.getParameter("itemunit"));
		params.put("reorderlevel", request.getParameter("reorderlevel"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("itemname", request.getParameter("itemname"));
		params.put("lastupdate", request.getParameter("lastupdate"));
		params.put("lastuser", session.getAttribute("userId"));
		
		this.getSupplyDao().updateSupply(params);
	}

	@Override
	public void addSupply(HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		params.put("supplyId", request.getParameter("supplyId"));
		params.put("supplyTypeId", request.getParameter("supplyTypeId"));
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemUnit", request.getParameter("itemUnit"));
		params.put("obsoleteTag", request.getParameter("obsoleteTag"));
		params.put("location", request.getParameter("location"));
		params.put("reorderLevel", request.getParameter("reorderLevel"));
		params.put("actualCount", request.getParameter("actualCount"));
		params.put("remarks", request.getParameter("remarks"));
		params.put("dateAdded", request.getParameter("dateAdded"));
		params.put("lastUser", session.getAttribute("userId"));
		params.put("lastUpdate", request.getParameter("lastUpdate"));
		
		this.getSupplyDao().addSupply(params);
	}
	
	@Override
	public List<Supply> searchSupply(HttpServletRequest request) throws SQLException {
		// TODO Auto-generated method stub
		Map<String, Object> params = new HashMap<>();
		params.put("searchInput", request.getParameter("searchInput").toLowerCase());
		return this.getSupplyDao().searchSupply(params);
	}

}
