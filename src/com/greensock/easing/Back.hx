package com.greensock.easing;

/**
 * Back
 */

#if (js)
@:native("Back")
#end
extern class Back extends Ease
{

	public function new(); 
	
	static public var	easeIn : Back;

	static public var	easeInOut : Back;
	
	static public var	easeOut : Back;
	
}