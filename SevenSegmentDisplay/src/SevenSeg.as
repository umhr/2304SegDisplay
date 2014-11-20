package  
{
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class SevenSeg extends Sprite 
	{
		private var _bitmap:Bitmap;
		private var _segManager:SegManager = SegManager.getInstance();
		public function SevenSeg() 
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
			var w:int = _segManager.w;
			var h:int = _segManager.h;
			
			_bitmap = new Bitmap(new BitmapData(w, h, false, 0xFF000000));
			addChild(_bitmap);
			
		}
		private var _colorNum:int = 1;
		public function changeColor():void {
			_colorNum += 2;
			_colorNum = _colorNum % 3;
		}
		public function setSegs(num:int):void {
			if (_bitmap) {
				_segsList.push(num);
			}
		}
		private var _segsList:Vector.<int> = new Vector.<int>();
		private var _currentColorNum:int = -1;
		private var _bitNum:int = -1;
		public function draw():void {
			if (_bitmap) {
				var num:int = 0;
				var n:int = _segsList.length;
				for (var i:int = 0; i < n; i++) 
				{
					num += Math.pow(2, _segsList[i]);
				}
				
				if(_currentColorNum != _colorNum || _bitNum != num){
					_bitmap.bitmapData.draw(_segManager.getSeg(_segsList, _colorNum, num, n));
					//_segManager.copyPixels(_bitmap.bitmapData, _colorNum, num);
					_currentColorNum = _colorNum;
					_bitNum = num;
				}
				_segsList.length = 0;
			}
		}
		
	}
	
}