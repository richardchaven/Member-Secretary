package model.vo
{
	import model.vo.BaseDataVO;

	public class EventTypeVO extends BaseIdDataVO
	{
		override public function get tableName() : String
		{
			return "event_types";			
		}
		
		public var eventClass : String;
		public var defaultBasePrice : Number;
		public var defaultDescription : String;
		public var defaultEffectivePeriod : String;
		
		public function get defaultLocationId() : uint
		{
			if (_defaultLocation != null)
				return _defaultLocation.id;
			else
				return _defaultLocationId;
		}

		public function set defaultLocationId(value : uint) : void
		{
			if (defaultLocationId != value)
			{
				_defaultLocationId = value;
				_defaultLocation = null;
			}
		}

		public function get defaultLocation() : LocationVO
		{
			if ((_defaultLocation == null) && (_defaultLocationId != 0))
				_defaultLocation = (this.parentCollection.findDataObject('Location', _defaultLocationId)) as LocationVO;

			return _defaultLocation;
		}

		public function set defaultLocation(value : LocationVO) : void
		{
			if (_defaultLocation != value)
			{
				_defaultLocation = value;
				_defaultLocationId = 0;
			}
		}
		private var _defaultLocationId : uint = 0;
		private var _defaultLocation : LocationVO = null;

		public var defaultTitle : String;

		override public function loadData(aData : Object) : void
		{
			super.loadData(aData);

			this.eventClass = aData['Class'];
			this.defaultBasePrice = aData['Default Base Price'];
			this.defaultDescription = aData['Default Description'];
			this.defaultEffectivePeriod = aData['Default Effective Period'];
			this.defaultLocationId = aData['Default Location ID'];
			this.defaultTitle = aData['Default Title'];
		}
	}
}