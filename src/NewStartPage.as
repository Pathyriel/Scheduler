package
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Screen;
	
	import starling.events.Event;
	
	public class NewStartPage extends Screen
	{
		private var header:Header;
		private var addUser:Button;
		
		public function NewStartPage()
		{
			
		}
		
		override protected function initialize():void
		{		
			header = new Header();
			header.title = "Schedule App";
			addChild(header);
			
			addUser = new Button();
			addUser.label = "Add User";
			addChild(addUser);
			addUser.addEventListener(Event.TRIGGERED, onAddUser);
			
			backButtonHandler = onBackButton;
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			header.validate();
			
			addUser.width = 200;
			addUser.height = 60;
			addUser.x = (actualWidth - addUser.width) >> 1;
			addUser.y = header.height + 30;
		}
		
		private function onAddUser():void
		{
			
		}
		
		private function onBackButton():void
		{
			
		}
	}
}