<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
	<div style="  height: 210px; overflow-y: scroll; overflow-x: auto;">
		<c:forEach var="a" items ="${allList}">
			<div class="tableRow" name="rowName" >
				<label class="rowData"><a href="javascript: void(0)"><c:out value="${a.issueId}"></c:out></a></label>
				<label class="rowData" style="width: 200px;"><c:out value="${a.itemName}"></c:out></label>
				<label hidden="yes" class="rowData"><c:out value="${a.supplyId}" ></c:out></label>
				<label class="rowData"><c:out value="${a.quantity}"></c:out></label>
				<label class="rowData"><c:out value="${a.requestedBy}"></c:out></label>
				<label class="rowData" style="width: 150px;"><c:out value="${a.deptName}"></c:out></label>
				<label hidden="yes" class="rowData" style="width: 150px;"><c:out value="${a.deptId}"></c:out></label>
				<label class="rowData"><fmt:formatDate value="${a.issueDate}" pattern="MM/dd/yyyy" var="newIssuedatevar" /></label>
				<label class="rowData"><c:out value="${newIssuedatevar}"></c:out></label>
				<label class="rowData"><c:out value="${a.lastUpdatedBy}"></c:out></label>
				<label class="rowData"><fmt:formatDate value="${a.lastUpdate}" pattern="MM/dd/yyyy" var="newlastUpdatevar" /></label>
				<label class="rowData"><c:out value="${newlastUpdatevar}"></c:out></label>
			</div>		
		</c:forEach>
	</div>
</body>
</html>
<script>

$$("a").each(function(a){
	a.observe("click", function(){			
		curr_id =a.up(1).down(1).innerHTML;
	//	alert("current id" +curr_id);
		$("txtItemSelect").value = a.up(1).down(3).innerHTML;
	//	$("txtItemSelect").disabled = false;
		$("txtQuantity").value = a.up(1).down(4).innerHTML;  
		$("txtQuantity").disabled = false;
		tempQuant=0;
		tempQuant = a.up(1).down(4).innerHTML; 
		tempQuantFinal=parseInt(tempQuant);
		$("txtRequestedBy").value = a.up(1).down(5).innerHTML; 
		$("txtRequestedBy").disabled = false;
		$("txtDeptSelect").value = a.up(1).down(7).innerHTML; 
		$("txtDeptSelect").disabled = false;
		$("txtIssueDate").value = a.up(1).down(9).innerHTML; 
		$("txtIssueDate").disabled = false;
		$("btnUpDate").disabled = false;
		$("btnUpDate").style.background='#0080c0';
		$("btnCancel").disabled = false;
		$("btnCancel").style.background='#0080c0';
		$("btnAddIssue").disabled = true;
		$("btnAddIssue").style.background='lightblue';
		
		//alert("on click" + a.up(1).down(4).innerHTML);
		//alert("on click 2 " + tempQuant);
	});
}); 



</script>