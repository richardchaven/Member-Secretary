package model.vo
{
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import model.data.DataTransferObject;
	
	import mx.events.PropertyChangeEvent;
	
	public class BaseDataVO extends EventDispatcher
	{
		public function BaseDataVO(anUpdateObject : DataTransferObject = null)
		{
			super();
			
			this.dataUpdateObject = anUpdateObject;
			this.addEventListener(PropertyChangeEvent.PROPERTY_CHANGE, onPropertyChange);		//	every [Bindable] property
		}
		
		public function get isModified() : Boolean
		{
			return _isModified;
		}
		private var _isModified : Boolean = false;

		protected function onPropertyChange(event : PropertyChangeEvent) : void
		{
			_isModified = true;
			this.dataUpdateObject.updateFor(this);			
		}
		
		protected function classOnlyName() : String
		{
			var result : String = getQualifiedClassName(this);
			return result.substr(result.lastIndexOf("::") + 2);
		}
		
		public var dataUpdateObject : DataTransferObject = null;
		
		public var parentCollection : IFindDataReference;
		
		public function markAsFlushed() : void
		{
			_isModified = false;
			_isInserted = false;
			_isDeleted = false;
		}

		public function get isDeleted() : Boolean
		{
			return _isDeleted;
		}
		public function set isDeleted(value : Boolean) : void
		{
			if (_isDeleted != value)
			{
				_isDeleted = value;
				dataUpdateObject.updateFor(this);
			}
		}
		private var _isDeleted : Boolean = false;
		
		public function get isInserted() : Boolean
		{
			return _isInserted;
		}
		public function set isInserted(value : Boolean) : void
		{
			if (_isInserted != value)
			{
				_isInserted = value;
				this.prepareNewInstance();
				dataUpdateObject.updateFor(this);
			}
		}
		private var _isInserted : Boolean = false;

		protected function prepareNewInstance() : void
		{
			//	stub
		}
		
		public function loadData(aData : Object) : void
		{
			throw new Error(getQualifiedClassName(this) + " must override loadData()");
		}
		public function get tableName() : String
		{
			throw new Error(getQualifiedClassName(this) + " must override get tableName()");
		}
		override public function toString() : String
		{
			return "[" + this.classOnlyName() + "]";
		}
		public function get isBlank() : Boolean
		{
			return true;
		}
		
		protected static const NUMBER_NOT_SET : Number = -1;
		protected static const INT_NOT_SET : int = -1;

		protected function findIntValue(anObject : Object, aPropertyName : String, aDefaultValue : int = 0) : int
		{
			var result : int = aDefaultValue;
			if (anObject.hasOwnProperty(aPropertyName))
			{
				var propertyString : String = anObject[aPropertyName];
				if (propertyString.match("[0-9]"))
					result = int(propertyString);
			}

			return result;
		}
		protected function findNumberValue(anObject : Object, aPropertyName : String, aDefaultValue : Number = 0) : Number
		{
			var result : Number = aDefaultValue;
			
			if (anObject.hasOwnProperty(aPropertyName))
			{
				var propertyString : String = anObject[aPropertyName];
				if (propertyString.match("[0-9]+(\.[0-9]*)?"))
					result = Number(propertyString);
			}

			return result;
		}
	}
}