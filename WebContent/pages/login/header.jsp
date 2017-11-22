<html>
<body>
<div id="headerDiv">
			<div class="logoutDiv"> <img id="imgLogout" title="logout" src="${pageContext.request.contextPath}/images/logout2.png"> </div>			
			<div class="logoutDiv"> <img id="imgHome" title="home" src="${pageContext.request.contextPath}/images/home2.png"></div>
			<div class="user">Hi ${user}</div>
			<div id="titleDiv">
				Supplies Management System
			</div>
			<div id="pageDiv">
			<label id="lblPage">HOME</label>
			</div>
</div>
</body>
</html>
<script type="text/javascript">
try{
	$("lblPage").innerHTML = '${module}';
	
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
	
	$("imgLogout").observe("click", function(){
		logout();
	});
	
	
	function home(){	
		
		new Ajax.Request("${pageContext.request.contextPath}/sms",{
			method : "post",
			parameters : {
				action : "home"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	$("imgHome").observe("click", home);
}catch (e) {
	alert("Error in header: "+e);
}
</script>