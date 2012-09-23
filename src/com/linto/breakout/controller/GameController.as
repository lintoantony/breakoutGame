/*
@author : linto (lintoka123@gmail.com)
*/
package com.linto.breakout.controller {
	
	import flash.events.Event;
	
	import com.linto.breakout.view.GameView;
	import com.linto.breakout.model.Model;
	
	public class GameController{
		
		private var modelRef:Model;
		private var viewRef:GameView;
		
		public function GameController(modelRef:Model) {
			this.modelRef = modelRef;
		}
		
		public function setViewRef(viewRef:GameView):void{
			this.viewRef = viewRef;
		}

		public function playAgain():void{
			this.modelRef.initializeValues();
			this.viewRef.restartGame();
		}
		
		public function gotoNextLevel():void{
			this.modelRef.gotoNextLevel();
			this.viewRef.gotoNextLevel();
		}
		
		public function decrimentLife():void{
			this.modelRef.decrimentLife();
		}
	}
	
}


