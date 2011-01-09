package model.vo
{
	import model.vo.BaseIdDataVO;
	import model.vo.EventTypeVO;

	public class InventoryTypeVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "inventory_types";			
		}
				
  		public var baseCost : Number;
  		public var basePrice : Number;
  
  		public function get entryEventTypeId() : uint  
  		{ 
  			if (_entryEventType != null)
  				return _entryEventType.id;
  			else
  				return _entryEventTypeId; 
  		}
  		public function set entryEventTypeId(value : uint) : void  
  		{ 
			if(entryEventTypeId != value)
			{
  				_entryEventTypeId = value;
  				_entryEventType = null;  
  			} 
  		} 
  		public function get entryEventType() : EventTypeVO  
  		{
			if ((_entryEventType == null) && (_entryEventTypeId != 0))
				_entryEventType = this.parentCollection.findDataObject('Event Type', _entryEventTypeId) as EventTypeVO;

  			return _entryEventType; 
  		}
  		public function set entryEventType(value : EventTypeVO) : void  
  		{ 
			if(entryEventType != value)
			{
  				_entryEventType = value;
  				_entryEventTypeId = 0;  
  			} 
  		} 
  		private var _entryEventTypeId : uint = 0;
  		private var _entryEventType : EventTypeVO;
  
  		public function get guestEntryEventTypeId() : uint  
  		{
  			if (_guestEntryEventType != null)
  				return _guestEntryEventType.id;
  			else 
  				return _guestEntryEventTypeId; 
  		}
  		public function set guestEntryEventTypeId(value : uint) : void  
  		{ 
  			if (guestEntryEventTypeId != value)
  			{
  				_guestEntryEventTypeId = value;
  				_guestEntryEventType = null;
  			} 
  		} 
  
  		public function get guestEntryEventType() : EventTypeVO 
  		{
			if ((_guestEntryEventType == null) && (_guestEntryEventTypeId != 0))
				_guestEntryEventType = this.parentCollection.findDataObject('Event Type', _guestEntryEventTypeId) as EventTypeVO;

  			return _guestEntryEventType; 
  		}  
  		public function set guestEntryEventType(value : EventTypeVO) : void  
  		{ 
  			if (_guestEntryEventType != value)
  			{ 
  				_guestEntryEventType = value;
  				_guestEntryEventTypeId = 0;
  			} 
  		} 
  		private var _guestEntryEventTypeId : uint;
  		private var _guestEntryEventType : EventTypeVO;
  
  		public var defaultExpireDays : uint;
  		public var notes : String;
  
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);
			
			this.baseCost = aData['Base Cost'];		
			this.basePrice = aData['Base Price'];
			this.entryEventTypeId = aData['Entry Event Type ID'];
			this.guestEntryEventTypeId = aData['Guest Entry Event Type ID'];
			this.defaultExpireDays = aData['Default Expire Days'];
			this.notes = aData['Notes'];
		}
	}
}