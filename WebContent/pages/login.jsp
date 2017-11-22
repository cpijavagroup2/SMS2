<html>
<head>
<link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
</head>
<body>
<div id="mainDiv">
</div>
</body>
</html>
<script>
try{
	load();
	function load(){
		new Ajax.Request("${pageContext.request.contextPath}/sms", {
			method : "GET",
			parameters : {
				action : "load",
			},
			onComplete : function(response){
				var res = response.responseText;
					$("mainDiv").update(res);
			}
		});
	}
} catch (e){
	alert("ERROR!")
}
</script>