package com.space4architecture.pages.profile
{
	import com.greensock.TweenLite;
	import flash.display.*;
	import flash.events.*;
	import flash.net.URLRequest;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.*;
	
	
	public class ProfilePage extends MovieClip
	{
		private var theStage:DisplayObjectContainer;
		
		private var contentContainer:MovieClip;
		private var pageContainer:MovieClip;
		private var txt:TextField;
		private var loader:Loader;
		private var _mask:Shape;
		
		protected const TEXT:String = "<p>Space4 Architecture is a full service architectural firm located in New York. The firm was established in 1999, by <a href='#1'>____</a> ,<a href='#1'>____</a> and <a href='#1'>____</a>. The founders of Space4 share a collective professional experience that spans nearly thirty years, and encompasses a wide array of projects including commercial, retail, and residential works.  </p><br/>" + "<p>Combining European and American education together with professional experience in the United States, Space4 has been able to produce an architecture characterized by clean form and functional simplicity, which represent the firm's purpose throughout the creative process.</p><br>" + "<p>The firm has the resources and technology necessary to execute a project from design development through construction completion, including construction documents, construction administration and governmental agency review phases. Careful dedication to all phases of the architectural process enable Space4 to develop its client's architectural needs while adhering firmly to budget and time related constraints. The staff's multi-lingual, interdisciplinary skills and comprehensive CAD capabilities enable the office to interface efficiently and productively with our clients on a diverse range of projects simultaneously.</p><br/>" + "<p>Additionally, the firm maintains relationships, as needed with associate architectural and engineering firms throughout the world for collaborative team efforts.</p>";
		
		protected const _CSS:String = "p { font-family: serif; font-size: 12px; color: #ff0; }";
		
		private var upArrow:Arrow;
		private var downArrow:Arrow;
		
		
		public function ProfilePage($stage:DisplayObjectContainer)
		{
			
			
			
			theStage = $stage;
			pageContainer = theStage.getChildByName("pageContainer") as MovieClip;
			contentContainer = new MovieClip();
			contentContainer.x = 244;
			contentContainer.y = 0;
			pageContainer.addChild(contentContainer);
			drawBackground();
			addImage();
			addText();
			makeScrollBtns();
			
		}
		
		private function drawBackground():void
		{
			var background:Shape = new Shape();
			background.graphics.beginFill(0xf0f0f0);
			background.graphics.drawRect(0, 0, 730, 490);
			background.graphics.endFill();
			contentContainer.addChild(background);
		}
		
		private function addImage():void
		{
			loader = new Loader();
			loader.load(new URLRequest("../../src/com/space4architecture/pages/profile/profilePic.jpg"));
			loader.x = 10;
			loader.y = 10;
			contentContainer.addChild(loader);
		}
		
		private function addText():void
		{
			txt = new TextField;
			var sheet:StyleSheet = new StyleSheet();
			sheet.parseCSS(_CSS);		
			txt.styleSheet = sheet;
			txt.x = 355;
			txt.y = 10;
			txt.wordWrap = true;
			txt.multiline = true;
			txt.htmlText = TEXT;
			txt.width = 250;
			txt.height = 50;
			txt.autoSize = TextFieldAutoSize.LEFT;
			contentContainer.addChild(txt);
			
			_mask = new Shape();
			_mask.graphics.beginFill(0x000000);
			_mask.graphics.drawRect(txt.x, txt.y, txt.width, 150);
			_mask.graphics.endFill();
			contentContainer.addChild(_mask);
			
			txt.mask = _mask;
			
			
			
			/*
			
			*/
			//txt.x = .5*(loader.x + loader.width + contentContainer.width);
				
		}
		
		private function makeScrollBtns():void
		{
			trace("making scroll arrows");
			upArrow = new Arrow();
			downArrow = new Arrow();
			trace("new Arrows declared");
			downArrow.scaleY = -1;
			trace("scaled");
			//downArrow.x = 50;
			//downArrow.y = 50;
		
			
			downArrow.x = txt.x + txt.width;
			downArrow.y = _mask.y + _mask.height;
			upArrow.x = downArrow.x - 25;
			upArrow.y = downArrow.y;
			contentContainer.addChild(upArrow);
			contentContainer.addChild(downArrow);
			trace("arrows on stage?");
			
			
		}
			
	}

}	






