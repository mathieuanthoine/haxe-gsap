package com.greensock.easing;

/**
 * Circ
 */

@:native("Circ")
extern class Circ extends Ease
{

	public function new(); 
	
	static public function	easeIn () : Circ;

	static public function	easeInOut () : Circ;
	
	static public function	easeOut () : Circ;
	
	
}