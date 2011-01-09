package model.data
{
	import flash.events.EventDispatcher;
	
	import mx.messaging.Channel;
	import mx.messaging.ChannelSet;
	import mx.messaging.channels.AMFChannel;
	import mx.messaging.config.ServerConfig;
	import mx.rpc.AbstractOperation;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;		//	yes, I want the mxml version of this
        
        
    [Event(name="result", type="mx.rpc.events.ResultEvent")]
    [Event(name="fault", type="mx.rpc.events.FaultEvent")]
	public class DatabaseConnection extends EventDispatcher
	{
		static private var _singletonInstance : DatabaseConnection = null;
		static public function get service() : RemoteObject 
		{ 
			if (_singletonInstance == null)
				_singletonInstance = new DatabaseConnection();
				
			return _singletonInstance.getRemoteObject(); 
		}
            	
		private static const SERVER_SOURCE_NAME : String = "MemberSecretaryServices";
		private static const CHANNEL_NAME : String = "amfphp";
		private var _connection : RemoteObject = null;
		protected function getRemoteObject() : RemoteObject
		{
			if (_connection == null)
			{
				_connection = new RemoteObject();
				_connection.source = SERVER_SOURCE_NAME;
				_connection.destination = CHANNEL_NAME;
				_connection.addEventListener(ResultEvent.RESULT, dataServiceResultHandler); 
				_connection.addEventListener(FaultEvent.FAULT, dataServiceFaultHandler);
				_connection.showBusyCursor = true; 
			}	
			
			return _connection;
		}
		
		public static function remoteMethod(aMethodName : String, 
			successListener : Function = null, faultListener : Function = null) : AbstractOperation
		{
			var theService : AbstractOperation = service.getOperation(aMethodName);
			if (successListener != null)
				theService.addEventListener(ResultEvent.RESULT, successListener, false, 0, true);
			if (faultListener != null)
				theService.addEventListener(FaultEvent.FAULT, faultListener, false, 0, true);
				
			return theService;
		}
			
//				just proxies
		private function dataServiceResultHandler(event : ResultEvent) : void
		{
			this.dispatchEvent(event);		//	bubble up one level
		} 
		
		private function dataServiceFaultHandler(event : FaultEvent) : void
		{
			this.dispatchEvent(event);		//	bubble up one level
		}
	}
}