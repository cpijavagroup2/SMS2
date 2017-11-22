<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<script src="${pageContext.request.contextPath}/js/prototype.js"></script>
<link href="${pageContext.request.contextPath}/css/Style.css" rel="stylesheet" type="text/css" />
<head>
</head>
<body>
	<c:forEach var="u" items="${searchList}">
		<div class="tableRow" name="rowName" >
			<label style="width: 70px" class="rowData" id="${u.supplyId}"><a href="javascript: void(0)"> <c:out value="${u.supplyId}"/></a></label>
			<label style="width: 80px" class="rowData" > <c:out value="${u.supplyTypeId}"/></label>
			<label class="rowData" style="width:125px"><c:out value="${u.itemName}"/></label>
			<label style="width:62px" class="rowData" ><c:out value="${u.itemUnit}"/></label>
			<label style="width:58px" class="rowData" ><c:out value="${u.obsoleteTag}"/></label>
			<label class="rowData" style="width:150px">					
				<c:choose>
				  	<c:when test="${empty u.location}">
				        --
				    </c:when>    
				    <c:otherwise>
				        <c:out value="${u.location}"/>
				    </c:otherwise>
				</c:choose>	
			</label>
			<label class="rowData" style="width:60px" ><c:out value="${u.reorderLevel}"/></label>
			<label class="rowData" style="width:60px" ><c:out value="${u.actualCount}"/></label>
			<label class="rowData" style="width:95px"><c:out value="${u.remarks}"/>
				<c:choose>
				  	<c:when test="${empty u.remarks}">
				        --
				    </c:when>    
				    <c:otherwise>
				        <c:out value="${u.remarks}"/>
				    </c:otherwise>
				</c:choose>	
			</label>
			<label class="rowData" style="width:80px" ><c:out value="${u.entryDate}"/></label>
			<label class="rowData" style="width:70px" >
				<c:choose>
				    <c:when test="${empty u.lastUpdateBy}">
				        --
				    </c:when>    
				    <c:otherwise>
				        <c:out value="${u.lastUpdateBy}"/>
				    </c:otherwise>
				</c:choose>	
			</label>
			<label class="rowData" style="width:60px" ><c:out value="${u.lastUpdate}"/></label>
		</div>
	</c:forEach>
</body>
<script type="text/javascript" >
//To edit records by clicking supply_id  
$$("a").each(function(a){
	a.observe("click", function(){
		supplyId_CARINO = a.innerHTML;
        populateFields();
	});
}); 

//Function in getting the data on the database
function populateFields(){
	new Ajax.Request("${pageContext.request.contextPath}/supply", {
		method : "post",
		parameters : {
			action : "populatefields",
			supplyid : supplyId_CARINO
		},
		onComplete : function(response){
			var res = response.responseText;
			$("mainDiv").update(res);
			$("clicktosave").style.visibility = 'visible';
      		$("separator").style.visibility = 'visible';
      		$("clicktocancel").style.visibility = 'visible';
      		$("clicktoedit").innerHTML = 'Record Details' ; 		
      		var e = $("bodyeditform");
            e.style.display = (e.style.display == 'none') ? 'block' : 'block';      
		}
	 	});
}

</script>
</html>