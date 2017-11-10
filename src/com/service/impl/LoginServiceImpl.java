package com.service.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.service.LoginService;

public class LoginServiceImpl implements LoginService{

	private UserDao userDao;
	
	public UserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
	@Override
	public String validateLogin(HttpServletRequest req) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("userName", req.getParameter("userName"));
		params.put("password", req.getParameter("password"));
		
		return this.getUserDao().validateLogin(params);
	}

	public String login(HttpServletRequest req, LoginService loginService){
		String view="";
		HttpSession session = req.getSession();
		
		String login;
		try {
			login = loginService.validateLogin(req);	
		
			if(login==null){
				req.setAttribute("message", "Invalid username/password.");
				session.setAttribute("message", "Invalid username/password.");
				view = "pages/login.jsp";
			}else{
				session.setAttribute("userSession", login);
				session.setAttribute("userId", req.getParameter("userName"));
				req.setAttribute("user", session.getAttribute("userSession"));
				session.removeAttribute("message");
				view = "pages/home.jsp";
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return view;
	}
	
	public String checkSession(HttpServletRequest req) {
		String view = "";
		HttpSession session = req.getSession();
		String userSession = (String) session.getAttribute("userSession");
		
		if(userSession == null){
			req.setAttribute("chkSession", "Y");	
			if(session.getAttribute("message") != null){
				req.setAttribute("message", "Invalid username/password.");
				session.removeAttribute("message");
			}
			view = "pages/login.jsp";
		}else{		
			req.setAttribute("user", userSession);
			view = "pages/home.jsp";
		}		
		return view;
	}

	@Override
	public String logout(HttpServletRequest req, LoginService loginService) {
		HttpSession session = req.getSession();
		
		try {
			loginService.updateUser(req);
			session.invalidate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
				
		return "pages/login.jsp";
	}
	
	public void updateUser(HttpServletRequest req) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = req.getSession();
		Date date = new Date();
		
		String userId = (String) session.getAttribute("userId");
		params.put("userName", userId);
		params.put("currentDate", date);
		System.out.println("service "+params);
		this.getUserDao().updateUser(params);
		
	}
}
