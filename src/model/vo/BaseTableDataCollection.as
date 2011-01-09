package model.vo
{
	import flash.utils.getQualifiedClassName;
	
	import model.data.DataTransferObject;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.core.ClassFactory;

	public class BaseTableDataCollection extends ArrayCollection implements ICollectionView, IFindDataReference
	{
		private var _itemClassFactory : ClassFactory = new ClassFactory();
		private var _dataUpdateObject : DataTransferObject = null;

		public function BaseTableDataCollection(anItemClass : Class, aDataUpdateObject : DataTransferObject = null)
		{
			super();

			_itemClassFactory.generator = anItemClass;
			_dataUpdateObject = aDataUpdateObject;
		}

		public function loadData(anArray : Array) : void
		{
			for (var counter : uint = 0; counter < anArray.length; counter++)
				this.newItem(anArray[counter]);
		}

		public function newItem(initializingData : Object = null, newPosition : int = -1) : BaseDataVO
		{
			if (_itemClassFactory.generator == null)
				throw new Error(flash.utils.getQualifiedClassName(this) + " has a null _itemClassFactory.generator inside newItem()");

			var theNewItem : BaseDataVO = _itemClassFactory.newInstance();

			if (initializingData != null)
				theNewItem.loadData(initializingData);

			if (newPosition == -1)
				newPosition = this.length;

			this.addItemAt(theNewItem, newPosition);
			theNewItem.parentCollection = this;
			
			theNewItem.dataUpdateObject = _dataUpdateObject;
			theNewItem.isInserted = true;
			
			return theNewItem;
		}

		private var _dataHost : IFindDataReference;

		public function get dataHost() : IFindDataReference
		{
			return _dataHost
		}

		public function set dataHost(value : IFindDataReference) : void
		{
			_dataHost = value
		}

		public function findDataObject(objectName : String, anId : uint) : BaseIdDataVO
		{
			return _dataHost.findDataObject(objectName, anId);
		}

		public function getDataAt(index : int, prefetch : int = 0) : BaseDataVO
		{
			return BaseDataVO(this.getItemAt(index, prefetch));
		}
		
		override public function getItemIndex(item : Object) : int
		{
			if (item is BaseIdDataVO)
				return this.findIdIndex((item as BaseIdDataVO).id);
			else
				return super.getItemIndex(item);	
		}

		public function findID(anId : uint) : BaseIdDataVO
		{
			var index : int = this.findIdIndex(anId);
			if (index == -1)
				return null;
			else
				return this.getDataAt(index) as BaseIdDataVO;
		}

		public function findIdIndex(anId : uint) : int
		{
			var idItem : BaseIdDataVO;
			for (var counter : uint = 0; counter < this.length; counter++)
			{
				idItem = this.getDataAt(counter) as BaseIdDataVO;
				if (idItem != null)
				{
					if (idItem.id == anId)
						return counter;
				}
			}
			return -1;
		}
	}
}