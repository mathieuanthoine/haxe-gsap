package com.greensock.easing;

/**
 * Cubic
 */

#if (js)
@:native("Cubic")
#end
extern class Cubic extends Ease
{

	public function new(); 
	
	static public var	easeIn : Cubic;

	static public var	easeInOut : Cubic;
	
	static public var	easeOut : Cubic;
	
	
}