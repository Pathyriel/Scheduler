package
{
	import flash.events.FocusEvent;
	import flash.net.SharedObject;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	
	import feathers.controls.Button;
	import feathers.controls.Check;
	import feathers.controls.Header;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.controls.TextInput;
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	public class AddUserPage extends Screen
	{
		public var settings:DefaultSettings;
		
		private var ages:Array = ["Age", "Safe Side", "Lil Champions", "Junior", "Adult"];
		private var ranks:Array = ["Rank", "Beginner", "Intermediate", "Advanced", "Black Belt", "Kickboxing"];
		
		private var header:Header;
		private var backButton:Button;
		private var input:TextInput;
		private var rank:PickerList;
		private var age:PickerList;
		private var bbc:Check;
		private var kb:Check;
		private var defaultUser:Check;
		private var saveButton:Button;
		private var lb:Button;
		
		
		public function AddUserPage()
		{
			
		}
		
		override protected function initialize():void
		{
			header = new Header();
			header.title = "Add A User";
			addChild(header);
			
			backButton = new Button();
			backButton.label = "<<";
			backButton.addEventListener(Event.TRIGGERED, onBack);
			
			header.leftItems = new <DisplayObject>[backButton];
			
			input = new TextInput();
			input.text = settings.name;
			input.addEventListener(FocusEvent.FOCUS_IN, onFocus);
			input.addEventListener(FocusEvent.FOCUS_OUT, offFocus);
			addChild(input);
			
			age = new PickerList();
			age.dataProvider = new ListCollection(ages);
			age.selectedIndex = settings.age;
			age.buttonProperties = {defaultIcon:null};
			age.addEventListener(Event.CHANGE, onAgeList);
			addChild(age);
			
			rank = new PickerList();
			rank.dataProvider = new ListCollection(ranks);
			rank.selectedIndex = settings.rank;
			rank.buttonProperties = {defaultIcon:null};
			rank.addEventListener(Event.CHANGE, onRankList);
			addChild(rank);
			
			bbc = new Check();
			bbc.isSelected = settings.bbc;
			bbc.label = "Black Belt Club";
			addChild(bbc);
			
			kb = new Check();
			kb.isSelected = settings.kb;
			kb.label = "Ignition Kickboxing";
			kb.addEventListener(Event.CHANGE, onKB);
			addChild(kb);
			
			defaultUser = new Check();
			defaultUser.isSelected = settings.kb;
			defaultUser.label = "Make Default User";
			addChild(defaultUser);
			
			saveButton = new Button();
			saveButton.label = "Save";
			saveButton.addEventListener(Event.TRIGGERED, onSave);
			addChild(saveButton);
			
			lb = new Button();
			lb.label = "load";
			lb.addEventListener(Event.TRIGGERED, onLoad);
			addChild(lb);
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			header.validate();
			
			input.y = header.height + 20;
			input.width = 600;
			input.x = (actualWidth - input.width) >> 1;
			
			age.y = 200;
			age.width = 400;
			age.x = (actualWidth - age.width) >> 1;
			
			rank.y = 300;
			rank.width = 400;
			rank.x = age.x;
			
			bbc.y = 400;
			bbc.x = age.x;
			
			kb.y = 470;
			kb.x = age.x;
			
			defaultUser.y = 540;
			defaultUser.x = age.x;
			
			lb.y = actualHeight - 100;
			lb.width = 200;
			lb.x = 50;
			lb.validate();
			
			saveButton.y = actualHeight - 100;
			saveButton.width = 200;
			saveButton.x = actualWidth - 250;
			saveButton.validate();
		}
		
		private function onAgeList():void
		{
			var selected:String = age.selectedItem as String;
			var newRanks:Array = [selected, selected];
			
			switch(selected){
				case "Safe Side":
					rank.isEnabled = false;
					rank.dataProvider = new ListCollection(newRanks);
					rank.selectedIndex = (rank.selectedIndex == 1) ? 0 : 1;
					kb.isEnabled = false;
				break;
				
				case "Lil Champions":
					rank.isEnabled = false;
					rank.dataProvider = new ListCollection(newRanks);
					rank.selectedIndex = (rank.selectedIndex == 1) ? 0 : 1;
					kb.isEnabled = false;
				break;
				
				case "Junior":
					rank.isEnabled = true;
					rank.dataProvider = new ListCollection(ranks);
					rank.selectedIndex = 0;
					kb.isEnabled = false;
				break;
				
				default:
					rank.isEnabled = true;
					rank.dataProvider = new ListCollection(ranks);
					rank.selectedIndex = 0;
					kb.isEnabled = true;
			}
		}
		
		private function onRankList():void
		{
			if(rank.selectedItem as String == "Kickboxing"){
				age.isEnabled = false;
				kb.isSelected = true;
				bbc.isEnabled = false;
			}else{
				age.isEnabled = true;
				kb.isSelected = false;
				bbc.isEnabled = true;
			}
		}
		
		private function onKB():void
		{
			if(rank.selectedItem as String == "Kickboxing"){
				kb.isSelected = true;
			}
		}
		
		private function onFocus():void
		{
			if(input.text == settings.name)
				input.text = "";
		}
		
		private function offFocus():void
		{
			if(input.text == "")
				input.text = settings.name;
		}
		
		private function onBackButton():void
		{
			dispatchEventWith("complete");
		}
		
		private function onBack():void
		{
			onBackButton();
		}
		
		private function onSave():void
		{
			var newUser:User = new User();
			newUser.name = input.text;
			newUser.age = age.selectedIndex;
			newUser.rank = rank.selectedIndex;
			newUser.bbc = bbc.isSelected;
			newUser.kb = kb.isSelected;
			newUser.defaultUser = defaultUser.isSelected;
			
			Main.usersVector.push(newUser);
			
			var saver:FSReadWrite = new FSReadWrite();
			saver.saveBytes("user.dat", Main.usersVector);
				
			onBackButton();
		}
		
		private function onLoad():void
		{
			var loader:FSReadWrite = new FSReadWrite();
			
			var v:Vector.<User> = loader.loadBytes("user.dat");
			
		}
	}
}