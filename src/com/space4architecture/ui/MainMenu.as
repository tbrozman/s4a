package com.space4architecture.ui {
	
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import fl.motion.easing.*;
	import flash.utils.Timer;
	import com.space4architecture.data.PageData;
	import com.space4architecture.utils.Utils;
	
	public class MainMenu extends MovieClip
	{
		private var theStage:DisplayObjectContainer;
		private var utils:Utils;
		public static const MENU_COMPLETE:String = "Main Menu Creation Complete";
		private var pageData:PageData;
		private var pageArray:Array;
		private var mainMenuContainer:MovieClip;
		public var pageContainer:MovieClip;
		
		
		public static const MENU_BUTTON_CLICKED:String = "Menu Button Clicked";
		
		//CONSTRUCTOR
		public function MainMenu($stage:DisplayObjectContainer, $pageData:PageData)
		{
			theStage = $stage;
			utils = new Utils();
			pageData = $pageData;
			pageArray = pageData.pageObjArray;
			pageContainer = new MovieClip;
			pageContainer.x = 0;
			pageContainer.y = 64;
		}
		
		
		public function createMainMenu():void
		{
			mainMenuContainer = new MovieClip();
			mainMenuContainer.alpha = 0;
			mainMenuContainer.name = "mainMenuContainer";
			
			for (var i:int = 0; i < pageArray.length; i++)
			{
				//Let's look at object i
				var thisObject:Object = pageArray[i];
				
				//ADD MENU IMAGES
				trace("check" + i);
				if("menuImage" in thisObject)
				{	
					thisObject.menuImage.alpha = 1;
					thisObject.menuImage.buttonMode = true;
					//makes menuImage's children unselectable aka the subImage mc's i added bc they needed to be able to switch frames with diff brightness. silly.
					for(var k:int = 0; k < thisObject.menuImage.numChildren; k++)
					{
						if(thisObject.menuImage.getChildAt(k) is MovieClip)
						{
							thisObject.menuImage.getChildAt(k).selectable = false;
							thisObject.menuImage.getChildAt(k).mouseEnabled = false;	
						}
					}
					thisObject.menuImage.x = thisObject.line.x + 15;
					thisObject.menuImage.y = thisObject.line.y - thisObject.menuImage.height/2;
					//thisObject.menuImage.addEventListener(MouseEvent.CLICK, menuBtnClicked);
					//thisObject.menuImage.addEventListener(MouseEvent.ROLL_OVER, menuBtnRollOver);
					//thisObject.menuImage.addEventListener(MouseEvent.ROLL_OUT, menuBtnRollOut);
					mainMenuContainer.addChild(thisObject.menuImage);
					//TweenLite.to(thisObject.menuImage, 1, {alpha:1, onComplete:addListeners, onCompleteParams: [thisObject.menuImage]});	
					
					//ADD MENU TITLE TEXT
					thisObject.titleText.alpha = 1;
					thisObject.titleText.buttonMode = true;
					thisObject.titleText.x = thisObject.menuImage.x + thisObject.menuImage.width + 20;
					thisObject.titleText.y = thisObject.line.y;
					if(thisObject.name == "profile")
					{
						thisObject.titleText.x = thisObject.menuImage.x + thisObject.menuImage.width + 8;
					}
					//thisObject.titleText.addEventListener(MouseEvent.CLICK, menuBtnClicked);
					//thisObject.titleText.addEventListener(MouseEvent.ROLL_OVER, menuBtnRollOver);
					//thisObject.titleText.addEventListener(MouseEvent.ROLL_OUT, menuBtnRollOut);
					mainMenuContainer.addChild(thisObject.titleText);

					//TweenLite.to(thisObject.titleText, 1, {alpha:1, onComplete: addListeners, onCompleteParams: [thisObject.titleText]});	
					
				}	
			}
			
			theStage.addChild(mainMenuContainer);
			trace("mainMenuContainer added to stage");
			TweenLite.to(mainMenuContainer, 1, {alpha:1, onComplete: addListeners});
			//unparent();
			
			//theStage.removeChild(getChildByName(pageData.pageObjArray[2].line.name));
			
			
		}
		
		private function addListeners():void
		{
			trace("adding listeners...");
			//trace("numChildren =" + mainMenuContainer.numChildren);
			var currentChild:MovieClip;
			for(var i:int = 0; i < mainMenuContainer.numChildren; i++)
			{
				currentChild = mainMenuContainer.getChildAt(i) as MovieClip;
				//trace("child "+ i + " : " + currentChild.name);
				if(currentChild)
				{
					currentChild.addEventListener(MouseEvent.CLICK, menuBtnClicked);
					currentChild.addEventListener(MouseEvent.ROLL_OVER, menuBtnRollOver);
					currentChild.addEventListener(MouseEvent.ROLL_OUT, menuBtnRollOut);
				}
				if(i == mainMenuContainer.numChildren - 1)
				{
					//unparent();
					creationComplete();
				}
			}
			
			//image.addEventListener(MouseEvent.CLICK, menuBtnClicked);
			//image.addEventListener(MouseEvent.ROLL_OVER, menuBtnRollOver);
			//image.addEventListener(MouseEvent.ROLL_OUT, menuBtnRollOut);
		}
		
		
		private function menuBtnClicked(evt:MouseEvent):void
		{
			pageData.setPageIndex(evt.target.pageIndex);
			trace("from MainMenu - pageIndex: " + pageData.pageIndex);
			dispatchEvent(new Event(MENU_BUTTON_CLICKED));
			
				
		}
		private function menuBtnRollOver(evt:MouseEvent):void
		{
			//trace("roll over target was " + evt.target);
			//trace(evt.target.pageIndex);
			
			//var pageIndex:int = utils.getPageIndex(evt.target, pageData.pageObjArray);
			pageArray[evt.target.pageIndex].menuImage.gotoAndStop("over");
			pageArray[evt.target.pageIndex].titleText.gotoAndStop("over");
			
			//pageData.pageObjArray[pageIndex].titleText.gotoAndStop("over");	
			//testClass.removeSomething();
			
		}
		private function menuBtnRollOut(evt:MouseEvent):void
		{
			pageArray[evt.target.pageIndex].menuImage.gotoAndStop("out");
			pageArray[evt.target.pageIndex].titleText.gotoAndStop("out");
			/*
			var pageIndex:int = utils.getPageIndex(evt.target, pageData.pageObjArray);
			pageData.pageObjArray[pageIndex].menuImage.gotoAndStop("out");
			pageData.pageObjArray[pageIndex].titleText.gotoAndStop("out");
			*/
		}
		
		private function unparent():void
		{
			trace("unparenting main menu container...");
			var totalChildren:int = mainMenuContainer.numChildren;
			for (var i:int = 0; i < totalChildren; i++)
			{
				//trace("menu child " + i + "...");
				var thisChild:DisplayObject = mainMenuContainer.getChildAt(0);
				var thisChildPosition:Array = [thisChild.x, thisChild.y]
				theStage.addChild(thisChild);
				thisChild.x = thisChildPosition[0] + mainMenuContainer.x;
				thisChild.y = thisChildPosition[1] + mainMenuContainer.y;			
			}
			theStage.removeChild(mainMenuContainer);
		}
		
		private function creationComplete():void
		{
			trace("main menu says its ready");
			dispatchEvent(new Event(MENU_COMPLETE));	
		}
		
	}
}