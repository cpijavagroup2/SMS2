<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<link href="${pageContext.request.contextPath}/css/reorderSupplies.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
<title>Reorder Supplies</title>
</head>
<body>
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
		new Ajax.Request("${pageContext.request.contextPath}/sms", {
			method : "GET",
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
		new Ajax.Request("${pageContext.request.contextPath}/sms", {
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
} catch (e){
	alert("ERROR!");
}
</script>