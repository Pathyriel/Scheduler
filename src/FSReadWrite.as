package
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import flash.net.ObjectEncoding;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.CompressionAlgorithm;

	public class FSReadWrite
	{
		public function FSReadWrite()
		{
		}
		
		private function getSaveStream(fileName:String, write:Boolean):FileStream
		{
			//var f:File = File.applicationStorageDirectory.resolvePath(fileName);
			var f:File = File.desktopDirectory.resolvePath(fileName);
			var fs:FileStream = new FileStream();
			
			trace("fileName: " + f.nativePath);
			
			try
			{
				(write) ? fs.open(f, FileMode.WRITE) : fs.open(f, FileMode.READ);
			}
			catch(e:Error)
			{
				trace("there is an error with the filestream");
				return null;
			}
			
			return fs;
		}
		
		public function saveBytes(fileName:String, data:Vector.<User>):void
		{
			var bytes:ByteArray = new ByteArray();
			
			registerClassAlias("User", User);
			
			bytes.writeObject(data);
			bytes.position = 0;
			
			var fs:FileStream = getSaveStream(fileName, true);
			
			if(fs){
				fs.writeBytes(bytes);
				fs.close();
				trace("file written");
			}
			
		}
		
		public function loadBytes(fileName:String):Vector.<User>
		{
			var bytes:ByteArray = new ByteArray();
			var fs:FileStream = getSaveStream(fileName, false);
			
			if(fs)
			{
				registerClassAlias("User", User);
				try
				{
					fs.readBytes(bytes);
					fs.close();
				}
				catch(e:Error)
				{
					trace("can't load due to error: " + e.toString());
				}
			}
			
			//bytes.position = 0;
			
			trace("loading...");
			
			var users:Vector.<User> = bytes.readObject() as Vector.<User>;
			
			trace(users);
			
			for each(var p:User in users)
			{
				trace("loading: " + p.name + " " + p.age + " " + p.rank + " " + p.bbc + " " + p.kb);
			}
				
			return users;
		}
	}
}






