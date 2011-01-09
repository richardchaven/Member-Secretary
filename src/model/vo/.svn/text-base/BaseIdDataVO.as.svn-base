package model.vo
{
	import model.data.DataServices;
	
	import mx.rpc.events.ResultEvent;
	

	public class BaseIdDataVO extends BaseDataVO
	{
		public function get id() : uint
		{
			return _id
		}
		private var _id : uint;

		override public function loadData(aData : Object) : void
		{
			_id = aData['ID'];
		}

		override public function toString() : String
		{
			return "[" + this.classOnlyName() + ": " + this.id.toString() + "]";
		}
		
		override protected function prepareNewInstance() : void
		{
			DataServices.getNextId(this.tableName, setId);
		}
		
		private function setId(event : ResultEvent) : void
		{
			_id = int(event.result);	
		}
	}
}