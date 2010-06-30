package com.space4architecture.utils
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	
	public class Utils 
	{
		public function Utils()
		{
			trace("utils running");
		}
		
		public function getPageIndex(target:*, objArray):int
		{
			var foundIndex:int;
			//var clickedObject:DisplayObject = target;
			//trace("clickedObject from utils: " + target);
			for (var i:int = 0; i < objArray.length; i++)
			{
				//trace("objArray[i].name: " + objArray[i].name);
				
				for each(var element in objArray[i])
				{
					if (element is DisplayObject)
					{
						//trace("looking at " + element);
						if(target == element)
						{
							
							foundIndex = i;
							i = objArray.length;
							break; 
							
						}
					}
					/*
					if (element.name == target.name){
						return i;
						i = objectArray.length;
						break;
					}
					*/
				}
				
			}
			return foundIndex;
		}
	}

}	




