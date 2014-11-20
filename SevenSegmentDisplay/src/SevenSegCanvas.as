package  
{
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class SevenSegCanvas extends Sprite 
	{
		private var _sevenSegList:Vector.<SevenSeg> = new Vector.<SevenSeg>();
		public function SevenSegCanvas()
		{
			mouseEnabled = false;
			mouseChildren = false;
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
			var w:int = SegManager.getInstance().w;
			var h:int = SegManager.getInstance().h;
			var stageWidth:int = Main.stageWidth;
			var stageHeight:int = Main.stageHeight;
			// 中央に配置する。
			x = int((stageWidth - w * Main.sevenSegWidth) * 0.5);
			y = int((stageHeight - h * Main.sevenSegHeight) * 0.5);
			x -= (Math.floor(stageWidth / w) % 2 == 1)?int(w * 0.5):0;
			y -= (Math.floor(stageHeight / h) % 2 == 1)?int(h * 0.5):0;
			
			for (var i:int = 0; i < Main.sevenSegHeight; i++) 
			{
				for (var j:int = 0; j < Main.sevenSegWidth; j++) 
				{
					var sevenSeg:SevenSeg = new SevenSeg();
					sevenSeg.x = j * w;
					sevenSeg.y = i * h;
					_sevenSegList.push(sevenSeg);
					if (0 <= sevenSeg.x + x && sevenSeg.x + x + w <= stageWidth) {
						if (0 <= sevenSeg.y + y && sevenSeg.y + y + h <= stageHeight) {
							Main.activeSeg.x = Math.min(Main.activeSeg.x, j);
							Main.activeSeg.y = Math.min(Main.activeSeg.y, i);
							Main.activeSeg.width = Math.max(Main.activeSeg.width, j - Main.activeSeg.x + 1);
							Main.activeSeg.height = Math.max(Main.activeSeg.height, i - Main.activeSeg.y + 1);
							addChild(sevenSeg);
						}
					}
				}
			}
			
			Main.segCanvasRectangle = new Rectangle(x, y, Main.sevenSegWidth * w, Main.sevenSegHeight * h);
		}
		public function setSegs(num:int):void {
			// (num / 8)>>0はMath.floor(num / 8)の替り
			_sevenSegList[(num / 8) >> 0].setSegs(num % 8);
		}
		public function segDraw():void {
			var n:int = _sevenSegList.length;
			for (var i:int = 0; i < n; i++) 
			{
				_sevenSegList[i].draw();
			}
		}
	}
	
}