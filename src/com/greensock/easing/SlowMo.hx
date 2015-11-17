package com.greensock.easing;

/**
 * SlowMo
 */
@:native("SlowMo")
extern class SlowMo extends Ease 
{

	public function new(?linearRatio:Float, ?power:Float, ?yoyoMode:Bool); 
	
	static public function	ease () : SlowMo;
	
}