package com.greensock.easing;

/**
 * Circ
 */

#if (js)
@:native("Circ")
#end
extern class Circ extends Ease
{

	public function new(); 
	
	static public var	easeIn : Circ;

	static public var	easeInOut : Circ;
	
	static public var	easeOut : Circ;
	
	
}