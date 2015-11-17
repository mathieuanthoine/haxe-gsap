package com.greensock.easing;

/**
 * Strong
 */
@:native("Strong")
extern class Strong extends Ease 
{

	public function new(); 
	
	static public function	easeIn () : Strong;

	static public function	easeInOut () : Strong;
	
	static public function	easeOut () : Strong;
	
}