package model.vo
{
	public class LocationVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "locations";			
		}
				
		public var maximumCapacity : uint;
		
		public var privateNotes : String;
		
		public var publicNotes : String;
		
		public var url : String;
		
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);			
			
			this.maximumCapacity = aData['Maximum Capacity'];	
			this.privateNotes = aData['Private Notes'];	
			this.publicNotes = aData['Public Notes'];	
			this.url = aData['URL'];	
		}
	}
}