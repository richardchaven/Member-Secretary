package model.vo
{
	public class InterestVO extends BaseTitleDescriptionDataVO
	{
		override public function get tableName() : String
		{
			return "interests";			
		}

  		public var notes : String;
  
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);	

			this.notes = aData['Notes'];
		}
	}
}