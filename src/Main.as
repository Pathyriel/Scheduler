package
{
	import flash.events.Event;
	
	import feathers.controls.ScreenNavigator;
	import feathers.controls.ScreenNavigatorItem;
	import feathers.motion.transitions.ScreenSlidingStackTransitionManager;
	import feathers.themes.MetalWorksMobileTheme;
	
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Main extends Sprite
	{
		[Embed(source="assets/images/metalworks/picker-list-icon.png")]
		private var addImg:Class;
		
		[Embed(source="assets/images/metalworks/settings.png")]
		private var settingsImg:Class;
		
		[Embed(source="assets/images/metalworks/user.png")]
		private var userImg:Class;
		
		[Embed(source="assets/images/metalworks/remove.png")]
		private var removeImg:Class;
		
		private static const START_PAGE:String = "startPage";
		private static const NEW_START_PAGE:String = "newStartPage";
		private static const CLASS_PAGE:String = "classPage";
		private static const CLASS_INFO_PAGE:String = "classinfoPage";
		private static const USERS_PAGE:String = "usersPage";
		private static const USER_SETTINGS_PAGE:String = "usersSettingsPage";
		private static const ADD_USER_PAGE:String = "addUserPage";
		
		private var nav:ScreenNavigator;
		private var transitionManager:ScreenSlidingStackTransitionManager;
		private var days:Array = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		private var date:Date;
		
		public static var files:ConfigLoader;
		public static var today:String;
		public static var classes:ClassSorter;
		public static var selectedClass:Object;
		public static var currentUser:Object;
		public static var currentUserDex:int = 0;
		public static var users:Array;
		public static var usersVector:Vector.<User>;
		public static var addIcon:Image;
		public static var settingsIcon:Image;
		public static var userIcon:Image;
		public static var removeIcon:Image;
		
		public function Main()
		{
			addEventListener(starling.events.Event.ADDED_TO_STAGE, loadInfo);
		}
		
		private function loadInfo():void
		{
			files = new ConfigLoader("json/config.json");
			files.start();
			files.addEventListener(flash.events.Event.COMPLETE, init);
		}
		
		private function init(e:flash.events.Event):void
		{
			date = new Date();
			today = days[date.day];
			
			classes = new ClassSorter(files.classes);
			
			usersVector = new Vector.<User>;
			
			users = [];
			users.push({name: "All"});
			for(var i:int = 0; i < files.users.length; i++){
				users.push(Main.files.users[i]);
			}
			
			addIcon = new Image(Texture.fromBitmap(new addImg()));
			settingsIcon = new Image(Texture.fromBitmap(new settingsImg()));			
			userIcon = new Image(Texture.fromBitmap(new userImg()));
			removeIcon = new Image(Texture.fromBitmap(new removeImg()));
			
			var theme:MetalWorksMobileTheme = new MetalWorksMobileTheme(stage);
			
			nav = new ScreenNavigator();
			addChild(nav);
			
			nav.addScreen(START_PAGE, new ScreenNavigatorItem(StartPage, 
			{
				showClasses: CLASS_PAGE, 
				showUsers: USERS_PAGE,
				addUser: ADD_USER_PAGE
			}));
			
			nav.addScreen(NEW_START_PAGE, new ScreenNavigatorItem(NewStartPage, 
			{
				addUser: ADD_USER_PAGE
			}));
			
			nav.addScreen(CLASS_PAGE, new ScreenNavigatorItem(ClassPage,
			{
				complete: START_PAGE,
				showInfo: showInfo,
				showUsers: USERS_PAGE
			}));
			
			nav.addScreen(CLASS_INFO_PAGE, new ScreenNavigatorItem(ClassInfoPage,
			{
				complete: CLASS_PAGE
			}));
			
			const userSettings:UserSettings = new UserSettings();
			nav.addScreen(USERS_PAGE, new ScreenNavigatorItem(UsersPage,
			{
				complete: CLASS_PAGE,
				showUserSettings: USER_SETTINGS_PAGE,
				addUser: ADD_USER_PAGE
			/*},
			{
				settings: userSettings*/
			}));
			
			
			nav.addScreen(USER_SETTINGS_PAGE, new ScreenNavigatorItem(UsersSettingsPage,
			{
				complete: USERS_PAGE,
				save:saveData
			},
			{
				settings: userSettings	
			}));
			
			const defaultSettings:DefaultSettings = new DefaultSettings();
			nav.addScreen(ADD_USER_PAGE, new ScreenNavigatorItem(AddUserPage,
			{
				complete: START_PAGE,
				save:saveData
			},
			{
				settings: defaultSettings
			}));
			
			transitionManager = new ScreenSlidingStackTransitionManager(nav);
			
			users.length == 0 ? nav.showScreen(NEW_START_PAGE) : nav.showScreen(START_PAGE);
		}
		
		private function showInfo(e:starling.events.Event, sc:Object):void
		{
			selectedClass = sc;
			nav.showScreen(CLASS_INFO_PAGE);
		}
		
		private function generateClass(e:starling.events.Event, si:Object):void
		{
			currentUser = si;
			nav.showScreen(CLASS_PAGE);
		}
		
		private function saveData(e:starling.events.Event, save:Object):void
		{
			trace("save some shit!");
		}
	}
}