package com.servlet;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.entity.Supply;
import com.service.SupplyService;

public class SupplyServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String action = req.getParameter("action");
		String page = "";
	
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		SupplyService supplyService = (SupplyService) context.getBean("supplyService");
		
		HttpSession session = req.getSession();
		
		try {
			if("gotoSupplyListPage".equals(action)){
				 page = "pages/supply/SuppliesListingPage.jsp" ;
				 req.setAttribute("MenuPic", "supmain.png");
				 req.setAttribute("MenuName", "Supply Maintenance");
				 req.setAttribute("supplyList", supplyService.getAllSupply());
				 
				 session.setAttribute("supplyList", supplyService.getAllSupply());
				 
				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
			 }else if ("updateSupply".equals(action)){
				 page = "pages/supply/SuppliesListingPage.jsp" ;
				 req.setAttribute("MenuPic", "supmain.png");
				 req.setAttribute("MenuName", "Supply Maintenance");	
				 
				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
				 
				 try {
					 supplyService.updateSupply(req);
					 req.setAttribute("validate", "true");	
					 req.setAttribute("supplyList", supplyService.getAllSupply());
				 }catch(Exception e){
					 req.setAttribute("validate", "false");	
					 String message = e.getLocalizedMessage();
					 req.setAttribute("message", message);
					 req.setAttribute("supplyList", supplyService.getAllSupply());
				 }
			 }else if ("populatefields".equals(action)){
				 req.setAttribute("MenuPic", "supmain.png");
				 req.setAttribute("MenuName", "Supply Maintenance");
				 req.setAttribute("supplyList", supplyService.getAllSupply());
				 req.setAttribute("supplyList2", supplyService.populateFields(req));
				 List<Supply> supplyList = supplyService.populateFields(req);
				 req.setAttribute("supplyType", supplyList.get(0).getSupplyTypeId());
				 req.setAttribute("itemName", supplyList.get(0).getItemName());
				 req.setAttribute("itemUnit", supplyList.get(0).getItemUnit());
				 req.setAttribute("obsoleteTag", supplyList.get(0).getObsoleteTag());
				 req.setAttribute("location", supplyList.get(0).getLocation());
				 req.setAttribute("enteredDate", supplyList.get(0).getEntryDate());
				 req.setAttribute("reorderLevel", supplyList.get(0).getReorderLevel());
				 req.setAttribute("actualCount", supplyList.get(0).getActualCount());
				 req.setAttribute("remarks", supplyList.get(0).getRemarks());
				
				 page = "pages/supply/SuppliesListingPage.jsp" ;
				 
				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
				 
			 }else if ("addNewSupply".equals(action)){
				 page = "pages/supply/AddNewSupplies.jsp" ;
				 Date d = Calendar.getInstance().getTime(); // Current time
				 SimpleDateFormat sdf = new SimpleDateFormat("dd-MMM-yyyy"); // Set your date format
				 String currentData = sdf.format(d);
				 req.setAttribute("DateNow", currentData);
				 req.setAttribute("MenuPic", "supmain.png");	 
				 req.setAttribute("MenuName", "Supply Maintenance");
				 req.setAttribute("SupplyTypeNameList", supplyService.getAllTypeName());
				 req.setAttribute("supplyList", supplyService.getAllSupply());
				 
				 session.setAttribute("DateNow", currentData);
				 session.setAttribute("SupplyTypeNameList", supplyService.getAllTypeName());
				 session.setAttribute("supplyList", supplyService.getAllSupply());
				 
				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
				 
			 } else if ("saveSupply".equals(action)){
				 page = "pages/supply/SuppliesListingPage.jsp" ;
				 req.setAttribute("MenuPic", "supplies.ico");
				 req.setAttribute("MenuName", "Supply Maintenance");

				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
				 try {
					 supplyService.addSupply(req);
					 req.setAttribute("validateadd", "true");	
					 req.setAttribute("supplyList", supplyService.getAllSupply());		
				 }catch(Exception e){
					 req.setAttribute("validateadd", "false");	
					 String message = e.getLocalizedMessage();
					 req.setAttribute("message", message);
					 req.setAttribute("supplyList", supplyService.getAllSupply());
				 }				 
			 } else if ("load".equals(action)) {
				 page = "pages/supply/SuppliesListingPage.jsp" ;
				 req.setAttribute("MenuPic", "supplies.ico");
				 req.setAttribute("MenuName", "Supply Maintenance");
				 req.setAttribute("supplyList", supplyService.getAllSupply());
				 
				 req.setAttribute("user", session.getAttribute("userSession"));
				 session.setAttribute("currentPage", page);
				 session.setAttribute("module", "SUPPLY MAINTENANCE");
				 req.setAttribute("module", "SUPPLY MAINTENANCE");
			 }else if("searchSupply".equals(action)){
					req.setAttribute("searchList", supplyService.searchSupply(req));
					page="pages/supply/SearchSupply.jsp";
			 }
		}catch(Exception e){
			req.setAttribute("message", e.getMessage());
			e.printStackTrace();
		}finally {
			RequestDispatcher dispatcher = req.getRequestDispatcher(page);
			dispatcher.forward(req, resp);
		}			
	}			
}
