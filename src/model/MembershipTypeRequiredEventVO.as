package model
{
	import model.vo.BaseDataVO;
	import model.vo.EventTypeVO;
	import model.vo.MembershipTypeVO;

	public class MembershipTypeRequiredEventVO extends BaseDataVO
	{
		private var _eventTypeId : uint = 0;
		private var _eventType : EventTypeVO;
		public function get eventTypeID() : uint
		{
			if (_eventType != null)
				return _eventType.id;
			else
				return _eventTypeId;
		}
		public function set eventTypeID(value : uint) : void
		{
			if (this.eventTypeID != value)
			{
				_eventTypeId = value;
 				_eventType = null;
			}
		}
		public function get eventType() : EventTypeVO
		{
			if ((_eventType == null) && (_eventTypeId != 0))
				_eventType = this.parentCollection.findDataObject('Event Type', _eventTypeId) as EventTypeVO;
				
			return _eventType;
		}
		public function set eventType(value : EventTypeVO) : void
		{
			if (_eventType != value)
			{
				_eventType = value;
				_eventTypeId = 0;
			}
		}
		
		private var _membershipTypeId : uint = 0;
		private var _membershipType : MembershipTypeVO;
		public function get membershipTypeID() : uint
		{
			if (_membershipType != null)
				return _membershipType.id;
			else
				return _membershipTypeId;
		}
		public function set membershipTypeID(value : uint) : void
		{
			if (this.membershipTypeID != value)
			{
				_membershipTypeId = value;
 				_membershipType = null;
			}
		}
		public function get membershipType() : MembershipTypeVO
		{
			if ((_membershipType == null) && (_membershipTypeId != 0))
				_membershipType = this.parentCollection.findDataObject('Membership Type', _membershipTypeId) as MembershipTypeVO;
				
			return _membershipType;
		}
		public function set membershipType(value : MembershipTypeVO) : void
		{
			if (_membershipType != value)
			{
				_membershipType = value;
				_membershipTypeId = 0;
			}
		}
		
		private var _quantity : uint;
		public function get quantity() : uint { return _quantity }
		public function set quantity(value : uint) : void { _quantity = value }
		
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);
		
			_eventTypeId = aData['Event Type ID'];
			_eventType = null;	
			_membershipTypeId = aData['Membership Type ID'];
			_membershipType = null;	
			_quantity = aData['Quantity'];	
		}
	}
}