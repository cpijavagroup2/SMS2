<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/reorderSupplies.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
</head>
<body>
<table>
			<tr>
				<td><h3>Stocks</h3><td>
				<td></td>
			</tr>
			<tr>
				<td class="label">Item Name<td>
				<td><select class="fields" id="selItem" disabled="disabled">
						<c:forEach var="itm" items="${itemList}">
							 <c:choose>
  								<c:when test = "${itm.supplyId == selSupplyId}">
  									<option value="${itm.supplyId}" selected="selected"><c:out value="${itm.itemName}"/></option>
  								</c:when>
  								<%-- <c:otherwise>
							 		<option value="${itm.supplyId}"><c:out value="${itm.itemName}"/></option>
							 	</c:otherwise> --%>
							 </c:choose>
						</c:forEach>
					</select></td>
			</tr>
			<tr>
				<td class="label">Quantity<td>
				<td><input type="text" class="fields" id="txtQuantity" value="${selQty}" maxlength="4"></td>
			</tr>
			<tr>
				<td class="label">Reference No.<td>
				<td><input type="text" class="fields" id="txtReferenceNo"  value="${selReferenceNo}" maxlength="100"></td>
			</tr>
			<tr>
				<td class="label">Date Added<td>
				<td><input type="date" class="fields" id="txtDateAdded"  value="${selDateAdded}"></td>
			</tr>
			<tr>
				<td class="label">Purchase Date<td>
				<td><input type="date" class="fields" id="txtPurchaseDate"  value="${selPurchaseDate}"></td>
			</tr>
			<tr>
				<td class="label trSearch" >Search <img id="imgSearch" src="${pageContext.request.contextPath}/images/mg.png"><td>
				<td class="trSearch"><input type="text" class="fields" id="txtSearch"></td>
			</tr>
		</table>	
		
		<div id="divSuppliesStocksButtons">
			<input type="button" id="btnAddStocks" value="Add Stocks" class="btn"/>
			<input type="button" id="btnSave" value="Save" class="btn"/>
			<input type="button" id="btnCancel" value="Cancel" class="btn"/>
		</div>
</body>
</html>
<script>
try{
	var SID = "";
	var contextPath = "${pageContext.request.contextPath}";
	$("btnAddStocks").observe("click", addStocks);
	$("btnSave").observe("click", updateStock);
	$("btnCancel").observe("click", cancel);
	$("txtSearch").observe("keyup",searchStock);	
	
	if($("selItem").value == "" && $("txtQuantity").value == "" && $("txtReferenceNo").value == "" && $("txtDateAdded").value == "" && $("txtPurchaseDate").value == ""){	
		$("btnSave").disabled = true;
		$("btnSave").addClassName("disabled");
		$("txtQuantity").disabled = true;
		$("txtReferenceNo").disabled = true;
		$("txtDateAdded").disabled = true;
		$("txtPurchaseDate").disabled = true;
	}else{
		$("btnAddStocks").disabled = true;
		$("btnAddStocks").addClassName("disabled");
	}
	
	
	function loadReorderTable(){
		new Ajax.Request(contextPath+"/sms", {
			method : "GET",
			parameters : {
				action : "loadReorderTable",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("divSuppliesStocksTable").update(res);
			}
		});
	}
	
	function addStocks(){
		new Ajax.Request(contextPath+"/sms", {
			method : "GET",
			parameters : {
				action : "addStocks",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("mainDiv").update(res);
			}
		});
	}
	
	function updateStock(){
		if(isNaN($F("txtQuantity")) || $F("txtQuantity") == null || $F("txtQuantity") == ""){
				alert("Quantity is invalid!");
				return false;
		}
		if($F("txtDateAdded") == null || $F("txtDateAdded") == ""){
			alert("Date Added is invalid!");
			return false;
		}
		new Ajax.Request(contextPath+"/sms", {
			method : "POST",
			parameters : {
				action : "updateStock",
				stockId : '${selStockID}', 
				supplyId : $F("selItem"),
				oldQty : '${selQty}',
				qty : $F("txtQuantity"),
				referenceNo : $F("txtReferenceNo"),
				dateAdded : $F("txtDateAdded"),
				purchaseDate : $F("txtPurchaseDate")
			},
			onComplete : function(response){
				alert("Stock Updated.");
				var res = response.responseText;
					$("divSuppliesStocksTable").update(res);
					loadReorderTable();
			}
		});
	}
	
	function searchStock(){
		 new Ajax.Request(contextPath+"/sms", {
			method : "POST",
			parameters : {
				action : "searchStock",
				searchInput : $F("txtSearch")
			},	
			onComplete : function(response){
				var res = response.responseText;
					$("divSuppliesStocksTable").update(res);
			}
		}); 
	}
	
	function cancel(){
		$("selItem").value = null;
		$("txtQuantity").value = null;
		$("txtReferenceNo").value = null;
		$("txtDateAdded").value = null;
		$("txtPurchaseDate").value = null;
		$("txtSearch").value = null;
		$("btnSave").disabled = true;
		$("btnSave").addClassName("disabled");
		$("txtQuantity").disabled = true;
		$("txtReferenceNo").disabled = true;
		$("txtDateAdded").disabled = true;
		$("txtPurchaseDate").disabled = true;
		$("btnAddStocks").disabled = false;
		$("btnAddStocks").removeClassName("disabled");
		loadReorderTable();
	}
} catch (e){
	alert("ERROR!");
}	
</script>