<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<title>User Maintenance</title>
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
		<table>
			<tr>
				<td class="tdIss">User ID<div class="red" style="display: inline;"> *</div></td>
				<td><input class="user" type="text" id="txtUsername" style="background-color: #acacac; border: 1px solid black;" disabled/></td>
				<td></td>
				<td></td>
				<td><input type="button" class="button" id="btnAdd" value="Add New"/></td>
			</tr>
			<tr>
				<td class="tdIss">Password<div class="red" style="display: inline;"> *</div></td>
				<td><input class="user" type="password" id="txtPassword" style="background-color: #acacac; border: 1px solid black;" disabled/></td>
				<td><input type="button" class="button" id="btnChangePassword" value="Change Password" /></td>
				<td></td>
				<td><input type="button" class="button" id="btnSave" value="Save" /></td>
			</tr>
			<tr>
				<td class="tdIss">First Name</td>
				<td><input class="user" type="text" id="txtFirstName" /></td>
				<td></td>
				<td></td>
				<td><input type="button" class="button" id="btnCancel" value="Cancel" /></td>
			</tr>
			<tr>
				<td class="tdIss">Last Name</td>
				<td><input class="user" type="text" id="txtLastName" /></td>
			</tr>
			<tr>
				<td class="tdIss">Middle Initial</td>
				<td><input class="user" type="text" id="txtMiddleName" /></td>
			</tr>
			<tr>
				<td class="tdIss">Email Address</td>
				<td><input class="user" type="email" id="txtEmail" /></td>
			</tr>
			<tr>
				<td class="tdIss">Active Tag</td>
				<td>
					<form>
						<input type="radio" name="activeTag" id="Y" value="Y"/>Yes
						<input type="radio" name="activeTag" id="N" value="N"/>No
					</form>
				</td>
			</tr>
			<tr>
				<td class="tdIss">Access Level</td>
				<td>
					<select class="user" id="txtAccess">
				 		<option id="Admin" value="A">Admin</option>
				  		<option id="User" value="U">User</option>
				 	</select> 
				</td>
			</tr>
			<tr>
			    <td class="tdIss">
			    	<button id="btnSearch">Search</button>
			    	<span class="validity"></span></td>
				<td><input class="user" type="search" id="txtSearch" name="q" placeholder="Search User ID" required size="20" minlength="4" maxlength="8"></td>
			</tr>
		</table>
		<br>
		<div id="tableDiv" style="border: 1px solid gray; width: 1250px; margin: 2px 0px 0px 2px;">
				<div class="tableRow" name="rowName"  style="background-color: #49b0fc;">
					<b>
						<label class="rowData">User ID</label>
						<label class="rowData">First Name</label>
						<label class="rowData">Last Name</label>
						<label class="rowData">M.I.</label>
						<label class="rowData" style="width: 200px;">Email</label>
						<label class="rowData">Active Tag</label>
						<label class="rowData">Access Level</label>
						<label class="rowData">Entry Date</label>
						<label class="rowData">Last Login</label>
						<label class="rowData">Last Updated By</label>
						<label class="rowData">Last Update</label>
					</b>
				</div>
				<c:forEach var="u" items="${userList}">
					<div class="tableRow" name="rowName">
						<label class="rowData userID" title="${u.userId}">${u.userId}</label>
						<label class="rowData" title="${u.firstName}">${u.firstName}</label>
						<label class="rowData" title="${u.lastName}">${u.lastName}</label>
						<label class="rowData" title="${u.middleName}">${u.middleName}</label>
						<label class="rowData" style="width: 200px;" title="${u.email}">${u.email}</label>
						<label class="rowData" title="${u.activeTag}">${u.activeTag}</label>
						<label class="rowData" title="${u.accessLevel}">${u.accessLevel}</label>
						<label class="rowData" title="${u.entryDate}">${u.entryDate}</label>
						<label class="rowData" title="${u.lastLogin}">${u.lastLogin}</label>
						<label class="rowData" title="${u.lastUser}">${u.lastUser}</label>
						<label class="rowData" title="${u.lastUpdate}">${u.lastUpdate}</label>
					</div>
				</c:forEach>
			</div><br>	
	</div>
</body>
</html>
<script type="text/javascript">
try{
	
	$("btnChangePassword").disabled = true;
	$("btnChangePassword").style.background='lightblue';
	
	var contextPath = "${pageContext.request.contextPath}";
	
	function addUser(){
		new Ajax.Request(contextPath+"/userserv", {
			method : "POST",
			parameters : {
				action : "addUser"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);
			}
		});
	}
	function updateUser(){
		if($F("txtUsername") == ""){
			alert("Please select record to update.");
		}else{
			var tags = document.getElementsByName('activeTag');
			var tag_value;
			for(var i = 0; i < tags.length; i++){
			    if(tags[i].checked){
			    	tag_value = tags[i].value;
			    }
			}
		
			new Ajax.Request(contextPath+"/userserv", {
				method : "POST",
				parameters : {
					action : "updateUser",
					username : $F("txtUsername"),
					firstname: $F("txtFirstName"),
					lastname : $F("txtLastName"),
					middlename : $F("txtMiddleName"),
					email : $F("txtEmail"),
					activetag : tag_value,
					accesslevel : $F("txtAccess")
				},
				onComplete : function(response){
					alert("User updated.");
					$("mainDiv").update(response.responseText);
				}
			});
		}		
	}
	function changePassword(){
		new Ajax.Request(contextPath+"/userserv", {
			method : "POST",
			parameters : {
				action : "changePassword",
				username : $F("txtUsername")
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);
			}
		});
	}
	function searchUser(){
		new Ajax.Request(contextPath+"/userserv", {
			method : "POST",
			parameters : {
				action : "searchUser",
				search : $F("txtSearch")
			},
			onComplete : function(response){
				var res = response.responseText;
				
				if(res == ""){
					alert("User does not exist.");
				}else{
					$("mainDiv").update(res);
				}
			}
		});
	}
	
	$("btnAdd").observe("click", addUser);
	$("btnSave").observe("click", updateUser);
	$("btnChangePassword").observe("click", changePassword);
	$("btnSearch").observe("click", searchUser);
	$("btnCancel").observe("click", cancel);
	
	$$(".userID").each(function(e){
		e.observe("click", function(){
			$("txtUsername").value = e.innerHTML;
			$("txtFirstName").value = e.up(0).down(1).innerHTML;
			$("txtLastName").value = e.up(0).down(2).innerHTML;
			$("txtMiddleName").value = e.up(0).down(3).innerHTML;
			$("txtEmail").value = e.up(0).down(4).innerHTML;
			$(e.up(0).down(5).innerHTML).checked = true; //active tag
			$(e.up(0).down(6).innerHTML).selected = true; //access level

			new Ajax.Request(contextPath+"/userserv", {
				method : "POST",
				parameters : {
					action : "checkSession"
				},
				onComplete : function(response){
					var user = response.responseText;
					if(user.toLowerCase() != $F("txtUsername").toLowerCase()){
						$("btnChangePassword").disabled = true;
						$("btnChangePassword").style.background='lightblue';
					}else{
						$("btnChangePassword").disabled = false;
						$("btnChangePassword").style.background='#0080c0';
					}
				}
			});
		});
	});
	
	function cancel(){
		$("txtUsername").value = "";
		$("txtFirstName").value = "";
		$("txtLastName").value = "";
		$("txtMiddleName").value = "";
		$("txtEmail").value = "";
		$("btnChangePassword").disabled = true;
		$("btnChangePassword").style.background='lightblue';
	}
}catch(e){
	alert("home.jsp" + e);
}
</script>