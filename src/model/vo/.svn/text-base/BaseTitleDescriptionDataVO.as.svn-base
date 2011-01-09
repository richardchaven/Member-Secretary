package model.vo
{
	public class BaseTitleDescriptionDataVO extends BaseIdDataVO
	{
		[Bindable]
  		public var title : String;  
		[Bindable]
  		public var description : String;
  
		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);
			
			this.title = aData['Title'];
			this.description = aData['Description'];
		}

		override public function toString() : String
		{
			return "[" + this.classOnlyName() + ": '" + this.title + "']";
		}

		override public function get isBlank() : Boolean
		{
			var result : Boolean = super.isBlank;
			
			if (result)
				result = (this.title == "") && (this.description == "");
				
			return result;
		}
	}
}