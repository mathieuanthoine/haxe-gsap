package com.greensock.easing;

/**
 * Linear
 */
@:native("Linear")
extern class Linear extends Ease
{

	public function new(); 

	static public function	ease () : Linear;
	
	static public function	easeIn () : Linear;

	static public function	easeInOut () : Linear;
	
	static public function	easeNone () : Linear;
	
	static public function	easeOut () : Linear;	
	
}