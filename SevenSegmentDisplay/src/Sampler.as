package  
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author umhr
	 */
	public class Sampler 
	{
		private var _list:Vector.<uint>;
		private var _width:int;
		private var _height:int;
		
		[Embed(source="sample4x6.png")]
		private var _imgCls:Class;
		public function Sampler() 
		{
			init();
		}
		
		private function init():void 
		{
			var imgObj:Bitmap = new _imgCls();
			_list = new Vector.<uint>();
			_width = imgObj.width;
			_height = imgObj.height;
			for (var i:int = 0; i < _height; i++) 
			{
				for (var j:int = 0; j < _width; j++) 
				{
					switch (imgObj.bitmapData.getPixel(j, i)) 
					{
						case 0x000000:_list.push(0); break;
						case 0x222222:_list.push(1); break;
						case 0x444444:_list.push(2); break;
						case 0x666666:_list.push(3); break;
						case 0x888888:_list.push(4); break;
						case 0xAAAAAA:_list.push(5); break;
						case 0xCCCCCC:_list.push(6); break;
						case 0xFFFFFF:_list.push(7); break;
					default:
						_list.push(0);
					}
				}
			}
			Main.samplingWidth = Main.sevenSegWidth * _width;
			Main.samplingHeight = Main.sevenSegHeight * _height;
		}
		public function getMapVector():Vector.<uint> {
			var rectangle:Rectangle = new Rectangle(0, 0, _width, _height);
			var result:Bitmap = new Bitmap(new BitmapData(Main.samplingWidth, Main.samplingHeight, false, 0xFF00));
			
			for (var i:int = 0; i < Main.sevenSegHeight; i++) 
			{
				for (var j:int = 0; j < Main.sevenSegWidth; j++) 
				{
					rectangle.x = j * _width;
					rectangle.y = i * _height;
					result.bitmapData.setVector(rectangle, _list);
					incList(_list);
				}
			}
			return result.bitmapData.getVector(result.bitmapData.rect);
		}
		
		private function incList(list:Vector.<uint>):Vector.<uint> {
			var n:int = list.length;
			for (var i:int = 0; i < n; i++) 
			{
				list[i] += 8;
			}
			return list;
		}
	}

}