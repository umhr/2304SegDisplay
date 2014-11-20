package  
{
	
	import anime.Movie;
	import anime.Ripple;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	/**
	 * ...
	 * @author umhr
	 */
	public class Animation extends Sprite 
	{
		private var _movie:Movie;
		private var _bitmapData:BitmapData;
		
		public function Animation() 
		{
			//init();
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
		}
		
		public function mouseDown(mX:int, mY:int):void 
		{
			mX -= Main.segCanvasRectangle.x;
			mY -= Main.segCanvasRectangle.y;
			addChild(new Ripple(mX * (Main.samplingWidth / Main.segCanvasRectangle.width), mY * (Main.samplingHeight / Main.segCanvasRectangle.height)));
		}
		public function getBitmapData():BitmapData {
			_bitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight);
			_bitmapData.draw(this);
			return _bitmapData;
		}
		
	}
	
}