package plane
{

	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	public class BgStar extends MovieClip
	{

		private var stageRef:Stage;
		private var speed:Number;
		
		public function BgStar(stageRef:Stage)
		{
			this.stageRef = stageRef;
			setupBgStar(true);
			
			addEventListener(Event.ENTER_FRAME, loop);
		}
		
		public function setupBgStar(randomizeY:Boolean = false) : void 
		{
			//inline conditional, looks complicated but it's not.
			y = randomizeY ? Math.random()*stageRef.stageHeight : 0;
			x = Math.random()*stageRef.stageWidth;
			alpha = Math.random();
			rotation = Math.random()*360;
			scaleX = Math.random();
			scaleY = Math.random();
			
			speed = 2 + Math.random()*2;			
		}
		
		public function loop(e:Event) : void 
		{
			y += speed;
			
			if (y > stageRef.stageHeight)
				setupBgStar();
		}
	}
	
}

