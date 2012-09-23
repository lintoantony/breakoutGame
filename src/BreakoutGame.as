/*
@author : linto (lintoka123@gmail.com)
*/
package{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	import com.linto.breakout.controller.GameController;
	import com.linto.breakout.model.Model;
	import com.linto.breakout.view.GameView;
	
	[SWF(width='500',height='400',backgroundColor='#000000',frameRate='40')]
	
	public class BreakoutGame extends Sprite{
		
		public function BreakoutGame():void{
			
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			var gameModel:Model = new Model();
			
			var gameController:GameController = new GameController(gameModel);
			
			var gameView:GameView = new GameView(this.stage, gameController, gameModel);
			this.addChild(gameView);
			
			gameModel.setViewRef(gameView);
			gameController.setViewRef(gameView);
			
		}
	}
}