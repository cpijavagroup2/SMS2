package com.service;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.entity.Supply;


public interface SupplyService {
	List<Supply>getAllSupply() throws SQLException;
	List<Supply>getAllTypeName() throws SQLException;	
	List<Supply> searchSupply(HttpServletRequest request) throws SQLException;
	List<Supply>populateFields(HttpServletRequest request) throws SQLException; 
	void updateSupply(HttpServletRequest request) throws SQLException ;
	void addSupply(HttpServletRequest request) throws SQLException ;
}
