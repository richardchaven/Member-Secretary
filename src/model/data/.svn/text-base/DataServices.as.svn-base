package model.data
{
	import com.gsolo.encryption.SHA1;
	
	import mx.rpc.AbstractOperation;
	
	public class DataServices
	{
		public static function getServerVersion(aSuccessfulLoginListener : Function = null, anUnsuccessfulLoginListener : Function = null) : void
		{
			DatabaseConnection.remoteMethod("getVersion", aSuccessfulLoginListener, anUnsuccessfulLoginListener).send();
		}
		
		public static function login(aUserName : String, aPassword : String, 
			aSuccessfulLoginListener : Function = null, anUnsuccessfulLoginListener : Function = null) : void
		{
			var hashedPassword : String = SHA1.hex_sha1(aPassword);
			var seed : String = new Date().time.toString();

			var rehashedPassword : String = SHA1.hex_sha1(hashedPassword + seed);

			var theRemoteMethod : AbstractOperation = 
				DatabaseConnection.remoteMethod("login", aSuccessfulLoginListener, anUnsuccessfulLoginListener);
			
			theRemoteMethod.send(aUserName, rehashedPassword, seed);			
		}
		
		public static function logout(aSuccessfulLoginListener : Function = null, anUnsuccessfulLoginListener : Function = null) : void
		{
			var theRemoteMethod : AbstractOperation = 
				DatabaseConnection.remoteMethod("logout", aSuccessfulLoginListener, anUnsuccessfulLoginListener);
			
			theRemoteMethod.send();			
		}
		
		public static function getLookupData(aSuccessfulGetLookupDataListener : Function = null, 
			anUnsuccessfulGetLookupDataListener : Function = null) : void
		{
			trace("calling getLookupData on the server");
			var theRemoteMethod : AbstractOperation = 
				DatabaseConnection.remoteMethod("getLookupData", aSuccessfulGetLookupDataListener, anUnsuccessfulGetLookupDataListener);
				
			theRemoteMethod.send();
		}
		
		public static function getNextId(aTableName : String, aSuccessfulGetNextIdListener : Function) : void
		{
			var theRemoteMethod : AbstractOperation = DatabaseConnection.remoteMethod("getNextId", aSuccessfulGetNextIdListener);
				
			theRemoteMethod.send(aTableName);
		}

		public static function flushDataTransferObject(aTransferObject : DataTransferObject,
					aSuccessfulFlushListener : Function = null, anUnsuccessfulFlushListener : Function = null) : void
		{
			var theRemoteMethod : AbstractOperation = 
				DatabaseConnection.remoteMethod("setTablesData", aSuccessfulFlushListener, anUnsuccessfulFlushListener);
				
			theRemoteMethod.send(aTransferObject);
		}
	}
}