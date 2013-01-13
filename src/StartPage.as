package
{
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	
	//import starling.events.Event;
	
	[Event(name="classPage",type="starling.events.Event")]
	[Event(name="usersPage",type="starling.events.Event")]
	
	public class StartPage extends Screen
	{		
		private static const CLASS_PAGE:String = "showClasses";
		private static const USERS_PAGE:String = "showUsers";
		private static const ADD_USER_PAGE:String = "addUser";
		
		private var header:Header;
		private var list:PickerList;
		private var addUser:Button;
		private var settings:Button;
		private var classes:Button;
		
		public function StartPage()
		{
		}
		
		override protected function initialize():void
		{										
			list = new PickerList();
			list.dataProvider = new ListCollection(Main.users);
			list.labelFunction = function():String{
				return "Users";
			}
			list.listProperties.@itemRendererProperties.labelField = "name";
			list.selectedIndex = Main.currentUserDex;
			list.buttonProperties = {defaultIcon : Main.userIcon};
			list.addEventListener(Event.CHANGE, onListChange);
			addChild(list);
					
			var buttonLabel:String = (Main.currentUserDex == 0) ? list.selectedItem.name + " Classes" : list.selectedItem.name + "'s Classes";
						
			classes = new Button();
			classes.label = buttonLabel;
			classes.addEventListener(Event.TRIGGERED, onViewClasses);
			addChild(classes);
			
			addUser = new Button();
			addUser.defaultIcon = Main.addIcon;
			addUser.addEventListener(Event.TRIGGERED, onAddUser);
			addChild(addUser);
			
			settings = new Button();
			settings.defaultIcon = Main.settingsIcon;
			settings.addEventListener(Event.TRIGGERED, onUserSettings);
			addChild(settings);
			
			header = new Header();
			header.title = "Schedule App";
			addChild(header);
			
			header.leftItems = new <DisplayObject>[list];
			header.rightItems = new <DisplayObject>[addUser, settings];
			header.gap = 5;
			
			backButtonHandler = onBackButton;
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			header.validate();
			
			classes.width = 400;
			classes.x = (actualWidth - classes.width) >> 1;
			classes.y = (actualHeight - header.height) >> 1;
			classes.validate();
		}
		
		private function onListChange():void
		{
			Main.currentUserDex = list.selectedIndex;
			var buttonLabel:String = (Main.currentUserDex == 0) ? list.selectedItem.name + " Classes" : list.selectedItem.name + "'s Classes";
			classes.label = buttonLabel;
		}
		
		private function onAddUser():void
		{
			dispatchEventWith("addUser");
		}
		
		private function onViewClasses():void
		{
			Main.currentUser = (Main.currentUserDex == 0) ? null : list.selectedItem;
			dispatchEventWith(CLASS_PAGE);
		}
		
		private function onUserSettings():void
		{
			dispatchEventWith(USERS_PAGE);
		}
		
		private function onBackButton():void
		{
						
		}
	}
}