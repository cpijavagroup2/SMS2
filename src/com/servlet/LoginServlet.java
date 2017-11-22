package com.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.service.LoginService;

public class LoginServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String action = req.getParameter("action");
		String view = "";	

		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("com/resource/applicationContext.xml");
		LoginService loginService = (LoginService) context.getBean("loginService");		
		
		try{			
			if("login".equals(action)){
				view = loginService.login(req, loginService);				
			}else if("checkSession".equals(action)){
				view = loginService.checkSession(req);
			}else if("logout".equals(action)){
				view = loginService.logout(req, loginService);
			}else if("home".equals(action)){
				view = loginService.home(req);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}finally{
			RequestDispatcher dispatcher = req.getRequestDispatcher(view);
			dispatcher.forward(req, resp);
		}
	}

}
