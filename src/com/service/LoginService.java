package com.service;

import java.sql.SQLException;
import java.text.ParseException;

import javax.servlet.http.HttpServletRequest;

public interface LoginService {
	public String validateLogin(HttpServletRequest req) throws SQLException;
	public String login(HttpServletRequest req, LoginService loginService);
	public String checkSession(HttpServletRequest req); 
	public String logout(HttpServletRequest req, LoginService loginService);
	public void updateUser(HttpServletRequest req) throws SQLException,  ParseException;
}
