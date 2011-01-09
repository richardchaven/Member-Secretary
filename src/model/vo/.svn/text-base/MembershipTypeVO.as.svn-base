package model.vo
{
	public class MembershipTypeVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "membership_types";			
		}
		
		public function get dependantOnMembershipTypeId() : uint
		{
			if (dependantOnMembershipType != null)
				return _dependantOnMembershipType.id;
			else
				return _dependantOnMembershipTypeId;
		}
		
		public function set dependantOnMembershipTypeId(value : uint) : void
		{
			if (_dependantOnMembershipTypeId != value)
			{
				_dependantOnMembershipTypeId = value;
				_dependantOnMembershipType = null;
			}	
		}	
		[Bindable]
		public function get dependantOnMembershipType() : MembershipTypeVO 
		{ 
			if ((_dependantOnMembershipType == null) && (_dependantOnMembershipTypeId != 0))
			{
				_dependantOnMembershipType = 
					(this.parentCollection.findDataObject('Member Type', _dependantOnMembershipTypeId) as MembershipTypeVO);
			}

			return _dependantOnMembershipType 
		}
		public function set dependantOnMembershipType(value : MembershipTypeVO) : void
		{
			if (_dependantOnMembershipType != value)
			{
				_dependantOnMembershipType = value;
				_dependantOnMembershipTypeId = 0;
			}
		}
		private var _dependantOnMembershipType : MembershipTypeVO;
		private var _dependantOnMembershipTypeId : uint = 0;
		
		[Bindable]	
		public var baseEventGuestPrice : Number = NUMBER_NOT_SET;
		[Bindable]	
		public var baseEventPrice : Number = NUMBER_NOT_SET;
		
		[Bindable]	
		public var baseInventoryDiscountPercent : int = INT_NOT_SET;
  				
		[Bindable]	
		public var maximumEventGuestCount : int = INT_NOT_SET;
		[Bindable]	
		public var maximumDependantMembershipsCount : int = INT_NOT_SET;
		[Bindable]	
		public var notes : String = "";
		[Bindable]	
		public var period : String = "";
		[Bindable]	
		public var price : Number = NUMBER_NOT_SET;
 
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);			
			
			this.baseEventGuestPrice = findNumberValue(aData, 'Base Event Guest Price', NUMBER_NOT_SET);	
			this.baseEventPrice = findNumberValue(aData, 'Base Event Price', NUMBER_NOT_SET);	
			this.baseInventoryDiscountPercent = findNumberValue(aData, 'Base Inventory Discount Percent', NUMBER_NOT_SET);	
			this.dependantOnMembershipTypeId = findIntValue(aData, 'Dependant On Membership Type ID', 0);
			this.maximumEventGuestCount = findIntValue(aData, 'Maximum Event Guest Count', INT_NOT_SET);	
			this.maximumDependantMembershipsCount = findIntValue(aData, 'Maximum Dependant Memberships Count', INT_NOT_SET);	
			this.notes = aData['Notes'];	
			this.period = aData['Period'];	
			this.price = aData['Price'];	
		}
		
		override public function get isBlank() : Boolean
		{
			var result : Boolean = super.isBlank;
			
			if (result)
			{
				result = (this.notes == "") && (this.period == "") && (this.price != NUMBER_NOT_SET) 
					
			}	
				
			return result;
		}
	}
}