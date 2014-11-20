package anime 
{
	
	import flash.display.Sprite;
	import flash.geom.PerspectiveProjection;
	import flash.geom.Point;
	/**
	 * ...
	 * @author umhr
	 */
	public class Movie extends Sprite 
	{
		
		public function Movie() 
		{
			init();
		}
		private function init():void 
		{
			var pp:PerspectiveProjection = new PerspectiveProjection();
			pp.projectionCenter = new Point(100, 100);
			transform.perspectiveProjection = pp;
			
			addChild(new Cube(100,100));
		}
		public function addRipple(x:int,y:int):void {
			addChild(new Ripple(x,y));
		}
		
	}
	
}