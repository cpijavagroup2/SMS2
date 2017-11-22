<html>
<head>
	<title>Change Password</title>
</head>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
<div id="mainDiv" align="center">
	<div class="bodyhead">
			<div class="bodyhead2">
				<div class="bodyhead3"> 
				<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/user.png">
				</div>
				<div class="bodyhead4" style="text-align: left;">
				<label class="bodyheaderfont" >User Maintenance</label>
				</div>
			</div>	
	</div>
	<div>
		<h3>CHANGE PASSWORD</h3>
		<table>
			<tr>
				<td class="tdIss">Current Password:</td>
				<td><input type="text" id="txtCurrentPassword" /></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdIss">New Password:</td>
				<td><input type="password" id="txtNewPassword" /></td>
				<td><input type="button" class="button" id="btnSave" value="Save"/></td>
			</tr>
			<tr>
				<td class="tdIss">Retype Password:</td>
				<td><input type="password" id="txtRetypePassword" /></td>
				<td><input type="button" class="button" id="btnCancel" value="Cancel"/></td>
			</tr>
		</table>		
	</div>
</div>
</body>
</html>
<script type="text/javascript">
try{
	function savePassword(){
		var currentpw = $F("txtCurrentPassword");
		var newpw = $F("txtNewPassword");
		var retypepw = $F("txtRetypePassword");
		
		if(currentpw != "" && newpw != "" && retypepw != ""){
			if(newpw.includes(" ")){
				alert("Password should not contain white spaces.");
			}else if(newpw.length < 8 ){
				alert("Password should be at least 8 characters.");
			}else if(newpw.length > 20 ){
				alert("Password should not exceed 20 characters.");
			}else if(newpw != retypepw){
				alert("New password & Retype password does not match.");
			}else{
				new Ajax.Request("${pageContext.request.contextPath}/userserv", {
					method : "POST",
					parameters : {
						action : "savePassword",
						currentpassword : currentpw,
						newpassword : newpw
					},
					onComplete : function(response){
						var res = response.responseText;
						
						if(res == ""){
							alert("Invalid current password.");
						}else{
							alert("Password changed successfullly.");
						}						
					}
				});
			}
		}else{
			alert("Please fill in empty fields.");
		}
	}
	function cancel(){
		new Ajax.Request("${pageContext.request.contextPath}/userserv", {
			method : "POST",
			parameters : {
				action : "cancel"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);
			}
		});
	}
	
	$("btnSave").observe("click", savePassword);
	$("btnCancel").observe("click", cancel);
}catch(e){
	alert("changepassword.jsp" + e);
}
</script>