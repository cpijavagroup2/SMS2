package com.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.entity.IssuanceFields;

public interface IssuanceService {
void addissue(HttpServletRequest request) throws SQLException, ParseException ;
void updateissue(HttpServletRequest request) throws SQLException, ParseException ;
	
	//List<IssuanceFields> getAllIssuanceFields()throws SQLException;
	List<IssuanceFields> getSupplyIdFields()throws SQLException;
	List<IssuanceFields> getDeptIdFields()throws SQLException;
	List<IssuanceFields> getAllFields()throws SQLException;
	List<IssuanceFields> searchIssue(HttpServletRequest request) throws SQLException;
}
