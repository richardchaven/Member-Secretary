package model.data
{
	import model.vo.BaseDataVO;
	
	public class DataTransferObject extends Object
	{
		static public const INSERT_OPERATION : String = 'insert';
		static public const UPDATE_OPERATION : String = 'update';
		static public const DELETE_OPERATION : String = 'delete';
			
		private var _tableObjects : Object = new Object();
		
		protected function getTableObject(aTableName : String) : Object
		{
			if (!_tableObjects.hasOwnProperty(aTableName))
				 _tableObjects[aTableName] = new Object();
				 
			return _tableObjects[aTableName];
		}
		
		protected function getTableOperationArray(aTableName : String, anOperation : String) : DataTransferList
		{
			var tableObject : Object = this.getTableObject(aTableName);
			
			if (!tableObject.hasOwnProperty(anOperation))
				tableObject[anOperation] = new DataTransferList();
				
			return tableObject[anOperation];
		}
		
		public function getInsertArray(aTableName : String) : DataTransferList
		{
			return this.getTableOperationArray(aTableName, INSERT_OPERATION);
		}
		public function getUpdateArray(aTableName : String) : DataTransferList
		{
			return this.getTableOperationArray(aTableName, UPDATE_OPERATION);
		}
		public function getDeleteArray(aTableName : String) : DataTransferList
		{
			return this.getTableOperationArray(aTableName, DELETE_OPERATION);
		}
		
		public function clear() : void
		{
			var tableObject : Object;
			for (var tableKey : String in this)
			{
				tableObject = this[tableKey];
				for (var operationKey : String in tableObject)
					tableObject[operationKey] = null;		//	free it	
			}
		}
		
		public function count() : uint
		{
			var result : uint = 0;
			
			for each (var theTableObject : Object in this)
			{
				for each (var theOperationArray : Array in theTableObject)
					result += theOperationArray.length;	
			}
			
			return result;			
		}
		
		public function updateFor(aVO : BaseDataVO) : void
		{
			var existingIndex : int;

			if (aVO.isDeleted)
			{
				existingIndex = this.getInsertArray(aVO.tableName).getItemIndex(aVO);
				if (existingIndex != -1)
				{
					this.getInsertArray(aVO.tableName).removeItemAt(existingIndex);
					trace("DataTransferObject.updateFor:: deletion removing " + aVO.toString() + " from insert array for " + aVO.tableName);
				}

				else if (!(aVO.isInserted))
				{
					if (this.getDeleteArray(aVO.tableName).getItemIndex(aVO) == -1)
					{
						this.getDeleteArray(aVO.tableName).addItem(aVO);
						trace("DataTransferObject.updateFor:: deletion adding " + aVO.toString() + " to delete array for " + aVO.tableName);
					}

					existingIndex = this.getUpdateArray(aVO.tableName).getItemIndex(aVO);
					if (existingIndex != -1)
					{
						this.getUpdateArray(aVO.tableName).removeItemAt(existingIndex);
						trace("DataTransferObject.updateFor:: deletion removing " + aVO.toString() + " from update array for " + aVO.tableName);
					}
				}
			}
			else if (aVO.isInserted)
			{
				if (this.getInsertArray(aVO.tableName).getItemIndex(aVO) == -1)
				{
					this.getInsertArray(aVO.tableName).addItem(aVO);
					trace("DataTransferObject.updateFor:: adding an entry for " + aVO.toString() + " into the insert array for " + aVO.tableName);
				}
				else
					trace("DataTransferObject.updateFor:: found an existing entry for " + aVO.toString() + " in the insert array for " + aVO.tableName);
				
			}
			else if (aVO.isModified)
			{
				if (this.getUpdateArray(aVO.tableName).getItemIndex(aVO) == -1)
				{
					this.getUpdateArray(aVO.tableName).addItem(aVO);
					trace("DataTransferObject.updateFor:: adding an entry for " + aVO.toString() + " into the update array for " + aVO.tableName);
				}
				else
					trace("DataTransferObject.updateFor:: found an existing entry for " + aVO.toString() + " in the update array for " + aVO.tableName);
			}
			else //	Undo
			{
				existingIndex = this.getUpdateArray(aVO.tableName).getItemIndex(aVO);
				if (existingIndex != -1)
				{
					this.getUpdateArray(aVO.tableName).removeItemAt(existingIndex);
					trace("DataTransferObject.updateFor:: removing the entry for " + aVO.toString() + " from the update array for " + aVO.tableName);
				}

				existingIndex = this.getDeleteArray(aVO.tableName).getItemIndex(aVO);
				if (existingIndex != -1)
				{
					this.getDeleteArray(aVO.tableName).removeItemAt(existingIndex);
					trace("DataTransferObject.updateFor:: removing the entry for " + aVO.toString() + " from the deleted array for " + aVO.tableName);
				}
 
				existingIndex = this.getInsertArray(aVO.tableName).getItemIndex(aVO);
				if (existingIndex != -1)
				{
					this.getInsertArray(aVO.tableName).removeItemAt(existingIndex);
					trace("DataTransferObject.updateFor:: removing the entry for " + aVO.toString() + " from the insert array for " + aVO.tableName);
				}
			}
		}
	}
}