<html>
<body>
	<div id="homeDiv">
		<div id="headerDiv">
			<div class="logoutDiv"> <label id="lblLogout"> logout</label> </div>
			<div class="user">Hi ${user}</div>
		</div>
		<div align="center">
			<div class="maintenanceDiv" align="right">
				<img class="userMImg" alt="User Maintenance" src="${pageContext.request.contextPath}/images/userMaintenance.ico">
			</div>		
			<div class="maintenanceDiv">
				<img class="userMImg" alt="User Maintenance" src="${pageContext.request.contextPath}/images/supplies.ico">
			</div>			
			<div class="maintenanceDiv">
				<img class="userMImg" alt="User Maintenance" src="${pageContext.request.contextPath}/images/issuance.ico">
			</div>		
			<div class="maintenanceDiv">
				<img class="userMImg" alt="User Maintenance" src="${pageContext.request.contextPath}/images/stocks.ico">
			</div>
		</div>
	</div>
</body>
</html>
<script type="text/javascript">
try{
	
	function logout(){
		new Ajax.Request("${pageContext.request.contextPath}/sms",{
			method : "post",
			parameters : {
				action : "logout"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("lblLogout").observe("click", function(){
		logout();
	});
	
}catch (e) {
	alert("Error in Home: "+e);
}
</script>