<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
	<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
	<script src="${pageContext.request.contextPath}/js/loginjs.js"></script>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css"> 
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/home.css"> 
</head>
<body>
<div id="mainDiv">
	<div id="loginDiv" align="center">
		<fieldset id="fsLogin">
			<table>
				<tr>
					<td>Username:</td>
					<td><input type="text" id="txtUsername"></td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="password" id="txtPassword"></td>
				</tr>
				<tr>
					<td></td>
					<td><div id="lblMessage">${message}</div></td>
				</tr>
			</table>
			
			<br><br>
			<input type="button" id="btnLogin" value="Login">
		</fieldset>
	</div>
</div>
</body>
</html>
<script type="text/javascript">
try{
	var contextPath = "${pageContext.request.contextPath}";

	function login(){
		new Ajax.Request(contextPath+"/sms",{
			method : "post",
			parameters : {
				userName : $F("txtUsername"),
				password : $F("txtPassword"),
				action : "login"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);
			}
		});
	}	

	$("btnLogin").observe("click",function(){
		login();
	});	
	
	function checkSession(){
		new Ajax.Request(contextPath+"/sms",{
			method : "post",
			parameters : {
				action : "checkSession"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});		
	}	
	
	if('${chkSession}' != "Y"){
		checkSession();
	}
}catch(e){
	alert("Error in Login: "+ e);
}

</script>