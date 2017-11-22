package com.entity;

public class Supply {

		private int supplyId;
		private String supplyTypeId;
		private String itemName;
		private String itemUnit;
		private String obsoleteTag;
		private String location;
		private int reorderLevel;
		private int actualCount;
		private String remarks;
		private String entryDate;
		private String lastUpdateBy;
		public int getReorderLevel() {
			return reorderLevel;
		}

		public void setReorderLevel(int reorderLevel) {
			this.reorderLevel = reorderLevel;
		}
		private String lastUpdate;
		private int supplytypeId;
		private String supplyTypeName;
		
		public int getSupplytypeId() {
			return supplytypeId;
		}

		public void setSupplytypeId(int supplytypeId) {
			this.supplytypeId = supplytypeId;
		}

		public String getSupplyTypeName() {
			return supplyTypeName;
		}

		public void setSupplyTypeName(String supplyTypeName) {
			this.supplyTypeName = supplyTypeName;
		}

		public void setSupplyTypeId(String supplyTypeId) {
			this.supplyTypeId = supplyTypeId;
		}
		
		public String getSupplyTypeId() {
			return supplyTypeId;
		}
		
		public int getSupplyId() {
			return supplyId;
		}
		public void setSupplyId(int supplyId) {
			this.supplyId = supplyId;
		}
		
		public String getItemName() {
			return itemName;
		}
		public void setItemName(String itemName) {
			this.itemName = itemName;
		}
		public String getItemUnit() {
			return itemUnit;
		}
		public void setItemUnit(String itemUnit) {
			this.itemUnit = itemUnit;
		}
		public String getObsoleteTag() {
			return obsoleteTag;
		}
		public void setObsoleteTag(String obsoleteTag) {
			this.obsoleteTag = obsoleteTag;
		}
		public String getLocation() {
			return location;
		}
		public void setLocation(String location) {
			this.location = location;
		}
		public int getActualCount() {
			return actualCount;
		}
		public void setActualCount(int actualCount) {
			this.actualCount = actualCount;
		}
		public String getRemarks() {
			return remarks;
		}
		public void setRemarks(String remarks) {
			this.remarks = remarks;
		}
		public String getEntryDate() {
			return entryDate;
		}
		public void setEntryDate(String entryDate) {
			this.entryDate = entryDate;
		}
		public String getLastUpdateBy() {
			return lastUpdateBy;
		}
		public void setLastUpdateBy(String lastUpdateBy) {
			this.lastUpdateBy = lastUpdateBy;
		}
		public String getLastUpdate() {
			return lastUpdate;
		}
		public void setLastUpdate(String lastUpdate) {
			this.lastUpdate = lastUpdate;
		}
}