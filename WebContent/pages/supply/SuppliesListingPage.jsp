<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
<title>Supply Home Page</title>
</head>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
<div>
	<div class="bodyhead">
		<div class="bodyhead2">
			<div class="bodyhead3"> 
				<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/${MenuPic}">
			</div>
			
			<div class="bodyhead4">
				<label class="bodyheaderfont">${MenuName}</label>
					<input placeholder="Search..." type="text" id="txtSearch" style="font-family: Helvetica; font-size: 14px; height: 30px; margin-bottom: 6px; width: 370px;border : 1px solid #ddd; border-radius: 2px;position: relative;margin-left: 140px; "/>	
					<button class="button" id="clicktoadd" style="height:30px; position: relative;">
						Add New
					</button>	
				</div>
			</div>	
	</div>
	
	<div id="mainContents" >
		<div id="tableDiv" style="width: 996px; margin-left: 185px ">
			<div name="rowName" class="tableRow" style="background-color: #49b0fc;">
				<b>
					<label class="rowData" style="width: 70px">Supply <br> ID</label>
					<label class="rowData" style="width: 80px">Supply Type</label>
					<label class="rowData" style="width:125px">Item Name</label>
					<label class="rowData" style="width:62px">Item <br> Unit</label>
					<label class="rowData" style="width:58px">Obsolete <br>Tag</label>
					<label class="rowData" style="width:150px">Location</label>
					<label class="rowData" style="width:60px">Reorder <br> Level</label>
					<label class="rowData" style="width:60px">Actual <br> Count</label>
					<label class="rowData" style="width:95px">Remarks</label>
					<label class="rowData" style="width:80px">Entry Date</label>
					<label class="rowData" style="width:70px">Last <br>Updated By</label>
					<label class="rowData" style="width:60px">Last Update </label>
				</b>
			</div>
			<div style=" height: 250px; overflow-y: scroll; overflow-x: auto;">
				<div id="maintable">
					<c:forEach var="u" items="${supplyList}">
						<div class="tableRow" name="rowName" >
							<label style="width: 70px" class="rowData" id="${u.supplyId}"><a href="javascript: void(0)"> <c:out value="${u.supplyId}"/></a></label>
							<label style="width: 80px" class="rowData" > <c:out value="${u.supplyTypeId}"/></label>
							<label style="width:125px" class="rowData" style="width:150px"><c:out value="${u.itemName}"/></label>
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
							<label class="rowData"  style="width:60px" ><c:out value="${u.reorderLevel}"/></label>
							<label class="rowData" style="width:60px" ><c:out value="${u.actualCount}"/></label>
							<label class="rowData" style="width:95px" ><c:out value="${u.remarks}"/>
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
				</div>
			</div>
		</div>
	<br>
		<div style="width: 980px; height: 55px; background-color: rgb(242,242,242); border : 1px solid rgb(128,128,128); position: relative; margin-left: 185px ;" >
			<div style="width: 980px; height: 25px;margin-top: 15px; margin-bottom: 15px; position: absolute; " >
				<label id="clicktoedit" class="bodyeditformfont">Click for the Supply Id to update records.</label>
				<label id="clicktosave" class="bodysaveformfont">Save</label> 
				<label id="separator" style="visibility: hidden;" >|</label>
				<label id="clicktocancel" class="bodycancelformfont">Cancel</label>
			</div>
		</div>
	
		<div class="bodyeditform" id="bodyeditform" style="margin-left: 185px; border-color: rgb(128,128,128)">
			<br><br><label id="errormessage" style="visibility: hidden;"><c:out value="${message}"/></label>
			<div class="div1bodyeditform">
				<label class="bodyeditformfont" style=" margin-left: 30px;">Supply Type </label>
  					<select id="bodyselecttab" class="bodyselecttab" disabled>
  						<option>${supplyType} </option>
  					</select>
			<br>
			
				<label class="bodyeditformfont" style=" margin-left: 30px;">Item Name </label>
					<input class="bodytextfields" type="text" id="txtItemName" style="margin-left: 38px; width: 300px" value="${itemName}"/>
			<br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Item Unit </label>
					<input class="bodytextfields" type="text" id="txtItemUnit" style="margin-left: 52px; width: 300px" value="${itemUnit}" /><br>
					<label class="bodyeditformfont" style=" margin-left: 30px;" >Obsolete Tag </label>
						<input style="font-family:Helvetica; font-size:12px; margin-left: 23px" type="radio" name="obsoleteTag" value="yes" id="obsoleteTagYes" />Yes
  						<input style="font-family:Helvetica; font-size:12px; margin-left: 15px" type="radio" name="obsoleteTag" value="no" id="obsoleteTagNo"/>No<br>
							
							<script type="text/javascript">
								if ('${obsoleteTag}' == 'Y'){
									$("obsoleteTagYes").checked = true;
								} else if ('${obsoleteTag}' == 'N'){
									$("obsoleteTagNo").checked = true;
								}
								if ('${validate}' == 'true'){
									alert("Record Updated!");
								} else if ('${validate}' == 'false') {
									alert( "Database Error Occured!\n" + $("errormessage").innerHTML );
								}
								if ('${validateadd}' == 'true'){
									alert("Record Added!");
								} else if ('${validateadd}' == 'false') {
									alert( "Database Error Occured!\n" + $("errormessage").innerHTML );
								}
							</script>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Location </label>
					<input  class="bodytextfields" type="text" id="txtLocation" style="margin-left: 53px; width: 300px" value="${location}" /><br>
			</div>
		
			<div class="div2bodyeditform" >
				<label class="bodyeditformfont" style=" margin-left: 30px;">Entered Date</label>
					<input disabled class="bodytextfields" type="text" id="enteredDate" style="margin-left: 28px; width: 300px" value="${enteredDate}"/><br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Reorder Level</label>
					<input class="bodytextfields" type="text" id="reOrderLevel" style="margin-left: 23px; width: 100px" value="${reorderLevel}" /> 
				<label class="bodyeditformfont" ">Actual Count</label>
					<input disabled class="bodytextfields"  type="text" id="actualCount" style="margin-left: 10px; width: 80px" value="${actualCount}" /><br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Remarks</label>
					<textarea class="bodytextfields" id="remarks" style="margin-left: 148px;max-width:350px;max-height:50px;" >${remarks}</textarea>
			</div>
		</div>
	</div>
