package
{
	import flash.text.TextFormat;
	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.Screen;
	import feathers.controls.ScrollText;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class ClassInfoPage extends Screen
	{
		private var header:Header;
		private var backButton:Button;
		private var scrollText:ScrollText;
		private var label:Label;
		
		public function ClassInfoPage()
		{

		}
		
		override protected function initialize():void
		{
			var current:Object = Main.selectedClass
			
			header = new Header();
			header.title = current.name;
			addChild(header);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, onBack);
			
			header.leftItems = new <DisplayObject>[backButton];
			
			label = new Label();
			label.text = "("+current.startTime+" - "+current.endTime+")";
			addChild(label);
			label.textRendererProperties.textFormat = new TextFormat( "Arial", 30, 0xFFFFFF, null, null, null, null, null, "center" );
			
			scrollText = new ScrollText();
			scrollText.text = Main.selectedClass.description;
			addChild(scrollText);
			
			backButtonHandler = onBackButton;
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			header.validate();
			
			label.width = actualWidth;
			label.y = header.height;
			label.validate();
			
			scrollText.width = actualWidth;
			scrollText.y = header.height + label.height;
			scrollText.height = actualHeight - header.height - label.height;
		}
		
		private function onBackButton():void
		{
			dispatchEventWith("complete");
		}
		
		private function onBack():void
		{
			onBackButton();
		}
	}
}