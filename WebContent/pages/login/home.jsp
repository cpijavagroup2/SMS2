<html>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
	<div id="homeDiv">	
		<div id="contentDiv" align="center">
			<table>
				<tr id="tr1">
					<td>
					<div id="div1" class="maintenanceDiv" align="right">
						<img id="imgUserMain" title="User Maintenance" class="userMImg"
							alt="User Maintenance"
							src="${pageContext.request.contextPath}/images/user.png"><br>
							<h4 style="text-align: center; margin: 1px 2px 1px 2px; color: #949494;">User Maintenance</h4>
					</div>
					</td>
					<td>
					<div id="div2" class="maintenanceDiv">
						<img id="imgSuppMain" title="Supplies Maintenance"  class="userMImg" 
							 alt="User Maintenance" src="${pageContext.request.contextPath}/images/supmain.png"><br>
							<h4 style="text-align: center; margin: 1px 2px 1px 2px; color: #949494;">Supplies Maintenance</h4>
					</div>	
					</td>
				</tr>	
				<tr>
					<td>	
					<div id="div3" class="maintenanceDiv">
						<img id="imgSuppIss" title="Supplies Issuance" class="userMImg" 
						alt="User Maintenance" src="${pageContext.request.contextPath}/images/issuance2.png"><br>
						<h4 style="text-align: center; margin: 1px 2px 1px 2px; color: #949494;">Supplies Issuance</h4>
					</div>	
					</td>	
					<td>
					<div id="div4" class="maintenanceDiv">
						<img id="imgSuppStck" title="Supplies Stocks" class="userMImg" 
						alt="User Maintenance" src="${pageContext.request.contextPath}/images/stock.png"><br>
						<h4 style="text-align: center; margin: 1px 2px 1px 2px; color: #949494;">Supplies Stocks</h4>
					</div>					
					</td>	
				</tr>
			</table>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
try{
	
	if('${accessLevel}' != "A"){
		$("tr1").style.display = "none";
		$("div1").style.display = "none";
		$("div2").style.display = "none";
	}
	
	function goToUserMaintenance(){
		
		new Ajax.Request("${pageContext.request.contextPath}/userserv",{
			method : "post",
			parameters : {
				action : "userMain"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("imgUserMain").observe("click", goToUserMaintenance);
	
	function goToSuppliesMaintenance(){
		$("lblPage").innerHTML = "SUPPLIES MAINTENANCE";
		
		new Ajax.Request("${pageContext.request.contextPath}/supply",{
			method : "post",
			parameters : {
				action : "gotoSupplyListPage"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("imgSuppMain").observe("click", goToSuppliesMaintenance);
	
	function goToSuppliesIssuance(){
		new Ajax.Request("${pageContext.request.contextPath}/issuance",{
			method : "post",
			parameters : {
				action : "issuance"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("imgSuppIss").observe("click", goToSuppliesIssuance);

	function goToSuppliesStocks(){
		new Ajax.Request("${pageContext.request.contextPath}/stock",{
			method : "get",
			parameters : {
				action : "load"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("imgSuppStck").observe("click", goToSuppliesStocks);
	
}catch (e) {
	alert("Error in Home: "+e);
}
</script>