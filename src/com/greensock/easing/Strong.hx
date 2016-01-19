package com.greensock.easing;

/**
 * Strong
 */

#if (js)
@:native("Strong")
#end
extern class Strong extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Strong;

	static public var	easeInOut : Strong;
	
	static public var	easeOut : Strong;
	
}