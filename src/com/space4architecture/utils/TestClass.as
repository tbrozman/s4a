package com.space4architecture.utils
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import com.space4architecture.data.PageData;
	
	public class TestClass 
	{
		private var theStage:DisplayObjectContainer;
		private var pageData:PageData;
		
		public function TestClass($stage:DisplayObjectContainer, $pageData:PageData)
		{
			theStage = $stage;
			pageData = $pageData;
			trace("wtf");
		}
		
		public function removeSomething():void
		{
			theStage.removeChild(pageData.pageObjArray[2].menuImage);
		}
		
		
	}

}	




