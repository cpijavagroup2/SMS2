<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/reorderSupplies.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
</head>
<body>
		<table class="tblSuppliesStocks">
			<tr>
				<th width="79px">Stock ID</th>
				<th width="95px">Item Name</th>
				<th width="45px">Qty</th>
				<th width="123px">Reference No.</th>
				<th width="103px">Date Added</th>
				<th width="124px">Purchase Date</th>
				<th width="135px">Last Updated By</th>
				<th width="105px">Last Update</th>
			</tr>
		</table>
		<div id="divRecordsTable">
		<table class="tblSuppliesStocks">
			<c:forEach var="stk" items="${stockList}">
				<tr>
					<td width="79px" class="suppliesStocksRecord"><a href="javascript: void(0)" class="stockID"><c:out value="${stk.stockID}"/></a></td>
					<td width="95px" class="suppliesStocksRecord"><c:out value="${stk.itemName}"/></td>
					<td width="45px" class="suppliesStocksRecord recRigth"><c:out value="${stk.qty}"/></td>
					<td width="123px" class="suppliesStocksRecord"><c:out value="${stk.referenceNo}"/></td>
					<td width="103px" class="suppliesStocksRecord recRigth"><c:out value="${stk.dateAdded}"/></td>
					<td width="124px" class="suppliesStocksRecord recRigth"><c:out value="${stk.purchaseDate}"/></td>
					<td width="135px" class="suppliesStocksRecord"><c:out value="${stk.lastUpdatedBy}"/></td>
					<td width="105px" class="suppliesStocksRecord recRigth"><c:out value="${stk.lastUpdate}"/></td>
				</tr>
			</c:forEach>
		</table>
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
		new Ajax.Request("${pageContext.request.contextPath}/sms", {
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