package com.greensock.easing;

/**
 * Quint
 */

#if (js)
@:native("Quint")
#end
extern class Quint extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Quint;

	static public var	easeInOut : Quint;
	
	static public var	easeOut : Quint;
	
}