package com.greensock.easing;

/**
 * Sine
 */

#if (js)
@:native("Sine")
#end
extern class Sine extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Sine;

	static public var	easeInOut : Sine;
	
	static public var	easeOut : Sine;
	
}