</div>
</body>
<script type="text/javascript" >
try {
	//To get the current timestamp 
	var today = new Date().toLocaleDateString('en-GB', {
	    day : 'numeric',
	    month : 'short',
	    year : 'numeric'
	}).split(' ').join('-');
	
	//To edit records by clicking supply_id  
    $$("a").each(function(a){
    	a.observe("click", function(){
    		supplyId_CARINO = a.innerHTML;
            populateFields();
      
    	});
    	$("bodyeditform").scrollTo();
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
    
  	//Function in saving edited records
	function updateSupply(){
	
		var obsoleteTag ;
		if ($('obsoleteTagYes').checked){
			obsoleteTag  = 'Y';
		} else if ($('obsoleteTagNo').checked) {
			obsoleteTag  = 'N';
		}
		
		new Ajax.Request("${pageContext.request.contextPath}/supply", {
			method : "post",
			parameters : {
				action : "updateSupply",
				supplyid : supplyId_CARINO,
				location : $("txtLocation").value,
				itemunit : $("txtItemUnit").value,
				reorderlevel : $("reOrderLevel").value,
				remarks : $("remarks").value,
				obsoletetag : obsoleteTag,
				itemname : $("txtItemName").value,
				lastupdate : today,
				lastuser : 'etcarino'
			},
			onComplete : function(response){
				var res = response.responseText;
				$("mainDiv").update(res);
			}
		});
	}
	
	function addNewSupply(){
		new Ajax.Request("${pageContext.request.contextPath}/supply",{
			method : "post",
			parameters : {
				action : "addNewSupply"
			},
			onComplete : function(response){
				$("mainDiv").update(response.responseText);	
			}
		});
	}
	
	function searchSupply(){
		 new Ajax.Request("${pageContext.request.contextPath}/supply", {
			method : "post",
			parameters : {
				action : "searchSupply",
				searchInput : $F("txtSearch")
			},	
			onComplete : function(response){
				var res = response.responseText;
					$("maintable").update(res);
			}
		}); 
	}

	function validate(){
		if ($("txtItemName").value == "" ||  $("txtItemUnit").value == "" || $("reOrderLevel").value ==""){
			alert("Cannot insert null value to required fields!");
			if (isNaN($F("reOrderLevel"))){
				alert("Reorder Level input is invalid!");
				populateFields();
			} 
			populateFields();
		} else {
			if (isNaN($F("reOrderLevel"))){
				alert("Reorder Level input is invalid!");
				populateFields();
			} else{
				updateSupply();
			}
		}
	
	}
	
	$("txtSearch").observe("keyup",searchSupply);	

	$("clicktoadd").observe("click",addNewSupply);
  	
	$("clicktocancel").observe("click", function(){
		$("clicktosave").style.visibility = 'hidden';
		$("separator").style.visibility = 'hidden';
		$("clicktocancel").style.visibility = 'hidden';
		$("clicktoedit").innerHTML = 'Click for the Supply Id to update records.' ; 
		var e = $("bodyeditform");
       	e.style.display = 'none';	
	});
	
	$("clicktosave").observe("click",function() {
		validate();
	});
	
	
}catch(e) {
	alert("Error!");
}



</script>
</html>