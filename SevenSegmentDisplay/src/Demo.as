package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Demo extends Sprite 
	{
		private var _bitmap:Bitmap;
		private var _secondHand:Shape = new Shape();
		private var _minuteHand:Shape = new Shape();
		private var _hourHand:Shape = new Shape();
		
		public function Demo() 
		{
			init();
		}
		private function init():void 
		{
			if (stage) onInit();
			else addEventListener(Event.ADDED_TO_STAGE, onInit);
		}

		private function onInit(event:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onInit);
			// entry point
			
			setShapes();
			stage.addEventListener(Event.ENTER_FRAME, stage_enterFrame);
		}
		private function setShapes():void {
			_bitmap = new Bitmap(new BitmapData(96, 72, false, 0xFFFF0000));
			addChild(_bitmap);
			_secondHand.graphics.beginFill(0xFFFFFF);
			_secondHand.graphics.drawRect( -0.6, -30, 1.2, 30);
			_secondHand.graphics.endFill();
			_secondHand.x = 48;
			_secondHand.y = 36;
			addChild(_secondHand);
			_minuteHand.graphics.beginFill(0xFFFFFF);
			_minuteHand.graphics.drawRect( -1.2, -25, 2.4, 25);
			_minuteHand.graphics.endFill();
			_minuteHand.x = 48;
			_minuteHand.y = 36;
			addChild(_minuteHand);
			_hourHand.graphics.beginFill(0xFFFFFF);
			_hourHand.graphics.drawRect( -2.5, -15, 5, 15);
			_hourHand.graphics.endFill();
			_hourHand.x = 48;
			_hourHand.y = 36;
			addChild(_hourHand);
			
			var dish:Shape = new Shape();
			dish.graphics.beginFill(0xFFFFFF);
			for (var i:int = 0; i < 12; i++) 
			{
				dish.graphics.drawRect(48+30*Math.cos(30*i * (Math.PI/180)),36+30*Math.sin(30*i * (Math.PI/180)),1,1);
			}
			dish.graphics.endFill();
			addChild(dish);
		}
		
		private function stage_enterFrame(e:Event):void 
		{
			var date:Date = new Date();
			_secondHand.rotation = date.seconds * 6;
			_minuteHand.rotation = date.minutes * 6;
			_hourHand.rotation = date.hours * 30 + date.minutes * 0.5;
		}
	}
	
}