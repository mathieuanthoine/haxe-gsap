package com.greensock.easing;

/**
 * Quint
 */
@:native("Quint")
extern class Quint extends Ease 
{

	public function new(); 
	
	static public function	easeIn () : Quint;

	static public function	easeInOut () : Quint;
	
	static public function	easeOut () : Quint;
	
}