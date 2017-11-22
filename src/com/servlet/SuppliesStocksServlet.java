package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import com.entity.SuppliesStocks;
import com.service.StockService;

//import org.springframework.context.ApplicationContext;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
	

public class SuppliesStocksServlet extends HttpServlet{
	private static final long serialVersionUID = 1L;
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "";
		
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		StockService stockService = (StockService) context.getBean("stockService");

		HttpSession session = request.getSession();
		
		try{
			request.setAttribute("stockList", stockService.getAllStocks());
			request.setAttribute("itemList", stockService.getAllItems());
			if("addStock".equals(action)){
				stockService.addStock(request);
			}else if("fillFields".equals(action)){
				List<SuppliesStocks> selStock = stockService.getStock(request);
				request.setAttribute("selSupplyId", selStock.get(0).getSupplyId());
				request.setAttribute("selStockID", selStock.get(0).getStockID());
				request.setAttribute("selItemName", selStock.get(0).getItemName());
				request.setAttribute("selQty", selStock.get(0).getQty());
				request.setAttribute("selReferenceNo", selStock.get(0).getReferenceNo());
				request.setAttribute("selDateAdded", selStock.get(0).getDateAdded());
				request.setAttribute("selPurchaseDate", selStock.get(0).getPurchaseDate());
				view="pages/stock/reorderFields.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}else if("updateStock".equals(action)){
				stockService.updateStock(request);
				view="pages/stock/reorderTable.jsp";
				//view="pages/stock/reorderSupplies.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}else if("searchStock".equals(action)){
				request.setAttribute("stockList", stockService.searchStock(request));
				//request.setAttribute("searchInput", request.getParameter("searchInput"));
				view="pages/stock/reorderTable.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}
			
			request.setAttribute("user", session.getAttribute("userSession"));
			session.setAttribute("module", "SUPPLY ISSUANCE");
			request.setAttribute("module", "SUPPLY ISSUANCE");
			
		}catch(Exception e){
			request.setAttribute("message", e.getMessage());
			view = "pages/stock/message.jsp";
			e.printStackTrace();
		}finally{
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}
	}	
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "";
		@SuppressWarnings("resource")
		ApplicationContext context = new ClassPathXmlApplicationContext("/com/resource/applicationContext.xml");
		StockService stockService = (StockService) context.getBean("stockService");
		
		HttpSession session = request.getSession();
		
		try{
			request.setAttribute("stockList", stockService.getAllStocks());
			request.setAttribute("itemList", stockService.getAllItems());
			if("addStocks".equals(action)){
				view="pages/stock/addStocks.jsp";
				session.setAttribute("currentPage", "pages/stock/addStocks.jsp");
			}else if("cancelAddStocks".equals(action)){
				view="pages/stock/reorderSupplies.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}else if("load".equals(action)){
				view="pages/stock/reorderSupplies.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}else if("loadReorderTable".equals(action)){
				view="pages/stock/reorderTable.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}else if("loadReorderFields".equals(action)){
				view="pages/stock/reorderFields.jsp";
				session.setAttribute("currentPage", "pages/stock/reorderSupplies.jsp");
			}
			
			request.setAttribute("user", session.getAttribute("userSession"));
			session.setAttribute("module", "SUPPLIES STOCK");
			request.setAttribute("module", "SUPPLIES STOCK");
			
		}catch(Exception e){
			System.out.println("error");
			request.setAttribute("message", e.getMessage());
			view = "";
			e.printStackTrace();
		}finally{
			RequestDispatcher dispatcher = request.getRequestDispatcher(view);
			dispatcher.forward(request, response);
		}
	}
}
