<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<title>Add New Supplies</title>
</head>
<header>
<jsp:include page="../login/header.jsp"/>
</header>
<body>
	
	<div class="bodyhead">
			<div class="bodyhead2">
				<div class="bodyhead3"> 
				<img class="bodyheaderpics" alt="MenuHeaderPics" src="${pageContext.request.contextPath}/images/${MenuPic}">
				</div>
				<div class="bodyhead4">
				<label class="bodyheaderfont">${MenuName}</label>
				</div>
			</div>	
	</div>

	<div id="mainContents" style="width: 980px; margin-left: 185px">
	
		<div style="width: 980px; height: 55px; background-color: rgb(242,242,242); border : 1px solid rgb(128,128,128); position: relative; " >
			<div style="width: 980px; height: 25px;margin-top: 15px; margin-bottom: 15px; position: absolute;" >
				<label class="bodyaddformfont">Add new record</label>
			</div>
		</div>
	
	
		<div class="bodyaddform" id="bodyaddform">
			<br>
			<div class="div1bodyaddform">
				<label class="bodyeditformfont" style=" margin-left: 30px;">Supply Type </label>
  					<select id="bodyselecttab" class="bodyselecttab">
  						<c:forEach var="u" items="${SupplyTypeNameList}">
  							<option value='${u.supplytypeId}'>${u.supplyTypeName}</option>
  						</c:forEach>
  					</select>
			<br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Item Name </label>
				<input placeholder="Required Field" class="bodytextfields" type="text" id="txtItemName" style="margin-left: 38px; width: 300px" />
			<br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Item Unit </label>					
				<input placeholder="Required Field" class="bodytextfields" type="text" id="txtItemUnit" style="margin-left: 52px; width: 300px"  /><br>
					<label class="bodyeditformfont" style=" margin-left: 30px;">Obsolete Tag </label>
						<input style="font-family:Helvetica; font-size:12px; margin-left: 23px" type="radio" name="obsoleteTag" value="yes" id="obsoleteTagYes" />Yes
  						<input style="font-family:Helvetica; font-size:12px; margin-left: 15px" type="radio" name="obsoleteTag" value="no" id="obsoleteTagNo" checked/>No<br>
		
				<label class="bodyeditformfont" style=" margin-left: 30px;">Location </label>
					<input  class="bodytextfields" type="text" id="txtLocation" style="margin-left: 53px; width: 300px" /><br>
			</div>
		
			<div class="div2bodyaddform" >
				<label class="bodyeditformfont" style=" margin-left: 30px;">Entry Date</label>
					<input disabled class="bodytextfields" type="text" id="enteredDate" style="margin-left: 45px; width: 300px" value='${DateNow}'><br>
				<label class="bodyeditformfont" style=" margin-left: 30px;">Reorder Level</label>
					<input placeholder="Required" class="bodytextfields" type="text" id="reOrderLevel" style="margin-left: 23px; width: 100px"  /> 
				<label class="bodyeditformfont">Actual Count</label>
					<input placeholder="Required" class="bodytextfields"  type="text" id="actualCount" style="margin-left: 10px; width: 80px" /><br>
					<label class="bodyeditformfont" style=" margin-left: 30px;">Remarks</label>
				<textarea class="bodytextfields" id="remarks" style="margin-left: 14px;max-width:350px;max-height:50px;" ></textarea>
			</div>
			
			<br>
			<button class="bodyaddsavebtn" id="clicktosavebtn">
				Save
			</button>	
			<button class="bodyaddcancelbtn" id="clicktocancelbtn">
				Cancel
			</button>	
			
		</div>
		
	</div>

</body>
<script type="text/javascript" >

try {
	
	var supplyData = [];
	
	<c:forEach var="u" items="${supplyList}">
		supplyData.push('${u.supplyId}');
	</c:forEach>

	for (i=0; i<=supplyData.length - 1;i++){
	    if (supplyData[i]>supplyData.length - 1) {
	        var largest=supplyData[i];
	    }
	}
	
	var supplyID = parseInt(largest) + 1;	
	
	function gotoSupplyListPage(){
		new Ajax.Request("${pageContext.request.contextPath}/supply", {
			method : "post",	
			parameters : {
				action : "gotoSupplyListPage"
			},
			onComplete : function(response){
				var res = response.responseText;
				$("mainDiv").update(res);
			}
		});
	}
	
	function addSupply(){
		
		var obsolete;
		if ($('obsoleteTagYes').checked){
			obsolete  = 'Y';
		} else if ($('obsoleteTagNo').checked) {
			obsolete  = 'N';
		}
		
		new Ajax.Request("${pageContext.request.contextPath}/supply", {
			method : "post",
			parameters : {
				action : "saveSupply",
				supplyId : supplyID,
				supplyTypeId : $("bodyselecttab").value,
				itemName : $("txtItemName").value,
				itemUnit : $("txtItemUnit").value,
				obsoleteTag : obsolete,
				location : $("txtLocation").value,
				reorderLevel : $("reOrderLevel").value, 
				actualCount : $("actualCount").value,
				remarks : $("remarks").value,
				dateAdded : $("enteredDate").value,
				lastUser : 'etcarino',
				lastUpdate : $("enteredDate").value
			},
			onComplete : function(response){
				var res = response.responseText;
				$("mainDiv").update(res);
			
			}
		});
	}

	function validate(){
		
		
		if ($("txtItemName").value == "" ||  $("txtItemUnit").value == "" || $("reOrderLevel").value =="" || $("actualCount").value ==""){
			alert("Cannot insert null value to required fields!");
			if (isNaN($F("reOrderLevel"))){
				alert("Reorder Level Input is invalid!");
				$("reOrderLevel").clear();
			} 
			if (isNaN($F("actualCount"))){
				alert("Actual Count Input is invalid ");
				$("actualCount").clear();
			}
		} else {
			
			if (isNaN($F("reOrderLevel"))){
				alert("Reorder Level Input is invalid!");
				$("reOrderLevel").clear();
			} else if (isNaN($F("actualCount"))){
				alert("Actual Count Input is invalid ");
				$("actualCount").clear();
			}else {
				addSupply();
			}
			 
			
		}
	
	}
	
	$("clicktocancelbtn").observe("click", gotoSupplyListPage);
	$("clicktosavebtn").observe("click", validate);
	
}catch(e){  
	alert("Error!");
}

</script>



</html>