package com.greensock.easing;

/**
 * Quart
 */

#if (js)
@:native("Quart")
#end
extern class Quart extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Quart;

	static public var	easeInOut : Quart;
	
	static public var	easeOut : Quart;
	
}