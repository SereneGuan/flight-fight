package plane
{

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	
	public class Explosion extends MovieClip
	{
		
		private var stageRef:Stage;
		
		public function Explosion(stageRef:Stage, x:Number, y:Number) 
		{
			this.stageRef = stageRef;
			this.x = x;
			this.y = y;
			addEventListener(Event.ENTER_FRAME, doEx);
		}
		
		private function doEx(e:Event)
		{
			if (currentFrame == totalFrames)
				removeSelf();
		}
		
		private function removeSelf() : void
		{
			removeEventListener(Event.ENTER_FRAME, doEx);
			
			if (stageRef.contains(this))
				stageRef.removeChild(this);
		}
		
	}
	
}