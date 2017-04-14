package com.greensock.easing;

/**
 * SteppedEase
 */

#if (js)
@:native("SteppedEase")
#end
extern class SteppedEase extends Ease 
{

	public function new(steps:Int); 
	
	static public function config (steps:Int) : SteppedEase;

	
}