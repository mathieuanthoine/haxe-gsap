package com.greensock.easing;

/**
 * SlowMo
 */

#if (js)
@:native("SlowMo")
#end
extern class SlowMo extends Ease 
{

	public function new(?linearRatio:Float, ?power:Float, ?yoyoMode:Bool); 
	
	static public var	ease : SlowMo;
	
}