package com.greensock.easing;

/**
 * Sine
 */
@:native("Sine")
extern class Sine extends Ease 
{

	public function new(); 
	
	static public function	easeIn () : Sine;

	static public function	easeInOut () : Sine;
	
	static public function	easeOut () : Sine;
	
}