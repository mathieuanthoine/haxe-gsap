package com.greensock.easing;

/**
 * Quad
 */
@:native("Quad")
extern class Quad extends Ease 
{

	public function new(); 
	
	static public function	easeIn () : Quad;

	static public function	easeInOut () : Quad;
	
	static public function	easeOut () : Quad;
	
}