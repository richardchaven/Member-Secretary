package model
{
	import mx.rpc.events.ResultEvent;
	
	public class LookupDataSource
	{
		private var _inventoryTypes : Array = null;
		private var _eventTypes : Array = null;
		private var _membershipRequiredEventTypes : Array = null;
		private var _membershipTypeInventoryPrice : Array = null;
		private var _membershipTypes : Array = null;
		private var _personRelationshipTypes : Array = null;
		private var _interests : Array = null;
		private var _locations : Array = null;
		private var _membershipTypeIncludedInventory : Array = null;

		protected function clear() : void
		{
			_inventoryTypes = null;	
			_eventTypes = null;
			_membershipRequiredEventTypes = null;
			_membershipTypeInventoryPrice = null;
			_membershipTypes = null;
			_personRelationshipTypes = null;
			_interests = null;
			_locations = null;
			_membershipTypeIncludedInventory = null;
		}
		
		protected function loadData() : void
		{
			var remoteData : DatabaseConnection = new DatabaseConnection();
			remoteData.addEventListener(ResultEvent.RESULT, receiveData);
			remoteData.getLookupData();
		}
		protected function receiveData(event : ResultEvent) : void
		{
			
		}
		
		public function get InventoryTypes() : Array
		{
			if (_inventoryTypes == null)
				this.loadData();
				
			return _invetoryTypes;	
		}
		public function get EventTypes() : Array
		{
			if (_eventTypes == null)
				this.loadData();
				
			return _eventTypes;	
		}
		public function get MembershipRequiredEventTypes() : Array
		{
			if (_membershipRequiredEventTypes == null)
				this.loadData();
				
			return _membershipRequiredEventTypes;	
		}
		public function get MembershipTypeInventoryPrice() : Array
		{
			if (_membershipTypeInventoryPrice == null)
				this.loadData();
				
			return _membershipTypeInventoryPrice;	
		}
		public function get MembershipTypes() : Array
		{
			if (_membershipTypes == null)
				this.loadData();
				
			return _membershipTypes;	
		}
		public function get PersonRelationshipTypes() : Array
		{
			if (_personRelationshipTypes == null)
				this.loadData();
				
			return _personRelationshipTypes;	
		}
		public function get Interests() : Array
		{
			if (_interests == null)
				this.loadData();
				
			return _interests;	
		}
		public function get Locations() : Array
		{
			if (_locations == null)
				this.loadData();
				
			return _locations;	
		}
		public function get MembershipTypeIncludedInventory() : Array
		{
			if (_membershipTypeIncludedInventory == null)
				this.loadData();
				
			return _membershipTypeIncludedInventory;	
		}
	}
}