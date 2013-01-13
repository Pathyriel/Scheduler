package
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	public dynamic class ConfigLoader extends EventDispatcher
	{		
		private var configLoader:URLLoader;
		private var path:String;
		private var names:Array = new Array();
		private var paths:Array = new Array();
		private var loader:URLLoader;
		
		public function ConfigLoader(p:String)
		{
			path = p;
		}
		
		public function start():void
		{
			configLoader = new URLLoader(new URLRequest(path));
			configLoader.addEventListener(Event.COMPLETE, onLoad);
		}
		
		private function onLoad(e:Event):void
		{
			var obj:Object = JSON.parse(configLoader.data);
			for(var i:int = 0; i < obj.config.length; i++){
				names.push(obj.config[i].name);
				paths.push(obj.config[i].path);
			}
			loadFile(String(paths[0]));
		}
		
		private function loadFile(p:String):void
		{
			loader = new URLLoader(new URLRequest(p));
			loader.addEventListener(Event.COMPLETE, loadComplete);
		}
		
		private function loadComplete(e:Event):void
		{
			var obj:Object = JSON.parse(e.target.data);
			this[names[0]] = obj[names[0]];
			names.shift();
			paths.shift();
			(paths.length > 0) ? loadFile(paths[0]) : dispatchEvent(new Event("complete"));
		}
	}
}