package plane 
{
	
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.events.Event;
	
	public class ScoreHUD extends MovieClip
	{
		
		private var stageRef:Stage;
		public var s_score:Number = 0;
		public var s_hits:Number = 0;
		private var gm=new GameOver();
		
		
		
		public function ScoreHUD(stageRef:Stage) 
		{
			
			this.stageRef = stageRef;
			
			
			score.text = "0";
			hits.text = "0";
			
			x =0;
			y =0;
			
		}
		public function updateHits(value:Number) : void
		{
			
			s_hits += value;
			if(s_hits==8)
			{
				stageRef.addChild(gm);
				gm.x=stage.stageWidth/2-140;
				gm.y=stage.stageHeight-400;
				stageRef.removeChild(this);
				stageRef.removeChildAt(0);
				//gotoAndStop(2);
			}
			hits.text = String(s_hits);
			
		}
		
		public function updateScore(value:Number) : void
		{
			s_score += value;
			score.text = String(s_score);
		}
		
	}
	
}