package model.vo
{
	public class PersonRelationshipTypeVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "person_relationship_types";			
		}
				
		public function get automaticReciprocalRelationshipTypeId() : uint  
  		{
  			if (_automaticReciprocalRelationshipType != null)
  				return _automaticReciprocalRelationshipType.id;
  			else 
  				return _automaticReciprocalRelationshipTypeId; 
  		}
  		public function set automaticReciprocalRelationshipTypeId(value : uint) : void  
  		{ 
  			if (this.automaticReciprocalRelationshipTypeId != value)
  			{
  				_automaticReciprocalRelationshipTypeId = value;
  				_automaticReciprocalRelationshipType = null;
  			} 
  		} 
  
  		public function get automaticReciprocalRelationship() : PersonRelationshipTypeVO 
  		{ 
  			if ((_automaticReciprocalRelationshipType == null) && (_automaticReciprocalRelationshipTypeId != 0))
  			{
  				_automaticReciprocalRelationshipType = 
  						this.parentCollection.findDataObject('Person Relationship Type', _automaticReciprocalRelationshipTypeId) as PersonRelationshipTypeVO;
  			}

  			return _automaticReciprocalRelationshipType;
  		}  
  		public function set automaticReciprocalRelationship(value : PersonRelationshipTypeVO) : void  
  		{ 
  			if (_automaticReciprocalRelationshipType != value)
  			{ 
  				_automaticReciprocalRelationshipType = value;
  				_automaticReciprocalRelationshipTypeId = 0;
  			} 
  		} 
		private var _automaticReciprocalRelationshipTypeId : uint;
  		private var _automaticReciprocalRelationshipType : PersonRelationshipTypeVO;
    
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);
			
			_automaticReciprocalRelationshipTypeId = aData['Automatic Reciprocal Relationship Type ID'];
		}
	}
}