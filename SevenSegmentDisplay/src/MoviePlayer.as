package  
{
	
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.geom.Rectangle;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	/**
	 * ...
	 * @author umhr
	 */
	public class MoviePlayer extends Sprite 
	{
		
		private var connection:NetConnection;
		public function MoviePlayer() 
		{
			init();
		}
		private function init():void 
		{
			connection = new NetConnection();
			connection.addEventListener(NetStatusEvent.NET_STATUS, netStatus);
			connection.connect(null);
		}		
		private function netStatus(event:NetStatusEvent):void
		{
			switch (event.info.code)
			{
				case "NetConnection.Connect.Success": 	// 繋ぐことが出来た
					initNetStream();
					break;
				case "NetConnection.Connect.Failed":	// 繋ぐことが出来なかった
					trace("Failed");
					break;
				case "NetConnection.Connect.Rejected":	// 接続を拒否された
					trace("Rejected");
					break;
				case "NetConnection.Connect.Closed":	// 接続を切りました
					trace("Rejected");
					break;
			}
		}
		
		private function initNetStream():void
		{
			_netStream = new NetStream(connection);
			_netStream.client = new Object();
			
			_video = new Video(Main.samplingWidth, Main.samplingHeight);
			_video.attachNetStream(_netStream);
			//addChild(_video);
			_netStream.addEventListener(NetStatusEvent.NET_STATUS, netStream_netStatus);
			_netStream.play("mov3.flv");
			//pause();
		}
		
		private var status:String;
		private function netStream_netStatus(e:NetStatusEvent):void 
		{
			//trace(e.info.code);
			if (e.info.code == "NetStream.Play.Stop") {
				status = "stop";
			}else if (e.info.code == "NetStream.Buffer.Empty") {
				status = "empty";
			}else if (e.info.code == "NetStream.Play.Start") {
				status = "start";
			}
		}
		public function pause():void {
			_netStream.pause();
		}
		public function resume():void {
			_netStream.resume();
			if (status == "empty") {
				status = "play";
				_netStream.play("mov3.flv");
			}
		}
		private var _bitmapData:BitmapData = new BitmapData(Main.samplingWidth, Main.samplingHeight, false);
		private var _video:Video;
		private var _netStream:NetStream;
		private var _rect:Rectangle = new Rectangle(0, 0, Main.samplingWidth, Main.samplingHeight);
		public function getVector(drawableObject:Sprite):Vector.<uint> {
			_bitmapData.draw(_video);
			if (drawableObject && drawableObject.numChildren > 0) {
				_bitmapData.draw(drawableObject);
			}
			return _bitmapData.getVector(_rect);
		}
	}
	
}