package
{
	import feathers.data.ListCollection;
	
	public class ClassSorter
	{	
		private var todayDate:String;
		private var days:Array = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"];
		private var dayArr:Array = [[], [], [], [], [], []];
		private var classes:Object;
		
		public function ClassSorter(co:Object):void
		{
			classes = co;
			var obj:Object;
			var tmpArr:Array = [[], [], [], [], [], []];
			
			for(var i:int = 0; i < days.length; i++){
				for(var j:int = 0; j < classes.length; j++){
					if(classes[j][days[i]] != "1"){
						tmpArr[i].push(classes[j]);
					}
				}
				
				tmpArr[i].sortOn(days[i], Array.NUMERIC);
				
				for(var k:int = 0; k < tmpArr[i].length; k++){
					obj = tmpArr[i][k];
										
					var time:Object = addTime(obj[days[i]], obj.classLength);
					
					obj.startTime = time.startTime;
					obj.endTime = time.endTime;
					
					var newClass:Object = new Object();
					newClass.fullName = obj.name + "  (" + obj.startTime + " - " + obj.endTime + ")";
					newClass.name = obj.name;
					newClass.startTime = obj.startTime;
					newClass.endTime = obj.endTime;
					newClass.age = obj.age;
					newClass.rank = obj.rank;
					newClass.description = obj.description;
					
					dayArr[i].push(newClass);
				}
			}						
		}
		
		private function addTime(start:String, len:String):Object
		{
			var result:Object = new Object();
			var h:Number = Number(start.substr(0, 2));
			var m:Number = Number(start.substr(2, 2));
			var a:Number = Number(len);
			
			h = (h > 12) ? h - 12 : h;
			
			result.startTime = prettyTime(h, m);
			
			var hour:Number = h * 60;
			var min:Number = m + a;
			var end:Number = hour + min;
			
			result.endTime = prettyTime(Math.floor(end/60), end%60);
			
			return result;
		}
		
		private function prettyTime(h:Number, m:Number):String
		{
			var hour:String = String(h);
			var min:String = (m < 10) ? String("0" + m) : String(m);
			return hour + ":" + min;
		}
		
		public function getClasses(date:String, user:Object = null):ListCollection
		{	
			var day:Object = dayArr[days.indexOf(date)];
			var lc:ListCollection = new ListCollection();
			
			if(user && user.name != "All"){
				var kbOption:String = (user.kb == "true") ? "kb" : "";
				var bbcOption:String = (user.bbc == "true") ? "bbc" : "";
				var rankOption:String = (user.rank == "int" || user.rank == "adv") ? "intAdv" : "";
				var ageOption:String = (user.age == "a" || user.age == "j") ? "combo" : "";
							
				for(var i:int = 0; i < day.length; i++){
					if(day[i].age == user.age || day[i].age == ageOption){
						if(day[i].rank == user.rank || day[i].rank == rankOption || day[i].rank == bbcOption || day[i].rank == kbOption){
							lc.push(day[i]);
						}
					}		
				}
			}else{
				for(i = 0; i < day.length; i++){
					lc.push(day[i]);
				}
			}
			
			return lc;
		}
	}
}