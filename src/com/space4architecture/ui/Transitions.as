package com.space4architecture.ui
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import com.space4architecture.data.PageData;
	import com.space4architecture.pages.profile.*;
	
	public class Transitions extends MovieClip
	{
		private var theStage:DisplayObjectContainer;
		private var pageData:PageData;
		private var pageObjArray:Array;
		private var titlePosition:Array;
		public var pageContainer:MovieClip;
		private var mainMenuContainer:MovieClip;
		public var profilePage:ProfilePage;
		
		public function Transitions($stage:DisplayObjectContainer, $pageData:PageData)
		{
			theStage = $stage;
			pageData = $pageData;  //create data object
			//pageObjArray = pageData.pageObjArray; //object array
			titlePosition = [15,15];
			pageContainer = new MovieClip();
			pageContainer.name = "pageContainer";
			pageContainer.x = 0;
			pageContainer.y = 64;
			theStage.addChild(pageContainer);
			
			trace("animations initialized");
		}
		
		public function menuToPage():void
		{
			var pageIndex:int = pageData.pageIndex;
			mainMenuContainer = theStage.getChildByName("mainMenuContainer") as MovieClip;
			
			
			trace("from animations - page index: " + pageIndex);
			
			for(var i:int = 0; i < pageData.pageObjArray.length; i++)
			{
				if(i == pageIndex)
				{
					var activeObject:Object = pageData.pageObjArray[i];
					var activeMenuImage:MovieClip = activeObject.menuImage;
					var activeTitleText:MovieClip = activeObject.titleText;
					var activeLine:MovieClip = activeObject.line;
					
					//DO STUFF TO CLICKED MENU IMAGE
					activeMenuImage.buttonMode = false;	
					activeMenuImage.selectable = false;
					activeMenuImage.mouseEnabled = false;
					TweenLite.to(activeMenuImage, 1, {alpha:0, onComplete: removeImage, onCompleteParams:[activeMenuImage]});
					
					//CLICKED TITLE TEXT
					activeTitleText.gotoAndStop("out");
					activeTitleText.buttonMode = false;
					activeTitleText.selectable = false;
					activeTitleText.mouseEnabled = false;
					activeTitleText.mouseChildren = false;
					TweenLite.to(activeTitleText, 2, {x:titlePosition[0], y:titlePosition[1]});
					
					//CLICKED LINE
					mainMenuContainer.addChild(activeLine);
					TweenLite.to(activeLine, 2, {x:titlePosition[0] + activeObject.titleText.width + 3, y:titlePosition[1]});
				}
				else
				{	
					var inactiveObject:Object = pageData.pageObjArray[i];
					var inactiveLine:MovieClip = inactiveObject.line;
					var inactiveTitleText:MovieClip = inactiveObject.titleText
					
					//UNCLICKED MENU IMAGE
					if("menuImage" in inactiveObject)
					{
						var inactiveMenuImage:MovieClip = inactiveObject.menuImage;
						inactiveMenuImage.buttonMode = false;
						inactiveMenuImage.selectable = false;
						inactiveMenuImage.mouseEnabled = false;
						//theStage.removeChild(thisMenuImage);
						TweenLite.to(inactiveMenuImage, 1, {alpha:0, onComplete: removeImage, onCompleteParams:[inactiveMenuImage]});
						
					}
					
					//UNCLICKED LINE
					TweenLite.to(inactiveLine, 1, {alpha:0, onComplete: removeImage, onCompleteParams:[inactiveLine]});
					
					//UNCLICKED TITLE TEXT
					inactiveTitleText.buttonMode = false;
					inactiveTitleText.selectable = false;
					inactiveTitleText.mouseEnabled = false;
					inactiveTitleText.mouseChildren = false;
					
					TweenLite.to(inactiveTitleText, 1, {alpha:0, onComplete: removeImage, onCompleteParams:[inactiveTitleText]});					
				}
			}
			
		}
		
		private function removeImage(image:MovieClip):void
		{
			//var container:MovieClip = theStage.getChildByName("mainMenuContainer") as MovieClip;
			if(mainMenuContainer.contains(image))
			{
				mainMenuContainer.removeChild(image);
			}
		}
		
		public function replaceTitle():void
		{
			trace("replacing title...");
			
			TweenLite.to(mainMenuContainer, 1, {alpha:0, onComplete:swap});
			function swap():void
			{
				trace("swap");
				for(var i:int = 0; i < 2; i++)
				{
					mainMenuContainer.removeChildAt(0);
				}
				var newTitle:MovieClip = pageData.pageObjArray[pageData.pageIndex].titleText;
				var newLine:MovieClip = pageData.pageObjArray[pageData.pageIndex].line;
				newTitle.alpha = 1;
				newLine.alpha = 1;
				
				mainMenuContainer.addChild(newTitle);
				pageData.pageObjArray[pageData.pageIndex].titleText.x = titlePosition[0];
				pageData.pageObjArray[pageData.pageIndex].titleText.y = titlePosition[1];			
				mainMenuContainer.addChild(newLine);
				
				newLine.x = titlePosition[0] + newTitle.width + 3;
				newLine.y = titlePosition[1];

				TweenLite.to(mainMenuContainer, 1, {alpha:1});
			}	
		}
		
		public function changePage():void
		{
			trace("loading page...");
			profilePage = new ProfilePage(theStage);
			trace("created profile page");
			pageContainer.addChild(profilePage);
			trace("added profile page");
			
		}
			
	}

}	




