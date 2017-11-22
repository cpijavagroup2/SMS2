<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>Add Stocks</title>
</head>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
<div class="bodyhead">
	<div class="bodyhead2">
		<div class="bodyhead3"> 
			<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/stock.png">
		</div>		
		<div class="bodyhead4">
			<label class="bodyheaderfont">Supplies Stock</label>
		</div>
	</div>	
</div>
<!-- <div id="mainDiv"> -->
	<div id="divSuppliesStocksFields">
		<table>
			<tr>
				<td class="label">Item Name<td>
				<td><select class="fields" id="selItem">
						<c:forEach var="itm" items="${itemList}">
							 <option value="${itm.supplyId}"><c:out value="${itm.itemName}"/></option>
						</c:forEach>
					</select></td>
			</tr>
			<tr>
				<td class="label">Quantity<td>
				<td><input type="text" class="fields" id="txtQuantity" maxlength="4"></td>
			</tr>
			<tr>
				<td class="label">Reference No.<td>
				<td><input type="text" class="fields" id="txtReferenceNo" maxlength="100"></td>
			</tr>
			<tr>
				<td class="label">Date Added<td>
				<td><input type="date" class="fields" id="txtDateAdded"></td>
			</tr>
			<tr>
				<td class="label">Purchase Date<td>
				<td><input type="date" class="fields" id="txtPurchaseDate"></td>
			</tr>
		</table>	
	</div>
	<div id="divSuppliesStocksButtons">
	<input type="button" id="btnSave" value="Save" class="button"/>
	<input type="button" id="btnCancel" value="Cancel" class="button"/>
	</div>
</body>
</html><script>
try{
	var contextPath = "${pageContext.request.contextPath}";
	function cancelAddStocks(){
		new Ajax.Request(contextPath+"/stock", {
			method : "GET",
			parameters : {
				action : "cancelAddStocks",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("mainDiv").update(res);
			}
		});
	}
	$("btnCancel").observe("click", cancelAddStocks);
	
	function addStock(){
		if(isNaN($F("txtQuantity")) || $F("txtQuantity") == null || $F("txtQuantity") == ""){
			alert("Quantity is invalid!");
			$("txtQuantity").value = "";
			return false;
		}
		
		if($F("txtDateAdded") == null || $F("txtDateAdded") == ""){
			alert("Date Added is invalid!");
			return false;
		}

		new Ajax.Request(contextPath+"/stock", {
			method : "POST",
			parameters : {
				action : "addStock",
				supplyId : $F("selItem"),
				qty : $F("txtQuantity"),
				referenceNo : $F("txtReferenceNo"),
				dateAdded : $F("txtDateAdded"),
				purchaseDate : $F("txtPurchaseDate")
			},
			onComplete : function(response){
				alert("Stocks Added.");
			}
		});
		
		$("selItem").value = null;
		$("txtQuantity").value = null;
		$("txtReferenceNo").value = null;
		$("txtDateAdded").value = null;
		$("txtPurchaseDate").value = null;
	}
	$("btnSave").observe("click", addStock);
	
} catch (e){
	alert("ERROR!")
}
</script>