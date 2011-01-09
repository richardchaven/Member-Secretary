package model.vo
{
	public class PersonTitleTypesVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "person_title_types";			
		}
		
		public var defaultPeriod : String;
		
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);
			
			this.defaultPeriod = aData['Default Period'];	
		}
	}
}