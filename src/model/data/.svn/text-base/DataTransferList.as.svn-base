package model.data
{
	import model.vo.BaseIdDataVO;
	
	import mx.collections.ArrayCollection;

	public class DataTransferList extends ArrayCollection
	{
		override public function getItemIndex(item : Object) : int
		{
			if (item is BaseIdDataVO)
				return this.findIdIndex((item as BaseIdDataVO).id);
			else
				return super.getItemIndex(item);	
		}

		public function findIdIndex(anId : uint) : int
		{
			var idItem : BaseIdDataVO;
			for (var counter : uint = 0; counter < this.length; counter++)
			{
				idItem = this.getItemAt(counter) as BaseIdDataVO;
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