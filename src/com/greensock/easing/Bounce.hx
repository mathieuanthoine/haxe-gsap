package com.greensock.easing;

/**
 * Bounce
 */

#if (js)
@:native("Bounce")
#end
extern class Bounce extends Ease
{

	public function new(); 
	
	static public var	easeIn : Bounce;

	static public var	easeInOut : Bounce;
	
	static public var	easeOut : Bounce;
	
	
}