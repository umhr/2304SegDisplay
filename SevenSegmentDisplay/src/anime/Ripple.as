package anime 
{
	
	import a24.tween.Ease24;
	import a24.tween.Tween24;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author umhr
	 */
	public class Ripple extends Sprite 
	{
		public function Ripple(x:int,y:int) 
		{
			this.x = x;
			this.y = y;
			init();
		}
		private function init():void 
		{
			Tween24.tween(this, 3, Ease24._1_SineOut).scale(120).onComplete(onComp).play();
		}
		override public function set scaleX(value:Number):void 
		{
			var b:Number = 10 / Math.sqrt(value * 4);
			b = Math.min(b, 2);
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			graphics.drawCircle(0, 0, value);
			graphics.drawCircle(0, 0, value-b*1);
			graphics.beginFill(0x000000);
			graphics.drawCircle(0, 0, value-b*1);
			graphics.drawCircle(0, 0, value-b*3.5);
			graphics.endFill();
		}
		override public function set scaleY(value:Number):void 
		{
			//super.scaleY = 1;// value;
		}
		
		public function onComp():void {
			graphics.clear();
			this.parent.removeChild(this);
		}
	}
	
}