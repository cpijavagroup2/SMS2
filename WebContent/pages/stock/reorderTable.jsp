<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
	<div id="tblSuppliesStocks" >
		<div name="rowName" class="tableRow" style="background-color: #49b0fc;">
			<b>
				<label class="rowData">Stock ID</label>
				<label class="rowData">Item Name</label>
				<label class="rowData">Qty</label>
				<label class="rowData" >Reference No.</label>
				<label class="rowData">Date Added</label>
				<label class="rowData">Purchase Date</label>
				<label class="rowData">Last Updated By</label>
				<label class="rowData">Last Update</label>
			</b>
		</div>
		
		<div class="tableData">
		<c:forEach var="stk" items="${stockList}">		
			<div class="tableRow rowHeight" name="rowName" >	
				<label class="rowData"><a href="javascript: void(0)" class="stockID"><c:out value="${stk.stockID}"/></a></label>
				<label class="rowData"><c:out value="${stk.itemName}"/></label>
				<label class="rowData"><c:out value="${stk.qty}"/></label>
				<label class="rowData dataRefNo">
					<c:choose>
					    <c:when test="${empty stk.referenceNo}">
					        --
					    </c:when>    
					    <c:otherwise>
					        <c:out value="${stk.referenceNo}"/>
					    </c:otherwise>
					</c:choose>	
				</label>
				<label class="rowData">
					<c:choose>
					    <c:when test="${empty stk.dateAdded}">
					        --
					    </c:when>    
					    <c:otherwise>
					        <c:out value="${stk.dateAdded}"/>
					    </c:otherwise>
					</c:choose>	
				</label>
				<label class="rowData">
					<c:choose>
					    <c:when test="${empty stk.purchaseDate}">
					        --
					    </c:when>    
					    <c:otherwise>
					        <c:out value="${stk.purchaseDate}"/>
					    </c:otherwise>
					</c:choose>	
				</label>
				<label class="rowData"><c:out value="${stk.lastUpdatedBy}"/></label>
				<label class="rowData">
					<c:choose>
					    <c:when test="${empty stk.lastUpdate}">
					        --
					    </c:when>    
					    <c:otherwise>
					        <c:out value="${stk.lastUpdate}"/>
					    </c:otherwise>
					</c:choose>	
				</label>	
			</div>		
		</c:forEach>
		</div>
	</div>
</body>
</html>
<script>
try{
	$$("a").each(function(a){
		a.observe("click", function(x){
			SID = a.innerHTML;
			fillFields(SID);
		});
	}); 
	
	function fillFields(SID){
		new Ajax.Request("${pageContext.request.contextPath}/stock", {
			method : "POST",
			parameters : {
				action : "fillFields",
				stockId : SID
			},
			onComplete : function(response){
				var res = response.responseText;
					$("divSuppliesStocksFields").update(res);
			}
		});
		$("btnSave").disabled = false;
		$("btnSave").removeClassName("disabled");
		$("btnAddStocks").addClassName("disabled");
		$("btnAddStocks").disabled = true;
		$("txtQuantity").disabled = false;
		$("txtReferenceNo").disabled = false;
		$("txtDateAdded").disabled = false;
		$("txtPurchaseDate").disabled = false;

	}
} catch (e){
	alert("ERROR!");
}
</script>	