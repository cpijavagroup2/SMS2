<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>

<title>Reorder Supplies</title>
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
			<label class="bodyheaderfont">Supplies Stocks</label>
		</div>
	</div>	
</div>

<div id="divSuppliesStocksFields">
		
</div>
	
<div id="divSuppliesStocksTable">
	
</div>

</body>
</html>

<script>
try{
	loadReorderFields();
	loadReorderTable();

	function loadReorderFields(){
		new Ajax.Request("${pageContext.request.contextPath}/stock", {
			method : "get",
			parameters : {
				action : "loadReorderFields",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("divSuppliesStocksFields").update(res);
			}
		});
	}
		
	function loadReorderTable(){
		new Ajax.Request("${pageContext.request.contextPath}/stock", {
			method : "get",
			parameters : {
				action : "loadReorderTable",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("divSuppliesStocksTable").update(res);
			}
		});
	}
	
} catch (e){
	alert("ERROR!")
}
</script>