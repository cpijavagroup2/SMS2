package com.service.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dao.IssuanceDao;
import com.entity.IssuanceFields;
import com.service.IssuanceService;

public class IssuanceServiceImpl implements IssuanceService{

private IssuanceDao issuanceDao;
	
	public IssuanceDao getIssuanceDao() {
		return issuanceDao;
	}

	public void setIssuanceDao(IssuanceDao issuanceDao) {
		this.issuanceDao = issuanceDao;
	}

	@Override
	public void addissue(HttpServletRequest request) throws SQLException, ParseException {
		// TODO Auto-generated method stub		

		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		Date date = new SimpleDateFormat("MMddyyyy").parse(request.getParameter("itemIssueDate").replace("/", ""));
		 		
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemQuantity", request.getParameter("itemQuantity"));
		params.put("itemRequestedby", request.getParameter("itemRequestedby"));
		params.put("itemDepartmentName", request.getParameter("itemDepartmentName"));
		params.put("itemIssueDate", date);
		params.put("lastUpdatedBy", session.getAttribute("userId"));
		
		this.getIssuanceDao().addIssue(params);
		
	}
	
	@Override
	public void updateissue(HttpServletRequest request) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = request.getSession();
		Date date = new SimpleDateFormat("MMddyyyy").parse(request.getParameter("itemIssueDate").replace("/", ""));
		 		
		params.put("itemName", request.getParameter("itemName"));
		params.put("itemQuantity", request.getParameter("itemQuantity"));
		params.put("itemRequestedby", request.getParameter("itemRequestedby"));
		params.put("itemDepartmentName", request.getParameter("itemDepartmentName"));
		params.put("itemIssueId", request.getParameter("itemIssueId"));
		params.put("itemTempQuant", request.getParameter("itemTempQuant"));
		params.put("itemIssueDate", date);
		params.put("lastUpdatedBy", session.getAttribute("userId"));
		
		this.getIssuanceDao().updateIssue(params);
		
	}

	/*@Override
	public List<IssuanceFields> getAllIssuanceFields() throws SQLException {
		// TODO Auto-generated method stub
		//return this.getUserDao().getAllUsers();
		return this.getUserDao().getAllIssuanceFields();
	}*/
	@Override
	public List<IssuanceFields> getSupplyIdFields() throws SQLException {
		// TODO Auto-generated method stub
		//return this.getUserDao().getAllUsers();
		return this.getIssuanceDao().getSupplyIdFields();
	}

	@Override
	public List<IssuanceFields> getDeptIdFields() throws SQLException {
		// TODO Auto-generated method stub
		return this.getIssuanceDao().getDeptIdFields();
	}

	@Override
	public List<IssuanceFields> getAllFields() throws SQLException {
		// TODO Auto-generated method stub
		return this.getIssuanceDao().getAllFields();
	}

	@Override
	public List<IssuanceFields> searchIssue(HttpServletRequest request) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("searchInput", request.getParameter("searchInput").toLowerCase());
		return this.getIssuanceDao().searchIssue(params);
	}

}
