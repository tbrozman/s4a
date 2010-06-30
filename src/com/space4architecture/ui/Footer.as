package com.space4architecture.ui
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	
	public class Footer extends MovieClip
	{
		private var theStage:DisplayObjectContainer;
		
		public var footerMC:MovieClip;
		public var footerLogo:FooterLogo;
		public var addressBar:AddressBar;
		public var emailLink:FooterEmailLink;
		
		public static const RESET:String = "Reset";
		
		public function Footer($stage:DisplayObjectContainer)
		{
			theStage = $stage;
			footerMC = new MovieClip;
			footerMC.x = 40;
			footerMC.y = 600;
			footerMC.alpha = 0;
			footerLogo = new FooterLogo();
			footerLogo.x = 0;
			footerLogo.y = 0;
			footerLogo.buttonMode = true;
			footerLogo.addEventListener(MouseEvent.CLICK, restartSite);
			addressBar = new AddressBar();
			addressBar.name = "addressBar";
			addressBar.x = 300;
			addressBar.y = 0;
			emailLink = new FooterEmailLink();
			emailLink.name = "emailLink";
			emailLink.x = addressBar.x + addressBar.width + 5;
			emailLink.y = 0;
			emailLink.addEventListener(MouseEvent.ROLL_OVER, function(evt:MouseEvent){evt.target.gotoAndStop("over")});
			emailLink.addEventListener(MouseEvent.ROLL_OUT, function(evt:MouseEvent){evt.target.gotoAndStop("out")});
			emailLink.buttonMode = true;
			footerMC.addChild(footerLogo);
			footerMC.addChild(addressBar);
			footerMC.addChild(emailLink);
			trace("footer initialized");	
		}
		
		public function fadeIn():void
		{
			theStage.addChild(footerMC);
			TweenLite.to(footerMC, 1, {alpha:1});
		}
		
		private function restartSite(evt:MouseEvent):void
		{
			dispatchEvent(new Event(RESET));
		}
		
		public function fadeOutAddress():void
		{
			TweenLite.to(footerMC.getChildByName("addressBar"), 1, {alpha:0, onComplete: removeImage, onCompleteParams: [footerMC.getChildByName("addressBar") as MovieClip]});
			TweenLite.to(footerMC.getChildByName("emailLink"), 1, {alpha:0, onComplete: removeImage, onCompleteParams: [footerMC.getChildByName("emailLink") as MovieClip]});
		}
		
		private function removeImage($img:MovieClip):void
		{
			footerMC.removeChild($img);
		}
		
	}

}	




