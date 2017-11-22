package com.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.entity.Supply;

public interface SupplyDao {

	List<Supply>getAllSupply() throws SQLException; 
	List<Supply>getAllTypeName() throws SQLException; 
	List<Supply> searchSupply(Map<String, Object> params) throws SQLException;
	public void addSupply(Map<String, Object> params) throws SQLException;
	List<Supply>populateFields(Map<String, Object> params) throws SQLException; 
	public void updateSupply(Map<String, Object> params) throws SQLException;
}
