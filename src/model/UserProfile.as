package model
{
	import model.vo.PersonVO;
	
	[Bindable]
	public class UserProfile
	{
		public function UserProfile()
		{
			super();
			
			_sessionStartTime = new Date();
		}
		
		private var _userName : String;
		public function get userName() : String { return _userName }
		public function set userName(value : String) : void { _userName = value }
		
		private var _roles : Array = new Array();
		public function get roles() : Array { return _roles }
		public function set roles(value : Array) : void { _roles = value }

		private var _sessionStartTime : Date;
		public function get sessionStartTime() : Date { return _sessionStartTime }
		public function set sessionStartTime(value : Date) : void { _sessionStartTime = value }
		
		private var _userExpireTime : Date;
		public function get userExpireTime() : Date { return _userExpireTime }
		public function set userExpireTime(value : Date) : void { _userExpireTime = value }
		
		private var _sessionExpireTime : Date;
		public function get sessionExpireTime() : Date { return _sessionExpireTime }
		public function set sessionExpireTime(value : Date) : void { _sessionExpireTime = value }
		
		private var _userPerson : PersonVO;
		private var _personId : uint;
		public function get userPerson() : PersonVO { return _userPerson }
		public function set userPerson(value : PersonVO) : void 
		{ 
			if (_userPerson != value)
			{ 
				_userPerson = value;
				_personId = value.id;
			} 
		}

		public function get personId() : uint { return _personId }
		public function set personId(value : uint) : void 
		{ 
			if (_personId != value)
			{
				_personId = value;
				_userPerson = null;
			} 
		}
	}
}