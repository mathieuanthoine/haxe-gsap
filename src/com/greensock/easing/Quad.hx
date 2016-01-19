package com.greensock.easing;

/**
 * Quad
 */

#if (js)
@:native("Quad")
#end
extern class Quad extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Quad;

	static public var	easeInOut : Quad;
	
	static public var	easeOut : Quad;
	
}