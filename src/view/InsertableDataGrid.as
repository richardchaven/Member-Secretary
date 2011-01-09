package view
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.getQualifiedClassName;
	
	import model.vo.BaseDataVO;
	import model.vo.BaseTableDataCollection;
	
	import mx.controls.AdvancedDataGrid;
	import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
	import mx.events.FlexEvent;
	import mx.events.ListEvent;

	[Event(name="rowExit", type="mx.events.ListEvent")]
	public class InsertableDataGrid extends AdvancedDataGrid
	{		
		public static const ROW_EXIT_EVENT : String = "rowExit";

		public function InsertableDataGrid()
		{
			super();
			this.addEventListener(mx.events.FlexEvent.INITIALIZE, onInitialization);
			this.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.addEventListener(Event.CHANGE, onRowChange);
			this.addEventListener(FocusEvent.FOCUS_IN, onFocus)
			this.addEventListener(FocusEvent.FOCUS_OUT, onRowChange)
		}

		public function get columnChildren() : Array
		{
			return _columnChildren;
		}
		public function set columnChildren(value : *) : void
		{
			if (value is Array)
				_columnChildren = value;
			else if (value is DisplayObject)
				_columnChildren = [value];
			else
				throw new Error("InsertableDataGrid.set columnChildren passed a " + getQualifiedClassName(value));
		}
		private var _columnChildren : Array = null;
		
		private function onInitialization(event : Event) : void
		{
			if (columnChildren != null)
			{
				var updatedColumns : Array = this.columns;
				
				for (var counter : uint = 0; counter < columnChildren.length; counter++)
					updatedColumns.push((columnChildren[counter] as AdvancedDataGridColumn));
					
				this.columns = updatedColumns;
			}	
		}

		public var autoInsert : Boolean = true;
		
		private function onFocus(event : Event) : void
		{
			if (this.autoInsert  && this.editable && (this.rowCount == 0))
				this.appendBlankRow();
		}
		
		private function onKeyDown(event : KeyboardEvent) : void
		{
			if ((event.keyCode == Keyboard.INSERT) && this.editable)
				this.appendBlankRow();
		}
		
		private function appendBlankRow() : void
		{
			var dataCollection : BaseTableDataCollection = this.dataProvider as BaseTableDataCollection;
			if (dataCollection != null)
			{	
				var newRow : BaseDataVO = null;

				if (dataCollection.length == 0)
					newRow = dataCollection.newItem(); //	virtual method
					
				else if (!dataCollection.getDataAt(dataCollection.length - 1).isBlank)
					newRow = dataCollection.newItem(); //	virtual method

				this.selectedIndex = dataCollection.length - 1;
			}
		}
		
		private function onRowChange(event : Event) : void
		{
			var newEvent : ListEvent = event as ListEvent
			if (newEvent == null)
				newEvent = new ListEvent(ROW_EXIT_EVENT, false, false, this.currentColNum, this.currentRowNum);

			this.dispatchEvent(newEvent);	
		}
	}
}