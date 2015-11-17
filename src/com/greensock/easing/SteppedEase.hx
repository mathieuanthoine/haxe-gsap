package com.greensock.easing;

/**
 * SteppedEase
 */
@:native("SteppedEase")
extern class SteppedEase extends Ease 
{

	public function new(steps:Int); 
	
	static public function config (steps:Int) : SteppedEase;

	
}