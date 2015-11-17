package com.greensock.easing;

/**
 * Back
 */
@:native("Back")
extern class Back extends Ease
{

	public function new(); 
	
	static public function	easeIn () : Back;

	static public function	easeInOut () : Back;
	
	static public function	easeOut () : Back;
	
}