package com.service;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.entity.Users;

public interface LoginService {
	public String validateLogin(HttpServletRequest req) throws SQLException;
	public String login(HttpServletRequest req, LoginService loginService);
	public String checkSession(HttpServletRequest req); 
	public String logout(HttpServletRequest req, LoginService loginService);
	public void updateUser(HttpServletRequest req) throws SQLException,  ParseException;
	public List<Users> getUser(HttpServletRequest req) throws SQLException;
	public void addAttemp(HttpServletRequest req) throws SQLException, ParseException;
	public void lockAccount(HttpServletRequest req) throws SQLException, ParseException;
	public void resetAttemp(HttpServletRequest req) throws SQLException, ParseException;
	public String home(HttpServletRequest req);
}
