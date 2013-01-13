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
	
	public class UsersPage extends Screen
	{
		private var list:List;
		private var header:Header;
		private var backButton:Button;
		private var addUser:Button;
		private var removeUser:PickerList;
		
		public function UsersPage()
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
			
			addUser = new Button();
			addUser.defaultIcon = Main.addIcon;
			addUser.addEventListener(Event.TRIGGERED, onAddUser);
			addChild(addUser);
			
			removeUser = new PickerList();
			removeUser.dataProvider = new ListCollection(Main.users);
			removeUser.labelFunction = function():String{
				return "";
			}
			removeUser.listProperties.@itemRendererProperties.labelField = "name";
			removeUser.selectedIndex = Main.currentUserDex;
			removeUser.buttonProperties = {defaultIcon : Main.removeIcon};
			removeUser.addEventListener(Event.CHANGE, onListChange);
			addChild(removeUser);
			
			header.leftItems = new <DisplayObject>[backButton];
			header.rightItems = new <DisplayObject>[addUser, removeUser];
			header.gap = 5;
			
			list = new List();
			list.dataProvider = new ListCollection(Main.users);
			list.itemRendererProperties.labelField = "name";
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
		
		private function onAddUser():void
		{
			
		}
		
		private function onListChange():void
		{
			
		}
		
		private function listChanged():void
		{
			dispatchEventWith("showInfo", false, list.selectedItem);
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