package com.greensock.easing;

/**
 * RoughEase
 */

#if (js)
@:native("RoughEase")
#end
extern class RoughEase extends Ease
{

	public function new(vars:Dynamic); 
	
	static public var	ease : RoughEase;
	
}