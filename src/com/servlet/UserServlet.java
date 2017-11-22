package com.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.service.UserService;

public class UserServlet extends HttpServlet{

	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "";
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		UserService userService = (UserService) context.getBean("userService");
		
		try{
			HttpSession session = request.getSession();
			
			if("userMain".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				request.setAttribute("userList", userService.getSMSUsers());
				session.setAttribute("userList", request.getAttribute("userList"));
				session.setAttribute("currentPage", "pages/user-maintenance/home.jsp");
				session.setAttribute("module", "USER MAINTENANCE");
				request.setAttribute("module", "USER MAINTENANCE");
				view = "pages/user-maintenance/home.jsp";
			}else if("addUser".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				session.setAttribute("currentPage", "pages/user-maintenance/addnewuser.jsp");
				session.setAttribute("module", "USER MAINTENANCE");
				request.setAttribute("module", "USER MAINTENANCE");
				view = "pages/user-maintenance/addnewuser.jsp";
			}else if("updateUser".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				String userSession = (String) session.getAttribute("userId");
				userService.updateUser(request, userSession);
				request.setAttribute("userList", userService.getSMSUsers());				

				session.setAttribute("currentPage", "pages/user-maintenance/home.jsp");
				session.setAttribute("module", "USER MAINTENANCE");
				request.setAttribute("module", "USER MAINTENANCE");
				view = "pages/user-maintenance/home.jsp";
			}else if("changePassword".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				session.setAttribute("currentPage", "pages/user-maintenance/changepassword.jsp");
				session.setAttribute("module", "USER MAINTENANCE");
				request.setAttribute("module", "USER MAINTENANCE");
				view = "pages/user-maintenance/changepassword.jsp";
			}else if("savePassword".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				String userSession = (String) session.getAttribute("userId");
				String currentPassword = (String) session.getAttribute("currentPassword");
				String pw = request.getParameter("currentpassword");
				String newpw = request.getParameter("newpassword");
				
				if(currentPassword.equals(pw)){
					userService.changePassword(request, userSession);
					session.setAttribute("currentPassword", newpw);
				}else{
					request.setAttribute("message", "");
					view = "pages/user-maintenance/message.jsp";					
				}				
			}else if("savePasswordLogin".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				String userSession = (String) session.getAttribute("userId");
				String currentPassword = (String) session.getAttribute("currentPassword");
				String pw = request.getParameter("currentpassword");
				String newpw = request.getParameter("newpassword");
				
				if(currentPassword.equals(pw)){
					userService.changePassword(request, userSession);
					session.setAttribute("currentPassword", newpw);
					session.setAttribute("currentPage", "pages/login/home.jsp");
					session.setAttribute("module", "HOME");
					request.setAttribute("module", "HOME");
					view = "pages/login/home.jsp";
				}else{
					request.setAttribute("message", "");
					view = "pages/user-maintenance/message.jsp";					
				}				
			}else if("cancel".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				request.setAttribute("userList", userService.getSMSUsers());
				session.setAttribute("currentPage", "pages/user-maintenance/home.jsp");
				session.setAttribute("module", "USER MAINTENANCE");
				request.setAttribute("module", "USER MAINTENANCE");
				view = "pages/user-maintenance/home.jsp";
			}else if("cancel_login".equals(action)){
				request.setAttribute("user", session.getAttribute("userSession"));
				session.setAttribute("currentPage", "pages/login/home.jsp");
				session.setAttribute("module", "HOME");
				request.setAttribute("module", "HOME");
				view = "pages/login/home.jsp";
			}else if("searchUser".equals(action)){
				String user = userService.searchUser(request);
				System.out.println(">>>>>>>>> "+user);
				
				if(user == null){
					request.setAttribute("message", "");
					view = "pages/user-maintenance/message.jsp";
				}else{
					request.setAttribute("userList", userService.getSearchResults(user));
					
					request.setAttribute("user", session.getAttribute("userSession"));
					session.setAttribute("currentPage", "pages/user-maintenance/home.jsp");
					session.setAttribute("module", "USER MAINTENANCE");
					request.setAttribute("module", "USER MAINTENANCE");
					view = "pages/user-maintenance/home.jsp";
				}
			}else if("checkSession".equals(action)){
				String userSession = (String) session.getAttribute("userId");				
				request.setAttribute("message", userSession);
				view = "pages/user-maintenance/message.jsp";
			}

		}catch(Exception e){
			request.setAttribute("message", e.getMessage());
			view = "pages/user-maintenance/message.jsp";
			e.printStackTrace();
		}finally{
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}
		
	}

}
