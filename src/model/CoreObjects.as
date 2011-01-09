package model
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import model.data.DataServices;
	import model.data.DataTransferObject;
	import model.data.DatabaseConnection;
	import model.vo.*;
	
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;
	import mx.events.PropertyChangeEvent;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.ResultEvent;

	[Bindable]
	public class CoreObjects extends Object implements IFindDataReference
	{
		public const MEMBERSHIP_TYPE_DATA_CHANGE : String = "MembershipTypeDataChange";
		public const MEMBERSHIP_TYPE_REQUIRED_EVENT_DATA_CHANGE : String = "MembershipTypeRequiredEventDataChange";
		public const MEMBERSHIP_TYPE_INVENTORY_PRICES_DATA_CHANGE : String = "MembershipTypeInventoryPricesDataChange";
		public const MEMBERSHIP_TYPE_INCLUDED_INVENTORY_DATA_CHANGE : String = "MembershipTypeIncludedInventoryDataChange";
		public const MEMBERSHIP_TYPE_VOLUNTEER_REQUIREMENTS_DATA_CHANGE : String = "MembershipTypeVolunteerRequirementsDataChange";

		public const EVENT_TYPE_DATA_CHANGE : String = "EventTypeDataChange";
		public const INVENTORY_TYPE_DATA_CHANGE : String = "InventoryTypeDataChange";
		public const INTEREST_DATA_CHANGE : String = "InterestDataChange";
		public const LOCATION_DATA_CHANGE : String = "LocationDataChange";
		public const PERSON_RELATIONSHIP_TYPE_DATA_CHANGE : String = "PersonRelationshipTypeDataChange";
		public const PERSON_TITLE_TYPE_DATA_CHANGE : String = "PersonTitleTypeDataChange";

		private var _memberTypeData : BaseTableDataCollection;
		private var _membershipTypeRequiredEventData : BaseTableDataCollection;
		private var _membershipTypeInventoryPriceData : BaseTableDataCollection;
		private var _membershipTypeIncludedInventoryData : BaseTableDataCollection;
		private var _membershipTypeVolunteerRequirementData : BaseTableDataCollection;

		private var _eventTypeData : BaseTableDataCollection;
		private var _inventoryTypeData : BaseTableDataCollection;
		private var _interestData : BaseTableDataCollection;
		private var _locationData : BaseTableDataCollection;
		private var _personRelationshipTypeData : BaseTableDataCollection;
		private var _personTitleTypeData : BaseTableDataCollection;

		public function get updateObject() : DataTransferObject
		{
			return _updateObject
		}
		private var _updateObject : DataTransferObject = new DataTransferObject();

		public function CoreObjects()
		{
			super();

			_memberTypeData = new BaseTableDataCollection(MembershipTypeVO, _updateObject);
			_memberTypeData.dataHost = this;
			_memberTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onMembershipTypeDataChange);
			_memberTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_membershipTypeRequiredEventData = new BaseTableDataCollection(MembershipTypeRequiredEventVO);
			_membershipTypeRequiredEventData.dataHost = this;
			_membershipTypeRequiredEventData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onMembershipTypeRequiredEventsDataChange);
			_membershipTypeRequiredEventData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_membershipTypeInventoryPriceData = new BaseTableDataCollection(MembershipTypeInventoryPriceVO);
			_membershipTypeInventoryPriceData.dataHost = this;
			_membershipTypeInventoryPriceData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onMembershipTypeInventoryPriceDataChange);
			_membershipTypeInventoryPriceData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_membershipTypeIncludedInventoryData = new BaseTableDataCollection(MembershipTypeIncludedInventoryVO);
			_membershipTypeIncludedInventoryData.dataHost = this;
			_membershipTypeIncludedInventoryData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onMembershipTypeIncludedInventoryDataChange);
			_membershipTypeIncludedInventoryData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_membershipTypeVolunteerRequirementData = new BaseTableDataCollection(MembershipTypeVolunteerRequirementsVO);
			_membershipTypeVolunteerRequirementData.dataHost = this;
			_membershipTypeVolunteerRequirementData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onMembershipTypeVolunteerRequirementsDataChange);
			_membershipTypeVolunteerRequirementData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_eventTypeData = new BaseTableDataCollection(EventTypeVO);
			_eventTypeData.dataHost = this;
			_eventTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onEventTypeDataChange);
			_eventTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_inventoryTypeData = new BaseTableDataCollection(InventoryTypeVO);
			_inventoryTypeData.dataHost = this;
			_inventoryTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onInventoryTypeDataChange);
			_inventoryTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_interestData = new BaseTableDataCollection(InterestVO);
			_interestData.dataHost = this;
			_interestData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onInterestDataChange);
			_interestData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_locationData = new BaseTableDataCollection(LocationVO);
			_locationData.dataHost = this;
			_locationData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onLocationDataChange);
			_locationData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_personRelationshipTypeData = new BaseTableDataCollection(PersonRelationshipTypeVO);
			_personRelationshipTypeData.dataHost = this;
			_personRelationshipTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onPersonRelationshipTypeDataChange);
			_personRelationshipTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);

			_personTitleTypeData = new BaseTableDataCollection(PersonTitleTypesVO);
			_personTitleTypeData.dataHost = this;
			_personTitleTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, onPersonTitleTypeDataChange);
			_personTitleTypeData.addEventListener(CollectionEvent.COLLECTION_CHANGE, itemChanged);
		}

		private var _lookupDataIsLoaded : Boolean = false;

		public function get lookupDataIsLoaded() : Boolean
		{
			return _lookupDataIsLoaded
		}

		public function loadLookupData() : void
		{
			trace("calling getLookupData on the server");
			DataServices.getLookupData(getLookupDataResult);
		}

		private function getLookupDataResult(event : ResultEvent) : void
		{
			trace("getLookupDataResult = " + event.result.toString());

			/*					the data structure passed is a nested Object within a nested Array
			   [table name][0][column name]

			   The table names are:
			   "Inventory Types"
			   "Membership Types"
			   "Membership Required Event Types"
			   "Membership Type Inventory Price"
			   "Membership Type Included Inventory"
			   "Event Types"
			   "Person Relationship Types"
			   "Interests"
			   "Locations"
			   "Title Types"

			   for example:
			   data["Inventory Types"]["basePrice"] == 25.06;
			 */

			var theDBObject : Object = event.result;

			for (var key : String in theDBObject)
			{
				switch (key)
				{
					case "Membership_Types":
						this.memberTypeData.loadData(theDBObject[key]);
						break;

					case "Membership_Type_Required_Events":
						this.membershipTypeRequiredEventData.loadData(theDBObject[key]);
						break;

					case "Membership_Type_Inventory_Prices":
						this.membershipTypeInventoryPriceData.loadData(theDBObject[key]);
						break;

					case "Membership_Type_Included_Inventory":
						this.membershipTypeIncludedInventoryData.loadData(theDBObject[key]);
						break;

					case "Membership_Type_Volunteer_Requirements":
						this.membershipTypeVolunteerRequirementData.loadData(theDBObject[key]);
						break;

					case "Event_Types":
						this.eventTypeData.loadData(theDBObject[key]);
						break;

					case "Inventory_Types":
						this.inventoryTypeData.loadData(theDBObject[key]);
						break;

					case "Interests":
						this.interestData.loadData(theDBObject[key]);
						break;

					case "Locations":
						this.locationData.loadData(theDBObject[key]);
						break;

					case "Person_Relationship_Types":
						this.personRelationshipTypeData.loadData(theDBObject[key]);
						break;

					case "Person_Title_Types":
						this._personTitleTypeData.loadData(theDBObject[key]);
						break;

					default:
						trace("unknown key " + key + " in loadLookupData");
				}
			}

			_lookupDataIsLoaded = true;
		}

		private var _isUpdatingLookups : Boolean = false;

		public function saveLookupData(event : Event = null) : void
		{
			if (!_isUpdatingLookups)
			{
				_isUpdatingLookups = true;

				var theOperation : AbstractOperation = 
					DatabaseConnection.remoteMethod("setLookupData", saveLookupDataResult, saveLookupDataFault);

				var sentUpdateObject : DataTransferObject = _updateObject;
				_updateObject = new DataTransferObject(); //	allow updates while we are sending as well as afterwards
				theOperation.send(sentUpdateObject);
			}
		}

		private function saveLookupDataResult(event : Event) : void
		{
			_isUpdatingLookups = false;

			if (_pendingItemChange)
				aknowledgeItemChange();
		}

		private function saveLookupDataFault(event : Event) : void
		{
			_isUpdatingLookups = false;

			if (_pendingItemChange)
				aknowledgeItemChange();

			// TODO
		}

		public function findDataObject(objectName : String, anId : uint) : BaseIdDataVO
		{
			switch (objectName)
			{
				case "Membership Type":
					return this.memberTypeData.findID(anId);

				case "Membership Type Required Event":
					return this.membershipTypeRequiredEventData.findID(anId);

				case "Membership Type Inventory Price":
					return this.membershipTypeInventoryPriceData.findID(anId);

				case "Membership Type Included Inventory":
					return this.membershipTypeIncludedInventoryData.findID(anId);

				case "Membership Type Volunteer Requirement":
					return this.membershipTypeVolunteerRequirementData.findID(anId);

				case "Event Type":
					return this.eventTypeData.findID(anId);

				case "Inventory Type":
					return this.inventoryTypeData.findID(anId);

				case "Interest":
					return this.interestData.findID(anId);

				case "Location":
					return this.locationData.findID(anId);

				case "Person Relationship Type":
					return this.personRelationshipTypeData.findID(anId);

				case "Person Title Type":
					return this.personTitleTypeData.findID(anId);

				default:
					trace("unknown objectName " + objectName + " in findLookupObject");
					return null;
			}
		}

		private function itemChanged(event : CollectionEvent) : void
		{
			var theCollection : BaseTableDataCollection = event.currentTarget as BaseTableDataCollection;
			var theBaseData : BaseDataVO = null;

			switch (event.kind)
			{
				case CollectionEventKind.ADD:
					for (var addCounter : uint = 0; addCounter < event.items.length; addCounter++)
					{
						theBaseData = event.items[addCounter] as BaseDataVO;
						this.updateObject.updateFor(theBaseData);
					}
					break;

				case CollectionEventKind.REPLACE:
					theBaseData = event.items[addCounter] as BaseDataVO;
					this.updateObject.updateFor(theBaseData);
					break;

				case CollectionEventKind.UPDATE:
					var prevSource : Object = null;
					var thisProperty : PropertyChangeEvent;

					for (var updateCounter : uint = 0; updateCounter < event.items.length; updateCounter++)
					{
						thisProperty = event.items[updateCounter] as PropertyChangeEvent;
						if (prevSource != thisProperty.source) //	only once per object
						{
							theBaseData = thisProperty.source as BaseDataVO;
							prevSource = theBaseData;
							this.updateObject.updateFor(theBaseData);
							trace("CoreObjects.itemChanged: for " + theBaseData.toString());
						}
					}

					break;

				default:
					throw new Error("Unexpected change event (" + event.kind + ") in CoreObjects array collection");
			}

			aknowledgeItemChange();
		}

		private var _delayedUpdateTimer : Timer;
		private var _pendingItemChange : Boolean = false;

		private function aknowledgeItemChange() : void
		{
			if (_isUpdatingLookups)
				_pendingItemChange = true;
			else
			{
				_pendingItemChange = false;

				if (_delayedUpdateTimer == null)
				{
					_delayedUpdateTimer = new Timer(30000);
					_delayedUpdateTimer.addEventListener(TimerEvent.TIMER, this.saveLookupData);
				}
				else
					_delayedUpdateTimer.reset();
					
				_delayedUpdateTimer.start();
			}
		}

		private var _lookupArrayCollections : Array = new Array();

		[Bindable(event="LookupDataChange")]
		public function lookupTableData(aLookupTablename : String) : BaseTableDataCollection
		{
			if (_lookupArrayCollections[aLookupTablename] != null) //	this associative array is really an Object in disgise
				return _lookupArrayCollections[aLookupTablename] as BaseTableDataCollection;

			else
				return null;
		}

		[Bindable(event="MembershipTypeDataChange")]
		public function get memberTypeData() : BaseTableDataCollection
		{
			return _memberTypeData
		}

		private function onMembershipTypeDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(MEMBERSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="MembershipTypeRequiredEventDataChange")]
		public function get membershipTypeRequiredEventData() : BaseTableDataCollection
		{
			return _membershipTypeRequiredEventData
		}

		private function onMembershipTypeRequiredEventsDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(MEMBERSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="MembershipTypeInventoryPricesDataChange")]
		public function get membershipTypeInventoryPriceData() : BaseTableDataCollection
		{
			return _membershipTypeInventoryPriceData
		}

		private function onMembershipTypeInventoryPriceDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(MEMBERSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="MembershipTypeIncludedInventoryChange")]
		public function get membershipTypeIncludedInventoryData() : BaseTableDataCollection
		{
			return _membershipTypeIncludedInventoryData
		}

		private function onMembershipTypeIncludedInventoryDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(MEMBERSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="MembershipTypeVolunteerRequirementsDataChange")]
		public function get membershipTypeVolunteerRequirementData() : BaseTableDataCollection
		{
			return _membershipTypeVolunteerRequirementData
		}

		private function onMembershipTypeVolunteerRequirementsDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(MEMBERSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="EventTypeDataChange")]
		public function get eventTypeData() : BaseTableDataCollection
		{
			return _eventTypeData
		}

		private function onEventTypeDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(EVENT_TYPE_DATA_CHANGE));
		}

		[Bindable(event="InventoryTypeDataChange")]
		public function get inventoryTypeData() : BaseTableDataCollection
		{
			return _inventoryTypeData
		}

		private function onInventoryTypeDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(INVENTORY_TYPE_DATA_CHANGE));
		}

		[Bindable(event="InterestDataChange")]
		public function get interestData() : BaseTableDataCollection
		{
			return _interestData
		}

		private function onInterestDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(INTEREST_DATA_CHANGE));
		}

		[Bindable(event="LocationDataChange")]
		public function get locationData() : BaseTableDataCollection
		{
			return _locationData
		}

		private function onLocationDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(LOCATION_DATA_CHANGE));
		}

		[Bindable(event="PersonRelationshipTypeDataChange")]
		public function get personRelationshipTypeData() : BaseTableDataCollection
		{
			return _personRelationshipTypeData
		}

		private function onPersonRelationshipTypeDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(PERSON_RELATIONSHIP_TYPE_DATA_CHANGE));
		}

		[Bindable(event="PersonTitleTypeDataChange")]
		public function get personTitleTypeData() : BaseTableDataCollection
		{
			return _personTitleTypeData
		}

		private function onPersonTitleTypeDataChange(event : CollectionEvent) : void
		{
			this.dispatchEvent(new Event(PERSON_TITLE_TYPE_DATA_CHANGE));
		}
	}
}