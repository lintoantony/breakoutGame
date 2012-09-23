/*
@author : linto (lintoka123@gmail.com)
*/
package com.linto.breakout.view {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.*;
	import flash.ui.Keyboard;
	
	import com.linto.breakout.model.Model;
	
	public class Paddle extends MovieClip{
		
		private var dir:Number;
		private var speed:Number;
		private var xspeed:Number;
		private var yspeed:Number;
		private var paddle:PaddleMc;
		
		private var viewRef:GameView;
		
		private var stageRef:Stage;
		private var isKeyPressed:Boolean;
		private var keyCode:Number;
		
		public function Paddle(viewRef:GameView, stageRef:Stage) {
			this.stageRef = stageRef;
			this.viewRef = viewRef;
		}
		
		public function startPaddle():void{
			this.createPaddle();
			this.stageRef.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			this.stageRef.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			this.addEventListener(Event.ENTER_FRAME, this.onPaddleAdded);
		}
		
		private function onKeyDown(evt:KeyboardEvent):void{
			this.isKeyPressed = true;
			this.keyCode = evt.keyCode;
		}
		private function onKeyUp(evt:KeyboardEvent):void{
			this.isKeyPressed = false;
		}
		
		private function createPaddle():void{
			this.paddle = new PaddleMc();
			this.addChild(this.paddle);
		}
		
		private function onPaddleAdded(event:Event):void { 
			if (this.isKeyPressed && this.keyCode == Keyboard.RIGHT){
				if(this.x <= Model.RIGHT_BOUNDARY) {
					this.x += Model.PADDLE_SPEED;
				}
			}else if(this.isKeyPressed && this.keyCode == Keyboard.LEFT){
				if(this.x >= Model.LEFT_BOUNDARY) {
					this.x -= Model.PADDLE_SPEED;
				}
			}
		} 
		
	}
	
}
