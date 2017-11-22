<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<body>
		<table>
			<tr>
				<td class="tdIss">Item Name:</td>
				<td class="tdIss">
					<select class="input" id="txtItemSelect" name ="PName" disabled="disabled">
						<option value="${selected}" selected>${selected}</option> 
						<c:forEach var ="u" items = "${itemList}" >	
							 <c:if test="${u != selected}"> 
				       			<option value="${u.supplyId}">${u.itemName}</option>	    			
				        	</c:if> 	        	
						</c:forEach>
					</select>
				</td><td class="tdIss"></td>
				<td class="tdIss"><input type="button" class="button" id="btnAddIssue" value ="Issue Request"/></td>
			</tr>		
					<c:forEach var ="u" items = "${itemList}" >	
			   			<input type="hidden" id="${u.supplyId}" class="itemList" value="${u.itemCountCurrent}"/>
					</c:forEach>	
			<tr>
				<td class="tdIss">Quantity:</td>
				<td class="tdIss"><input class="input" type="text" id="txtQuantity" disabled="disabled"/></td><td class="tdIss"></td>
				<td class="tdIss"><input type="button" class="button" id="btnUpDate" disabled="disabled" style="background-color: lightblue;"  value ="Save"/></td>			
			</tr>
			<tr>
				<td class="tdIss">Requested By:</td>
				<td class="tdIss"><input class="input" type="text" id="txtRequestedBy" disabled="disabled"/></td>
				<td></td>
				<td class="tdIss"><input type="button" class="button" disabled="disabled" id="btnCancel" style="background-color: lightblue;" value ="Cancel"/></td>			
			</tr>
			<tr>
				<td class="tdIss">Department Name:</td>
				<td class="tdIss">
					<select class="input" id="txtDeptSelect" name ="DeptName" disabled="disabled">
						<option value="${selected}" selected>${selected}</option>
						<c:forEach var ="d" items = "${deptList}" >	
							<c:if test="${d != selected}">
				        		<option value="${d.deptId}">${d.deptName}</option>
				        	</c:if>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td class="tdIss">Issue Date:</td>
				<td class="tdIss"><input class="input" type="text" id="txtIssueDate" disabled="disabled"/></td>
			</tr>
			<tr>
				<td class="label trSearch" style="text-align: right; height: 70px">Search <img id="imgSearch" src="${pageContext.request.contextPath}/images/mg.png"></td>
				<td colspan="2" class="trSearch" style="height: 70px"><input type="text" class="fields" id="txtSearch"></td>
			</tr>
		</table>
</body>
</html>
<script type="text/javascript">

function searchStock(){
	 new Ajax.Request("${pageContext.request.contextPath}/issuance", {
		method : "POST",
		parameters : {
			action : "searchStock",
			searchInput : $F("txtSearch")
		},	
		onComplete : function(response){
			var res = response.responseText;
				$("tableDataDiv").update(res);
		}
	}); 
}

$("txtSearch").observe("keyup",searchStock);

$("btnAddIssue").observe("click", function(){
	addissuepage();		
});

function addissuepage(){
	
	new Ajax.Request("${pageContext.request.contextPath}/issuance", {
		method : "POST",
		parameters : {
			action : "addpage"
		},
		onComplete : function(response){
			$("mainDiv").update(response.responseText);
		}
	});		
		
}


function checker(){
	var v_iteme = $('txtItemSelect').value;
	var v_quantity = $('txtQuantity').value;
	var v_request = $('txtRequestedBy').value;
	var v_dept = $('txtDeptSelect').value;
	var v_issue = $('txtIssueDate').value;
	
	var vCheck = true;
	
	if(v_iteme =="" ||v_quantity ==""||v_request ==""
			||v_dept =="" ||v_issue =="")
		{
		vCheck = false;
		alert("Please enter required fields.");
		}
	return vCheck;
}

