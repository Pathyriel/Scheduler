package
{
	import flash.display.Sprite;
	
	import starling.core.Starling;
	
	[SWF(width=640, height=960, frameRate=60)]
	public class Scheduler extends Sprite
	{
		public function Scheduler()
		{
			var starling:Starling = new Starling(Main, stage);
			starling.start();
		}
	}
}