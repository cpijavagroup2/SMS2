package com.dao;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.entity.IssuanceFields;

public interface IssuanceDao {

	void addIssue(Map<String, Object> params) throws SQLException;
	void updateIssue(Map<String, Object> params) throws SQLException;
	//List<IssuanceFields>getAllIssuanceFields()throws SQLException;
	List<IssuanceFields>getSupplyIdFields()throws SQLException;
	List<IssuanceFields>getDeptIdFields()throws SQLException;
	List<IssuanceFields>getAllFields()throws SQLException;
	List<IssuanceFields> searchIssue(Map<String, Object> params) throws SQLException;
}
