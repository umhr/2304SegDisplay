package  
{
	import flash.display.BitmapData;
	import flash.display.GraphicsPathCommand;
	import flash.display.Shape;
	import flash.display.StageQuality;
	import flash.filters.BevelFilter;
	import flash.filters.BlurFilter;
	import flash.filters.DropShadowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class SegManager 
	{
		private static var _instance:SegManager;
		public function SegManager(block:Block){init()};
		public static function getInstance():SegManager{
			if ( _instance == null ) {_instance = new SegManager(new Block());};
			return _instance;
		}
		
		private var _bitmapDataList:Vector.<BitmapData> = new Vector.<BitmapData>();
		public var clearBitmapData:BitmapData;
		public var w:int;
		public var h:int;
		private function init():void { };
		public function setup():void
		{
			// 1つの7セグの大きさを確定
			// 画面いっぱいになる比率を算出
			var b:Number = Math.max(Main.stageWidth / 4, Main.stageHeight / 3);
			// 1つの7セグの幅、幅の1.5倍が高さ
			w = (Main.stageWidth / Main.sevenSegWidth) * (b / (Main.stageWidth / 4));
			h = w * 1.5;
			clearBitmapData = new BitmapData(w, h, false, 0xFF111111);
			clearBitmapData.fillRect(new Rectangle(0, 0, w - 1, h - 1), 0x000000);
			
			var star_commands:Vector.<int> = new Vector.<int>(6, true);
			star_commands[0] = GraphicsPathCommand.MOVE_TO;
			star_commands[1] = GraphicsPathCommand.LINE_TO;
			star_commands[2] = GraphicsPathCommand.LINE_TO;
			star_commands[3] = GraphicsPathCommand.LINE_TO;
			star_commands[4] = GraphicsPathCommand.LINE_TO;
			star_commands[5] = GraphicsPathCommand.LINE_TO;
			
			var matrix:Matrix = new Matrix(w / 267, 0, 0, w / 267);
			
			var n:int = 8;
			for (var i:int = 0; i < n; i++) 
			{
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0xFFFFFF);
				switch (i) 
				{
					case 0:shape.graphics.drawPath(star_commands, Vector.<Number>([208, 76, 234, 53, 223, 41, 87, 41, 74, 52, 95, 76,208, 76])); break;
					case 1:shape.graphics.drawPath(star_commands, Vector.<Number>([237,57,210,80,196,183,213,203,231,188,248,69,237,57])); break;
					case 2:shape.graphics.drawPath(star_commands, Vector.<Number>([191,225,177,331,196,352,210,340,226,222,213,206,191,225])); break;
					case 3:shape.graphics.drawPath(star_commands, Vector.<Number>([58,332,32,355,42,367,178,367,192,355,171,332,58,332])); break;
					case 4:shape.graphics.drawPath(star_commands, Vector.<Number>([70,226,53,206,35,221,19,340,28,352,57,327,70,226])); break;
					case 5:shape.graphics.drawPath(star_commands, Vector.<Number>([76,183,90,78,70,56,57,67,40,188,53,203,76,183])); break;
					case 6:shape.graphics.drawPath(star_commands, Vector.<Number>([58, 205, 73, 222, 187, 222, 208, 204, 192, 186, 80, 186,58, 205])); break;
					case 7:shape.graphics.drawCircle(241, 346, 20); break;
					default:
				}
				shape.graphics.endFill();
				
				var bitmapData:BitmapData = new BitmapData(w, h, true, 0x00000000);
				bitmapData.drawWithQuality(shape, matrix, null, null, null, true, StageQuality.HIGH_8X8);
				bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), new BlurFilter(w * 0.2, w * 0.2));
				//bitmapData.applyFilter(bitmapData, bitmapData.rect, new Point(), new DropShadowFilter(2,0,0,1,4,4,50,1,true));
				bitmapData.drawWithQuality(shape, matrix, null, null, null, true, StageQuality.HIGH_8X8);
				_bitmapDataList[i] = bitmapData;
				clearBitmapData.drawWithQuality(shape, matrix, new ColorTransform(0, 0, 0, 1, 0x22, 0x22, 0x22), null, null, true, StageQuality.HIGH_8X8);
			}
			setSpriteSheet(0);
			setSpriteSheet(1);
			setSpriteSheet(2);
		}
		private var sheetBitmapDataList:Vector.<BitmapData> = new Vector.<BitmapData>(3);
		private function setSpriteSheet(colorNum:int):void {
			sheetBitmapDataList[colorNum] = new BitmapData(clearBitmapData.width * 20, clearBitmapData.height * 15,false);
			
			var matrix:Matrix = new Matrix();
			for (var i:int = 0; i < 256; i++) {
				var str:String = "00000000" + i.toString(2);
				str = str.substr(str.length - 8);
				var bitmapData:BitmapData = new BitmapData(clearBitmapData.width, clearBitmapData.height, false,0xFF000000);
				bitmapData.draw(clearBitmapData);
				
				for (var j:int = 0; j < 8; j++) 
				{
					if (str.substr(7 - j, 1) == "1") {
						bitmapData.draw(_bitmapDataList[j], null, _colorTransformList[colorNum]);
					}
				}
				_segBitmapDataList[colorNum][i] = bitmapData;
				
				matrix.tx = (i % 20) * clearBitmapData.width;
				matrix.ty = Math.floor(i / 20) * clearBitmapData.height;
				//sheetBitmapDataList[colorNum].draw(bitmapData, matrix);
			}
		}
		public function copyPixels(bitmapData:BitmapData, colorNum:int, num:int):void {
			bitmapData.copyPixels(sheetBitmapDataList[colorNum], new Rectangle((num % 20) * clearBitmapData.width, Math.floor(num / 20) * clearBitmapData.height, clearBitmapData.width, clearBitmapData.height), new Point(0, 0));
		}
		
		private var _segBitmapDataList:Vector.<Vector.<BitmapData>> = Vector.<Vector.<BitmapData>>([new Vector.<BitmapData>(256, true), new Vector.<BitmapData>(256, true), new Vector.<BitmapData>(256, true)]);
		private var _colorTransformList:Vector.<ColorTransform> = Vector.<ColorTransform>([new ColorTransform(0, 0, 0, 1, 0xB5, 0x2F, 0x62), new ColorTransform(0, 0, 0, 1, 0x62, 0xB5, 0x2F), new ColorTransform(0, 0, 0, 1, 0x2F, 0x62, 0xB5)]);
		public function getSeg(list:Vector.<int>, colorNum:int, num:int, n:int):BitmapData {
			return _segBitmapDataList[colorNum][num];
			if (_segBitmapDataList[colorNum][num] == null) {
				var bitmapData:BitmapData = new BitmapData(clearBitmapData.width, clearBitmapData.height, false);
				bitmapData.draw(clearBitmapData);
				for (var i:int = 0; i < n; i++) 
				{
					bitmapData.draw(_bitmapDataList[list[i]], null, _colorTransformList[colorNum]);
				}
				_segBitmapDataList[colorNum][num] = bitmapData;
			}
			return _segBitmapDataList[colorNum][num];
		}
		
	}
	
}
class Block { };