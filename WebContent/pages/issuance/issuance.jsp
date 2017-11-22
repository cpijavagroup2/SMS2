<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
<div id="contentDiv" align="center">
	<div class="bodyhead">
			<div class="bodyhead2">
				<div class="bodyhead3"> 
				<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/issuance2.png">
				</div>
				<div class="bodyhead4" style="text-align: left;">
				<label class="bodyheaderfont" >Supply Issuance</label>
				</div>
			</div>	
	</div>
	<div id="issueFieldDiv">

	</div>
	<br>

	<div id="tableDiv" style="width: 1000px;">
		<div name="rowName" class="tableRow" style="background-color: #49b0fc;">
			<b>
				<label class="rowData">User ID</label>
				<label class="rowData" style="width: 200px;">Item Name</label>
				<label class="rowData">Qty</label>
				<label class="rowData">Requested By</label>
				<label class="rowData" style="width: 150px;">Department Name</label>
				<label class="rowData">Issue Date</label>
				<label class="rowData">Last Updated By</label>
				<label class="rowData">Last Update</label>
			</b>
		</div>
		<div id="tableDataDiv">
		
		</div>
	</div>
</div>


</body>
</html>


<script type="text/javascript">

//var tempQuant = 0; 
//var tempQuantFinal; 
//var curr_id;
loadField();
loadTable();

function loadTable(){
	new Ajax.Request("${pageContext.request.contextPath}/issuance", {
		method : "get",
		parameters : {
			action : "loadTable",
		},
		onComplete : function(response){
			var res = response.responseText;
				$("tableDataDiv").update(res);
		}
	});			
}

function loadField(){
	new Ajax.Request("${pageContext.request.contextPath}/issuance", {
		method : "get",
		parameters : {
			action : "loadField",
		},
		onComplete : function(response){
			var res = response.responseText;
				$("issueFieldDiv").update(res);
		}
	});			
}


</script>
