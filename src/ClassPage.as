package
{	
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.List;
	import feathers.controls.PickerList;
	import feathers.controls.Screen;
	import feathers.data.ListCollection;
	import feathers.skins.StandardIcons;
	
	import starling.display.DisplayObject;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class ClassPage extends Screen
	{		
		private static const USERS_PAGE:String = "usersPage";
		private static const CLASS_INFO_PAGE:String = "classinfoPage";
		
		private var header:Header;
		private var backButton:Button;
		private var usersButton:Button;
		private var list:List;
		private var userList:PickerList;
		
		public function ClassPage()
		{
			
		}
		
		override protected function initialize():void
		{
			header = new Header();
			header.title = Main.today+"'s Classes";
			addChild(header);
			
			backButton = new Button();
			backButton.label = "Back";
			backButton.addEventListener(Event.TRIGGERED, onBack);
			
			userList = new PickerList();
			userList.dataProvider = new ListCollection(Main.users);
			userList.labelFunction = function():String{
				return "";
			}
			userList.listProperties.@itemRendererProperties.labelField = "name";
			userList.selectedIndex = Main.currentUserDex;
			userList.buttonProperties = {defaultIcon : Main.userIcon};
			userList.addEventListener(Event.CHANGE, onUserListChange);
			addChild(userList);
			
			
			header.leftItems = new <DisplayObject>[backButton];
			header.rightItems = new <DisplayObject>[userList];
			
			var newClasses:ListCollection = Main.classes.getClasses(Main.today, Main.currentUser);
			
			list = new List();
			list.dataProvider = newClasses;
			list.itemRendererProperties.labelField = "fullName";
			list.itemRendererProperties.accessoryTextureFunction = function(item:Object):Texture{
				return StandardIcons.listDrillDownAccessoryTexture;
			}
			list.addEventListener(Event.CHANGE, listChanged);
			addChild(list);
			
			backButtonHandler = onBackButton;
		}
		
		override protected function draw():void
		{
			header.width = actualWidth;
			header.validate();
			
			list.y = header.height;
			list.width = actualWidth;
			list.height = actualHeight - header.height;
		}
		
		private function onUserListChange():void
		{
			Main.currentUserDex = userList.selectedIndex;
			Main.currentUser = userList.selectedItem;
			
			var newClasses:ListCollection = Main.classes.getClasses(Main.today, Main.currentUser);
			list.dataProvider = newClasses;
		}
		
		private function listChanged():void
		{
			dispatchEventWith("showInfo", false, list.selectedItem);
		}
		
		private function onUsers():void
		{
			dispatchEventWith(USERS_PAGE);
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