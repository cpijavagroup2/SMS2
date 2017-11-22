<html>
<head>
	<title>Add New User</title>
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
		<h3>User Maintenance</h3>
		<table>
			<tr>
				<td class="tdIss">User ID<div class="red" style="display: inline;"> *</div></td>
				<td><input type="text" id="txtUserID" /></td>
				<td></td>
				<td></td>
				<td></td>
			</tr>
			<tr>
				<td class="tdIss">Password<div class="red" style="display: inline;"> *</div></td>
				<td><input type="password" id="txtPassword" disabled/></td>
				<td></td>
				<td></td>
				<td><input type="button" class="button" id="btnSave" value="Save" /></td>
			</tr>
			<tr>
				<td class="tdIss">First Name</td>
				<td><input type="text" id="txtFirstName" /></td>
				<td></td>
				<td></td>
				<td><input type="button" class="button" id="btnCancel" value="Cancel" /></td>
			</tr>
			<tr>
				<td class="tdIss">Last Name</td>
				<td><input type="text" id="txtLastName" /></td>
			</tr>
			<tr>
				<td class="tdIss">Middle Initial</td>
				<td><input type="text" id="txtMiddleName" /></td>
			</tr>
			<tr>
				<td class="tdIss">Email Address</td>
				<td><input type="email" id="txtEmail" /></td>
			</tr>
			<tr>
				<td class="tdIss">Active Tag</td>
				<td>
					<input type="radio" id="txtActive" name="activeTag" value="Y" />Yes
					<input type="radio" id="txtActive" name="activeTag" value="N" checked/>No
				</td>
			</tr>
			<tr>
				<td class="tdIss">Access Level</td>
				<td>
					<select id="txtAccess">
				 		<option value="A">Admin</option>
				  		<option value="U">User</option>
				 	</select> 
				</td>
			</tr>
		</table>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
try{
	function saveNewUser(){
		if($F("txtUserID") != null &&
		   $F("txtFirstName") != null &&
		   $F("txtLastName") != null &&
		   $F("txtMiddleName") != null &&
		   $F("txtEmail") != null &&
		   $F("txtActive") != null &&
		   $F("txtAccess") != null){
			new Ajax.Request("${pageContext.request.contextPath}/userserv", {
				method : "POST",
				parameters : {
					action : "saveNewUser",
					username : $F("txtUserID"),
					password : $F("txtUserID"), //password for new users will be the same as the User ID by default 
					firstname: $F("txtFirstName"),
					lastname : $F("txtLastName"),
					middlename : $F("txtMiddleName"),
					email : $F("txtEmail"),
					activetag : $F("txtActive"),
					accesslevel : $F("txtAccess")
				},
				onComplete : function(response){
					alert("User added.");
				}
			});
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
	
	$("btnSave").observe("click", saveNewUser);
	$("btnCancel").observe("click", cancel);
}catch(e){
	alert("addnewuser.jsp" + e);
}
</script>