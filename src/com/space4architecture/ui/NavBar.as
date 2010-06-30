package com.space4architecture.ui 
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import com.space4architecture.opener.Opener;
	import com.space4architecture.ui.MainMenu;
	import com.space4architecture.utils.Utils;
	import com.space4architecture.ui.Footer;
	import com.space4architecture.data.PageData;

	
	public class NavBar extends MovieClip
	{
		private var theStage:DisplayObjectContainer;
		private var pageData:PageData;
		private var navBarContainer:MovieClip;
		private var residentialNavBtn:ResidentialNavBtn;
		private var profileNavBtn:ProfileNavBtn;
		private var pubsNavBtn:PubsNavBtn;
		private var teamNavBtn:TeamNavBtn;
		
		public static const NAV_BUTTON_CLICKED:String = "Nav Button Clicked";
		
		//CONSTRUCTOR
		public function NavBar($stage:DisplayObjectContainer, $pageData:PageData)
		{	
			theStage = $stage;
			pageData = $pageData;
			trace("nav bar initialized");
		}
		
		public function addNavBar():void
		{
			trace("adding nav bar...");
			navBarContainer = new MovieClip();
			navBarContainer.name = "Tony";
			navBarContainer.x = 600;
			navBarContainer.y = 600;
			navBarContainer.mouseEnabled = false;
			
			for(var i:int; i < pageData.pageObjArray.length; i++)
			{
				if("navBtn" in pageData.pageObjArray[i])
				{
					pageData.pageObjArray[i].navBtn.mouseChildren = false;
					pageData.pageObjArray[i].navBtn.buttonMode = true;
				}
			}
			
			//trace("navBar - add res btn");
			residentialNavBtn = pageData.pageObjArray[0].navBtn;
			residentialNavBtn.x = 0;
			residentialNavBtn.y = 0;
			residentialNavBtn.mouseEnabled = true;
			navBarContainer.addChild(residentialNavBtn);
			
			//trace("navBar - add profile btn");
			profileNavBtn = pageData.pageObjArray[1].navBtn;
			profileNavBtn.x = 91;
			profileNavBtn.y = 0;
			navBarContainer.addChild(profileNavBtn);
			
			//trace("navBar - add pubs btn");
			pubsNavBtn = pageData.pageObjArray[3].navBtn;
			pubsNavBtn.x = 168;
			pubsNavBtn.y = 0;
			navBarContainer.addChild(pubsNavBtn);
			
			//trace("navBar - add team btn");
			teamNavBtn = pageData.pageObjArray[4].navBtn;
			teamNavBtn.x = 293;
			teamNavBtn.y = 0;
			navBarContainer.addChild(teamNavBtn);
			
			//trace("add listeners...");
			navBarContainer.addEventListener(MouseEvent.MOUSE_OVER, navBtnRollOver);
			navBarContainer.addEventListener(MouseEvent.MOUSE_OUT, navBtnRollOut);
			navBarContainer.addEventListener(MouseEvent.CLICK, navBtnClicked);
			
			
			navBarContainer.alpha = 0;
			theStage.addChild(navBarContainer);
			navBarContainer.mouseEnabled = true;
			TweenLite.to(navBarContainer, 1, {alpha:1});	
		}
		
		private function navBtnRollOver(evt:MouseEvent):void
		{
			pageData.pageObjArray[evt.target.pageIndex].navBtn.gotoAndStop("over");
		}
		
		private function navBtnRollOut(evt:MouseEvent):void
		{
			pageData.pageObjArray[evt.target.pageIndex].navBtn.gotoAndStop("out");
		}
		private function navBtnClicked(evt:MouseEvent):void
		{
			pageData.setPageIndex(evt.target.pageIndex);
			trace(evt.target.name + " clicked");
			trace(evt.target.pageIndex);
			dispatchEvent(new Event(NAV_BUTTON_CLICKED));	
			
		}
		
	}
}