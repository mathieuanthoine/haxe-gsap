package com.greensock.easing;

/**
 * Bounce
 */
@:native("Bounce")
extern class Bounce extends Ease
{

	public function new(); 
	
	static public function	easeIn () : Bounce;

	static public function	easeInOut () : Bounce;
	
	static public function	easeOut () : Bounce;
	
	
}