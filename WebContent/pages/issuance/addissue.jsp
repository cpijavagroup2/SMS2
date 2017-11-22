<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
<div id="contentDiv" align="center">
	<div class="bodyhead">
			<div class="bodyhead2">
				<div class="bodyhead3"> 
				<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/issuance2.png">
				</div>
				<div class="bodyhead4" style="text-align: left;">
				<label class="bodyheaderfont" >Supply Issuance</label>
				</div>
			</div>	
	</div>
	<table>
		<tr>
			<td class="tdIss">Item Name:</td>
			<td class="tdIss">
				<select class="input" id="txtItemSelect" name ="PName">
					<option value="${selected}" selected>${selected}</option> 
					<c:forEach var ="u" items = "${itemList}" >	
						 <c:if test="${u != selected}"> 
			       			<option value="${u.supplyId}">${u.itemName}</option>	    			
			        	</c:if> 	        	
					</c:forEach>
				</select>
			</td><td class="tdIss"></td>
			<td class="tdIss"><input type="button" class="button" id="btnBack" value ="Back to Issuance"/></td>
		</tr>		
				<c:forEach var ="u" items = "${itemList}" >	
		   			<input type="hidden" id="${u.supplyId}" class="itemList" value="${u.itemCountCurrent}"/>
				</c:forEach>	
		<tr>
			<td class="tdIss">Quantity:</td>
			<td class="tdIss"><input class="input" type="text" id="txtQuantity"/></td><td class="tdIss"></td>
			<td class="tdIss"><input type="button" class="button" id="btnAdd" value ="Save"/></td>			
		</tr>
		<tr>
			<td class="tdIss">Requested By:</td>
			<td class="tdIss"><input class="input" type="text" id="txtRequestedBy"/></td>
			<td></td>
			<td class="tdIss"><input type="button" class="button" id="btnCancel" value ="Cancel"/></td>			
		</tr>
		<tr>
			<td class="tdIss">Department Name:</td>
			<td class="tdIss">
				<select class="input" id="txtDeptSelect" name ="DeptName">
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
			<td class="tdIss"><input class="input" type="text" id="txtIssueDate"/></td>
		</tr>
	</table>
</div>


</body>
</html>


<script type="text/javascript">

$("btnBack").observe("click", function(){
	backissuepage();		
});

function backissuepage(){
	
	new Ajax.Request("${pageContext.request.contextPath}/issuance", {
		method : "POST",
		parameters : {
			action : "backissue"
		},
		onComplete : function(response){
			$("mainDiv").update(response.responseText);
		}
	});		
		
}



/***************************************************/
function addIssue(){
	
	new Ajax.Request("${pageContext.request.contextPath}/issuance",{
		method : "POST",
		parameters : {
			action : "addIssue",
			itemName: $F("txtItemSelect"),
			itemQuantity: $F("txtQuantity"),
			itemRequestedby: $F("txtRequestedBy"),
			itemDepartmentName: $F("txtDeptSelect"),
			itemIssueDate: $F("txtIssueDate")
			/* userName : $F("txtUserName"),
			password : $F("txtPassword") */			
			
		},
		onComplete : function(response){
			$("mainDiv").update(response.responseText);	
			alert("Record Issued.");
		}
	});
}

$("btnAdd").observe("click", function(){
	if(checker()){
		if (checkQuantity()){
			if (checkDate($F("txtIssueDate"))){
				addIssue();
				clearRecord();
			}
		}
	}
});

$("btnCancel").observe("click", function(){
			clearRecord();			
		});

function checkQuantity(){
	
	var check = true;
	var letterNumber = /^[0-9]+$/; 
	
$$(".itemList").each(function(e){
	if(e.id == $F("txtItemSelect") ){		
				if ($F("txtQuantity").match (letterNumber) )
					{
					var v_quantity = $F("txtQuantity");
					v_quantity=parseInt(v_quantity);
					
					//alert(e.value+" "+v_quantity);
						if(e.value < v_quantity){
							$$("select#txtItemSelect option").each(function(z){			
								if(e.id ==z.value){
									alert(z.innerHTML+" only have "+e.value+" pieces in stock which is below the requested number of "+v_quantity+".");
									check = false;
								}
							});
							//check = false;
						}
						else if(e.value >= v_quantity && v_quantity >0){																			
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

function clearRecord() {
	$('txtItemSelect').value = "";
	$('txtQuantity').value = "";
	$('txtRequestedBy').value = "";
	$('txtDeptSelect').value = "Male";
	$('txtIssueDate').value = "";	
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

</script>