function checkQuantity(){
	
	var check = true;
	var letterNumber = /^[0-9]+$/; 
	
	//alert("temp "+tempQuant);
	
$$(".itemList").each(function(e){
	if(e.id == $F("txtItemSelect") ){		
				if ($F("txtQuantity").match (letterNumber) )
					{
					var v_quantity = $F("txtQuantity");
					v_quantity=parseInt(v_quantity);
					v_value = parseInt(e.value);
					//alert("v_value "+e.value);
					//alert("tempQuant "+tempQuant);
					tempQuantFinal = parseInt(tempQuant)+v_value;
					//alert("tempQuantFinal "+tempQuantFinal);
				//	alert(e.value+" "+v_quantity);
						if(tempQuantFinal < v_quantity){
							$$("select#txtItemSelect option").each(function(z){			
								if(e.id ==z.value){
									alert(z.innerHTML+" only have "+tempQuantFinal+" pieces in stock which is below the requested number of "+v_quantity+".");
									check = false;
								}
							});
							//check = false;
						}
						else if(tempQuantFinal >= v_quantity && v_quantity >0){																			
							check = true;
						}
						else {
							alert ("You cannot order Zero");
							check = false;
						}
					}
				else{
					alert("Numbers Only for Quantity Please");
					check = false;
					}
				}
		
	});
	return check;
}



function clearRecord() {
	$('txtItemSelect').value = "";
	$('txtQuantity').value = "";
	$('txtRequestedBy').value = "";
	$('txtDeptSelect').value = "";
	$('txtIssueDate').value = "";	
}


 $("btnCancel").observe("click", function(){
		clearRecord();	
//		alert("2");
		$("txtItemSelect").disabled = true;
		$("txtQuantity").disabled = true;
		$("txtRequestedBy").disabled = true;
		$("txtDeptSelect").disabled = true;
		$("txtIssueDate").disabled = true;
		$("btnUpDate").disabled = true;
		$("btnUpDate").style.background='lightblue';
		$("btnCancel").disabled = true;
		$("btnCancel").style.background='lightblue';
		$("btnAddIssue").disabled = false;
		$("btnAddIssue").style.background='#0080c0';
			});

function updateIssue(){
	
	new Ajax.Request("${pageContext.request.contextPath}/issuance",{
		method : "post",
		parameters : {
			action : "updateIssue",
			itemName: $F("txtItemSelect"), //supply id
			itemQuantity: $F("txtQuantity"),
			itemRequestedby: $F("txtRequestedBy"),
			itemDepartmentName: $F("txtDeptSelect"),
			itemIssueDate: $F("txtIssueDate"),
			itemIssueId: curr_id, //issue id
			itemTempQuant: tempQuant //quantity to add/subtract			
		},
		onComplete : function(response){
			$("tableDataDiv").update(response.responseText);			
			alert("Record Updated.");
			
			$("txtItemSelect").disabled = true;
			$("txtQuantity").disabled = true;
			$("txtRequestedBy").disabled = true;
			$("txtDeptSelect").disabled = true;
			$("txtIssueDate").disabled = true;
			$("btnUpDate").disabled = true;
			$("btnUpDate").style.background='lightblue';
			$("btnCancel").disabled = true;
			$("btnCancel").style.background='lightblue';
			$("btnAddIssue").disabled = false;
			$("btnAddIssue").style.background='#0080c0';
		}
	});
}

function checkDate(ctrl) {
	 var dateInput = ctrl
	 var goodDate = /(0[1-9]|1[012])[- \/.](0[1-9]|[12][0-9]|3[01])[- \/.](19|20)\d\d/;
	    if (dateInput.match(goodDate)){
	        return true;
	    } else {
	    	alert($F("txtIssueDate")+" is not a valid date");
	        return false;
	    }
	 }


$("btnUpDate").observe("click", function(){
	//alert(checkQuantity());
	//alert("btnUpdate: "+tempQuant);
	if(checker()){
		if (checkQuantity()){
			if (checkDate($F("txtIssueDate"))){
				updateIssue();		
				clearRecord();
				//$("btnUpDate").stopObserving("click", function(){});
			}
		}
	}
	
});


</script>