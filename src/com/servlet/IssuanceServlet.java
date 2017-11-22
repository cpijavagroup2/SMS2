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

import com.service.IssuanceService;


public class IssuanceServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String page="";
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		IssuanceService issuanceService = (IssuanceService) context.getBean("issuanceService");
		HttpSession session = request.getSession();
		try {
			//System.out.println("action "+action);
			System.out.println("issue servlet");
			request.setAttribute("itemList", issuanceService.getSupplyIdFields());
			request.setAttribute("deptList", issuanceService.getDeptIdFields());				
			session.setAttribute("itemList", issuanceService.getSupplyIdFields());
			session.setAttribute("deptList", issuanceService.getDeptIdFields());
			request.setAttribute("user", session.getAttribute("userSession"));				
			session.setAttribute("module", "SUPPLY ISSUANCE");
			request.setAttribute("module", "SUPPLY ISSUANCE");
			if("addpage".equals(action)){
				System.out.println("issue addpage");				
				session.setAttribute("currentPage", "pages/issuance/issuance.jsp");
				page= "pages/issuance/addissue.jsp";	
			}
			else if("backissue".equals(action)){
				System.out.println("issue backissue");
				request.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("currentPage", "pages/issuance/issuance.jsp");				
				page= "pages/issuance/issuance.jsp";	
			}
			else if("issuance".equals(action)){						
				request.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("currentPage", "pages/issuance/issuance.jsp");
				
				page= "pages/issuance/issuance.jsp";	
			}									
			else if("addIssue".equals(action)) {	
				System.out.println("issue addIssue");
				issuanceService.addissue(request);
				request.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("currentPage", "pages/issuance/issuance.jsp");				
				page= "pages/issuance/issuance.jsp";				
			}
			else if("updateIssue".equals(action)){
				System.out.println("issue updateIssue start");
				issuanceService.updateissue(request);
				request.setAttribute("allList", issuanceService.getAllFields());
				session.setAttribute("currentPage", "pages/issuance/issuance.jsp");				
				page= "pages/issuance/issueTable.jsp";
				System.out.println("issue updateIssue finish");
			}
			else if("searchStock".equals(action)){
				request.setAttribute("allList", issuanceService.searchIssue(request));
				page= "pages/issuance/issueTable.jsp";
			}
			
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			RequestDispatcher dispatcher = request.getRequestDispatcher(page);
			dispatcher.forward(request, response);
		}	
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String page="";
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		IssuanceService issuanceService = (IssuanceService) context.getBean("issuanceService");
		HttpSession session = request.getSession();
		try {
			//System.out.println("action "+action);
			System.out.println("issue servlet");
			
			if("loadTable".equals(action)){	
				request.setAttribute("allList", issuanceService.getAllFields());	

				page= "pages/issuance/issueTable.jsp";	
			}else if("loadField".equals(action)){	
				request.setAttribute("itemList", issuanceService.getSupplyIdFields());
				request.setAttribute("deptList", issuanceService.getDeptIdFields());
				session.setAttribute("itemList", issuanceService.getSupplyIdFields());
				session.setAttribute("deptList", issuanceService.getDeptIdFields());

				page= "pages/issuance/issueField.jsp";	
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			RequestDispatcher dispatcher = request.getRequestDispatcher(page);
			dispatcher.forward(request, response);
		}	
	}
}
