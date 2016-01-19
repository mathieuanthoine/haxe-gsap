package com.greensock.easing;

/**
 * Expo
 */

#if (js)
@:native("Expo")
#end
extern class Expo extends Ease 
{

	public function new(); 
	
	static public var	easeIn : Expo;

	static public var	easeInOut : Expo;
	
	static public var	easeOut : Expo;
	
}