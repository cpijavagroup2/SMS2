package com.service.impl;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.dao.LoginUserDao;
import com.entity.Users;
import com.service.LoginService;

public class LoginServiceImpl implements LoginService{

	private LoginUserDao loginUserDao;
	
	public LoginUserDao getLoginUserDao() {
		return loginUserDao;
	}

	public void setLoginUserDao(LoginUserDao loginUserDao) {
		this.loginUserDao = loginUserDao;
	}
	
	@Override
	public String validateLogin(HttpServletRequest req) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("userName", req.getParameter("userName"));
		params.put("password", req.getParameter("password"));
		
		return this.getLoginUserDao().validateLogin(params);
	}
	
	public String login(HttpServletRequest req, LoginService loginService){
		String view="";
		HttpSession session = req.getSession();

		String login;
		try {
			login = loginService.validateLogin(req);
			List<Users> userAttemp = getUser(req);
			if(login==null || userAttemp.get(0).getActiveTag().equals("N")){
				
				if(!userAttemp.isEmpty()){
					session.setAttribute("attemp", userAttemp.get(0).getUserName());
					loginService.addAttemp(req);
					if(userAttemp.get(0).getAttemp() >= 2){
						loginService.lockAccount(req);
					}
				}
				
				if(userAttemp.isEmpty()){
					req.setAttribute("message", "Invalid username/password.");
					session.setAttribute("message", "Invalid username/password.");					
				}else if( userAttemp.get(0).getAttemp() >= 3 || userAttemp.get(0).getActiveTag().equals("N")){
					req.setAttribute("message", "Account Locked. Please contact Administrator.");
					session.setAttribute("message", "Account Locked. Please contact Administrator.");
				}else{
					req.setAttribute("message", "Invalid username/password.");
					session.setAttribute("message", "Invalid username/password.");
				}
				view = "pages/login/login.jsp";
			}else{		

				String pw = req.getParameter("password");
				session.setAttribute("currentPassword", pw);				
				session.setAttribute("userSession", login);
				session.setAttribute("userId", req.getParameter("userName"));
				session.setAttribute("accessLevel", userAttemp.get(0).getAccessLevel());
				req.setAttribute("user", session.getAttribute("userSession"));
				req.setAttribute("accessLevel", session.getAttribute("accessLevel"));
				session.removeAttribute("message");
				loginService.resetAttemp(req);
				
				if(pw.equals(req.getParameter("userName"))){
					session.setAttribute("module", "USER MAINTENANCE");
					req.setAttribute("module", "USER MAINTENANCE");	
					session.setAttribute("currentPage", "pages/login/changepassword.jsp");	
				}else{
					session.setAttribute("module", "HOME");
					req.setAttribute("module", "HOME");								
					session.setAttribute("currentPage", "pages/login/home.jsp");
				}
				
				view = (String)session.getAttribute("currentPage");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
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
				if(session.getAttribute("message").equals("Account Locked. Please contact Administrator.")){
					req.setAttribute("message", "Account Locked. Please contact Administrator.");
					session.removeAttribute("message");
				}
				else{
					req.setAttribute("message", "Invalid username/password.");
					session.removeAttribute("message");
				}
			}
			req.setAttribute("userAttemp", session.getAttribute("attemp"));
			session.removeAttribute("attemp");
			view = "pages/login/login.jsp";
		}else{		
			req.setAttribute("user", userSession);
			
			if(session.getAttribute("currentPage").equals("pages/user-maintenance/home.jsp")){
				req.setAttribute("userList", session.getAttribute("userList"));
			}else if(session.getAttribute("currentPage").equals("pages/issuance/issuance.jsp")){
				req.setAttribute("itemList", session.getAttribute("itemList"));
				req.setAttribute("deptList", session.getAttribute("deptList"));
				req.setAttribute("allList", session.getAttribute("allList"));
			}else if(session.getAttribute("currentPage").equals("pages/supply/SuppliesListingPage.jsp")){
				 req.setAttribute("MenuPic", "supmain.png");
				 req.setAttribute("MenuName", "Supply Maintenance");
				 req.setAttribute("supplyList", session.getAttribute("supplyList"));
			}else if(session.getAttribute("currentPage").equals("pages/supply/AddNewSupplies.jsp")){
				 req.setAttribute("MenuPic", "supmain.png");
				 req.setAttribute("MenuName", "Supply Maintenance");
				 
				 req.setAttribute("DateNow", session.getAttribute("DateNow"));
				 req.setAttribute("SupplyTypeNameList", session.getAttribute("SupplyTypeNameList"));
				 req.setAttribute("supplyList",req.getAttribute("supplyList"));
			}
			
			req.setAttribute("currentPage", session.getAttribute("currentPage"));
			req.setAttribute("module", session.getAttribute("module"));
			view = (String)session.getAttribute("currentPage");
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
				
		return "pages/login/login.jsp";
	}
	
	public void updateUser(HttpServletRequest req) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = req.getSession();
		Date date = new Date();
		
		String userId = (String) session.getAttribute("userId");
		params.put("userName", userId);
		params.put("currentDate", date);
		System.out.println("service "+params);
		this.getLoginUserDao().updateUser(params);		
	}
	
	public List<Users> getUser(HttpServletRequest req) throws SQLException {
		Map<String, Object> params = new HashMap<>();
		params.put("userName", req.getParameter("userName"));
		return this.getLoginUserDao().getUser(params);
	}
	
	public void addAttemp(HttpServletRequest req) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = req.getSession();
		
		String userId = (String) session.getAttribute("attemp");
		params.put("userName", userId);
		this.getLoginUserDao().addAttemp(params);		
	}
	
	public void lockAccount(HttpServletRequest req) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		HttpSession session = req.getSession();
		
		String userId = (String) session.getAttribute("attemp");
		params.put("userName", userId);
		this.getLoginUserDao().lockAccount(params);		
	}
	
	public void resetAttemp(HttpServletRequest req) throws SQLException, ParseException {
		Map<String, Object> params = new HashMap<>();
		
		String userId = (String) req.getParameter("userName");
		params.put("userName", userId);
		this.getLoginUserDao().resetAttemp(params);		
	}
	
	public String home(HttpServletRequest req){
		HttpSession session = req.getSession();		
		req.setAttribute("user", session.getAttribute("userSession"));		
		session.setAttribute("currentPage", "pages/login/home.jsp");
		session.setAttribute("module", "HOME");
		req.setAttribute("module", "HOME");
		return "pages/login/home.jsp";
	}
}
