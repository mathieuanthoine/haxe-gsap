package com.greensock.easing;

/**
 * Quart
 */
@:native("Quart")
extern class Quart extends Ease 
{

	public function new(); 
	
	static public function	easeIn () : Quart;

	static public function	easeInOut () : Quart;
	
	static public function	easeOut () : Quart;
	
}