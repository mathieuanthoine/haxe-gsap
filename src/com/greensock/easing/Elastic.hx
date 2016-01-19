package com.greensock.easing;

/**
 * Elastic
 */

#if (js)
@:native("Elastic")
#end
extern class Elastic extends Ease
{

	public function new(); 
	
	static public var	easeIn : Elastic;

	static public var	easeInOut : Elastic;
	
	static public var	easeOut : Elastic;
	
}